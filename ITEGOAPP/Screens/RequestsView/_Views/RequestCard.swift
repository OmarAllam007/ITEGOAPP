//
//  RequestCard.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 06/07/2022.
//

import SwiftUI

struct RequestCard: View {
    let request:ServiceRequestModel
    
    fileprivate func getStatusColor(status_id:Int64) -> Color {
        if status_id == 1{
            return Color("MainBGColor")
        }
        if status_id == 2{
            return .orange.opacity(0.5)
        }
        if status_id == 3{
            return .green.opacity(0.5)
        }
        else{
            return Color("MainBGColor")
        }
    }
    
    var body: some View {
        NavigationLink(destination: ShowRequestView(request: request)) {
            VStack(spacing:20){
                HStack{
                    Text("#\(request.id)")
                        .bold()
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(request.created_at)")
                        .foregroundColor(.black.opacity(0.7))
                    
                }
                
                HStack{
                    Text("\(request.subject)")
                        .lineLimit(1)
                        .foregroundColor(.black)
                    Spacer()
                }
                
                HStack{
                    Text("\(request.service_name)")
                        .bold()
                        .foregroundColor(.black.opacity(0.5))
                    Spacer()
                    
                }
                HStack(spacing:0){
                    Spacer()
                    Text("\(request.status)")
                        .foregroundColor(.black.opacity(0.6))
                        .bold()
                        .cornerRadius(5)
                    Spacer()
                        
                }
                .padding(.vertical,2)
                .padding(.horizontal,3)
                .background(getStatusColor(status_id: request.status_id))
                .cornerRadius(5)
                
            }
            .padding()
            .background(.white)
            .cornerRadius(5)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing:10))
            .shadow(color: .gray.opacity(0.2), radius: 2, x: 1, y: 3)
        }
        
    }
}

