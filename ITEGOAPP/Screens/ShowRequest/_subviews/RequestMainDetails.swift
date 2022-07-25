//
//  RequestMainDetails.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 25/07/2022.
//

import SwiftUI
import Inject

struct RequestMainDetails: View {
    let request:ServiceRequestModel!
    
    @ObservedObject private var iO = Inject.observer
    
    var body: some View {
        GeometryReader { gr in
            ScrollView(.vertical,showsIndicators: false){
                HStack{
                    Text(request.status ?? "No")
                    
                }
                .frame(maxWidth: .infinity,minHeight: gr.size.height * 0.08)
                .padding(.horizontal,10)
                .shadow(radius: 0.5)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal,10)
                .shadow(color: .gray.opacity(0.15), radius: 5, x: 0, y: 4)
                
                
                VStack{
                    HStack{
                        Text(request.subject)
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }
                    Spacer(minLength: 20)
                    HStack{
                        Text(request.service_name)
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }
                    Spacer(minLength: 20)
                    Divider()
                    Spacer(minLength: 20)
                    HStack{
                        Text(request.service_name)
                            .font(.headline)
                            .foregroundColor(.black.opacity(0.6))
                            .frame(maxWidth: .infinity,alignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity)
                
                .padding(.horizontal,10)
                .padding(.vertical,10)
                
                .background(Color.white)
                
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.15), radius: 5, x: 0, y: 4)
                .padding(.horizontal,10)
                
            }
            
        }
        .enableInjection()
    }
    
}


