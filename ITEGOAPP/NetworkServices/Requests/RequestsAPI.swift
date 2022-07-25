//
//  RequestsAPI.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 06/06/2022.
//

import Foundation


class RequestsAPI:ObservableObject  {
    let url:String = "http://127.0.0.1:8000/api/"
    var request = NSMutableURLRequest()
    
    @Published var requests = [ServiceRequestModel]()
    @Published var isLoading = false
    @Published var requestModel:ServiceRequestModel?
    
    
    init(){
        
        self.request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let userData = AuthPersistController().decodeAuthModel()
        
        if let accessToken = userData?.access_token {
            self.request.setValue( "Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        
    }
    
    func getRequests(type:Int){
        self.request.url = URL(string: self.url + "user-requests?type=\(type)")
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        URLSession.shared.dataTask(with:  self.request as URLRequest) { data, res, error in
            
            DispatchQueue.main.async {
                do{
                    self.isLoading = false
                    self.requests = try  JSONDecoder().decode([ServiceRequestModel].self, from: data!)
                }catch{
                    self.isLoading = false
                    print(error.localizedDescription)
                }
            }
            
        }.resume()
        
    }
    
    func showRequest(id:Int64){
        self.request.url = URL(string: self.url + "request/\(id)")
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        
        URLSession.shared.dataTask(with:  self.request as URLRequest) { data, res, error in
            
            DispatchQueue.main.async {
                do{
                    self.requestModel =  try  JSONDecoder().decode(ServiceRequestModel.self, from: data!)
                    self.isLoading = false
                }catch{
                    self.isLoading = false
                    print(error)
                }
            }
            
        }.resume()
    }
    
}
