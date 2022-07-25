//
//  Filters.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 11/06/2022.
//

import Foundation
import SwiftUI

struct FilterButton:View{
    let title:String
    let tag:Int
    
    @Binding var selectedIndex:Int
    
    
    var body: some View {
            Button {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)) {
                    selectedIndex = tag
                }
            
            } label: {
                Text(title)
                    .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width / 2)
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.8))
            }
            .padding(.horizontal,3)
            .padding(.vertical,3)
            .background(selectedIndex == tag ? Color("SelectedButton") : .white)
            .cornerRadius(10)
            .tag(tag)
    }
}
