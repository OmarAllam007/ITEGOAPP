//
//  BaseAuthService.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 31/05/2022.
//
import Foundation

class BaseService {
    let url:String = "http://127.0.0.1:8000/api/"
    
    var request = NSMutableURLRequest()
    
    init() {
        self.request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    func checkInternetConnection(errorCompletion:([ErrorResponseModel])->()){
        if !InternetConnectionManager.isConnectedToNetwork(){
            let error = [ErrorResponseModel.init(key: "Connection Error", value: [
                "Check your Internet connection"
            ])]
            
            errorCompletion(error)
            return
        }
    }
    
}
