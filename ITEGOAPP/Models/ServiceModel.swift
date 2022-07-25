//
//  Service.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 29/05/2022.
//

import Foundation

struct ServiceModel:Codable,Identifiable {
    let id:Int64
    let name:String
    let description:String
    let image:String?
    let sub_services:[SubServiceModel]
}

struct SubServiceModel:Codable,Identifiable {
    let id:Int64
    let name:String
    let description:String
    let image:String?
}
