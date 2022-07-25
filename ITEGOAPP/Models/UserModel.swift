//
//  UserModel.swift
//  ITEGO
//
//  Created by Omar Khaled on 17/05/2022.
//

import Foundation


struct UserModel:Codable{
    let id:Int64
    let name:String
    let mobile:String
    let profile_url:String?
    
}
