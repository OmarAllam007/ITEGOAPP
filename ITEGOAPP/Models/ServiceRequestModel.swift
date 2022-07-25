
import Foundation

struct ServiceRequestModel:Codable{
    let id:Int64
    let subject:String
    let description:String
    let requester:RequesterModel
    var created_at:String
    let status:String
    let location:LocationModel
    let status_id:Int64
    let service_name:String

    
    //    let files:[String?]//to be updated
    var replies:[RequestReply] = []
}

struct LocationModel:Codable {
    let lat:String
    let lng:String
}

struct RequesterModel:Codable {
    let id:Int64
    let name:String
    let mobile:String
}

struct RequestReply:Codable {
    let id:Int
    let description:String
    let status:String
    let status_type:Int
    let user:String
    let created_at:String
    let files:[String]
}
