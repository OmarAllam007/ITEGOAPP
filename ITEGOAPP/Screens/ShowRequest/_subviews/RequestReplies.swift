//
//  RequestReplies.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 25/07/2022.
//

import SwiftUI
import Inject

struct RequestReplies: View {
    @ObservedObject private var iO = Inject.observer
    let request:ServiceRequestModel?
    
    var body: some View {
        GeometryReader { gr in
            VStack{
                HStack{
                    Text("Status and Icond")
                        .frame(width: gr.size.width,alignment: .leading)
                        
                }
                
                .frame(maxWidth: .infinity,minHeight: gr.size.height * 0.08)
                .padding(.horizontal,10)
                .shadow(radius: 0.5)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal,10)
                .shadow(color: .gray.opacity(0.15), radius: 5, x: 0, y: 4)
            }
        }.enableInjection()
        
    }
}
