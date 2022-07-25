//
//  AuthService.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 31/05/2022.
//

import Foundation


struct ErrorResponseModel:Codable {
    let key:String
    let value:[String]
}

struct AuthResponseModel:Codable {
    
    let user:UserModel
    let access_token:String
    let token_type:String
    
}


class AuthService :BaseService{
    var baseUrl = "http://127.0.0.1:8000/api/"
    var errors = [ErrorResponseModel]()
    let authController = AuthPersistController()
    
    override init() {
        super.init()
        self.request.httpMethod = "POST"
    }
    
    func register(userData:Dictionary<String,Any>,completion: @escaping (AuthResponseModel)->(),
                  errorCompletion: @escaping ([ErrorResponseModel])->()){
        self.errors = []
        
        self.checkInternetConnection { errors in
            
            if errors.count > 0 {
                errorCompletion(errors)
                return
            }
            
        }
        
        do{
            self.request.url = URL(string: self.baseUrl+"app_register")
            
            self.request.httpBody = try JSONSerialization.data(withJSONObject: userData, options: .prettyPrinted)
            
            URLSession.shared.dataTask(with: self.request as URLRequest) { data, response, error in
                
                guard let data = data else { return }
                
                
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                    
                    if let errors = json["errors"] as? [String:[String]] {
                        if !errors.isEmpty {
                            self.errors = []
                            errors.forEach { (key: String, value: [String]) in
                                self.errors.append(ErrorResponseModel(key: key, value: value))
                            }
                            errorCompletion(self.errors)
                            return
                        }
                    }else{
                        
                        do{
                            if let userJson = try? JSONDecoder().decode(AuthResponseModel.self, from: data){
                                self.authController.setUser(model: userJson)
                                completion(userJson)
                                return
                            }
                            
                        }
                        
                    }
                }catch{
                    
                }
                
                
            }.resume()
        }catch{
            print(error)
        }
        
    }
    
    
    
    
    func login(userData:Dictionary<String,Any>,completion: @escaping (AuthResponseModel)->(),
                   errorCompletion: @escaping ([ErrorResponseModel])->()){
            self.errors = []
            
            
            self.checkInternetConnection { errors in
                if errors.count > 0 {
                    errorCompletion(errors)
                    return
                }
            }
            
            do{
                
                self.request.url = URL(string: self.baseUrl+"app_login")
                
                self.request.httpBody = try JSONSerialization.data(withJSONObject: userData, options: .prettyPrinted)
                
                URLSession.shared.dataTask(with: self.request as URLRequest) { data, response, error in
                    
                    guard let data = data else { return }
                    
                    
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                        
                        if let errors = json["errors"] as? [String:[String]] {
                            if !errors.isEmpty {
                                self.errors = []
                                errors.forEach { (key: String, value: [String]) in
                                    self.errors.append(ErrorResponseModel(key: key, value: value))
                                }
                                errorCompletion(self.errors)
                                return
                            }
                        }else{
                            
                            do{
                                 let userJson = try JSONDecoder().decode(AuthResponseModel.self, from: data)
                                    completion(userJson)
                                    self.authController.setUser(model: userJson)
                                    return
                            
                            }catch{
                                print(error)
                            }
                            
                        }
                    }catch{
                        print(error)
                    }
                    
                    
                }.resume()
            }catch{
                print(error)
            }
            
        }
}


class AuthPersistController{
    func setUser(model:AuthResponseModel){
        do{
            let userEncodedData = try JSONEncoder().encode(model)
            UserDefaults.standard.set(userEncodedData, forKey: "user")
        }catch{
            print(error)
        }
    }
    
    func decodeAuthModel() -> AuthResponseModel?{
        
        if let data = UserDefaults.standard.data(forKey: "user") {
            
            do{
                let userModel = try? JSONDecoder().decode(AuthResponseModel.self, from: data)
                return userModel
                
            }
            
        }
        return nil

    }
}
