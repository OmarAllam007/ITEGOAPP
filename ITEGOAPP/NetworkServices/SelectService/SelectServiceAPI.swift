//
//  SelectServiceAPI.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 29/05/2022.
//

import Foundation

class SelectServiceAPI :ObservableObject {
    let url:String = "http://127.0.0.1:8000/api/"
    var request = NSMutableURLRequest()
    @Published var services = [ServiceModel]()
    
    init(){
        self.request.addValue("application/json", forHTTPHeaderField: "Accept")
        self.request.url = URL(string: self.url + "services")
    }
    func getServices(completion:@escaping ([ServiceModel])->()){
        
        guard let url = URL(string: self.url + "services") else {
            print("invalid URL: \(self.url + "services")")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, res, error in
            do{
                let services = try  JSONDecoder().decode([ServiceModel].self, from: data!)
                DispatchQueue.main.async {
                    completion(services)
                }
            }catch{
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
}
