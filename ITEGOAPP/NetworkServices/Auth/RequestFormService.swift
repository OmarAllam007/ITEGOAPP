//
//  RequestFormService.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 01/06/2022.
//

import Foundation

class RequestFormService:BaseService{
    
    var errors = [ErrorResponseModel]()
    var authModel = AuthPersistController()
    
    
    override init() {
        super.init()
        self.request.httpMethod = "POST"
    }
    
    
    func createRequest(requestData:[String:Any]){
        self.errors = []
        
        self.checkInternetConnection { errors in
            
            if errors.count > 0 {
//                errorCompletion(errors)
                return
            }
            
        }
        
        
        let userData = authModel.decodeAuthModel()
        self.request.setValue( "Bearer \(userData?.access_token ?? "")", forHTTPHeaderField: "Authorization")
        self.request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do{
            self.request.url = URL(string: self.url+"create-request")
            
            self.request.httpBody = try JSONSerialization.data(withJSONObject: requestData, options: .prettyPrinted)
            
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
//                            errorCompletion(self.errors)
                            return
                        }
                    }else{

                        do{
                            let newRequest = try JSONDecoder().decode(ServiceRequestModel.self, from: data)
                            // request created
                            print(newRequest)

//                                completion(requests)
                                return
                        }catch{
                            print(error)
                            self.errors.append(ErrorResponseModel(key: "parse_error", value: ["Error when trying to parse data."]))
//                            errorCompletion(self.errors)
                            return
                        }

                    }
                }catch{

                }
                
                
            }.resume()
        }catch{
            print(error)
        }
    }
}
