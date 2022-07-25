//
//  ShowRequestView.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 06/07/2022.
//

import SwiftUI
import UIKit
import Inject

struct Bookmark: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    var items: [Bookmark]?
    
    // some example websites
    static let apple = Bookmark(name: "Apple", icon: "1.circle")
    static let bbc = Bookmark(name: "BBC", icon: "square.and.pencil")
    static let swift = Bookmark(name: "Swift", icon: "bolt.fill")
    static let twitter = Bookmark(name: "Twitter", icon: "mic")
    
    // some example groups
    static let example1 = Bookmark(name: "Favorites", icon: "star", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    static let example2 = Bookmark(name: "Recent", icon: "timer", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    static let example3 = Bookmark(name: "Recommended", icon: "hand.thumbsup", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
}

struct ShowRequestView: View {
    
    @ObservedObject private var iO = Inject.observer
    let request:ServiceRequestModel!
    let items: [Bookmark] = [.example1, .example2, .example3]
    @State private var currentView = 1
    @ObservedObject var api = RequestsAPI()
    
    var body: some View {
        GeometryReader { gr in
            VStack(spacing: 0){
                if(api.isLoading == true){
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                    
                }
                else{
                    VStack {
                        Picker(selection: $currentView, label: Text("")) {
                            Text("Main").tag(1)
                            Text("Replies").tag(2)
                            Text("History").tag(3)
                        }.pickerStyle(SegmentedPickerStyle())
                    }.padding(.horizontal,10)
                        .padding(.bottom,20)
                    
                    
//                    if(currentView == 1){
//                        RequestMainDetails(request: request)
//                    }else if (currentView == 2){
//                        RequestReplies(request: request)
//                    }
                }
                
               
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Request Number")
            
        }
        
        .enableInjection()
        .background(Color(uiColor: UIColor.rgb(red: 244, green: 247, blue: 254)))
        .onAppear{
            api.showRequest(id: self.request!.id)
            
            
            print(self.api.requestModel)
        }
        
    }
    
}


