//
//  MainTabbarView.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 29/05/2022.
//

import SwiftUI

struct MainTabbarView: View {
    init() {
           UITabBar.appearance().backgroundColor = UIColor.rgb(red: 244, green: 247, blue: 254)
       }
    
    var body: some View {
        TabView {
            SelectService()
                .tabItem {
                    Label {
                        Text("Home")
                    } icon: {
                        Image(systemName: "house")
                    }

                }
            
            RequestsMainView()
                .tabItem {
                    Label {
                        Text("Requests")
                    } icon: {
                        Image(systemName: "list.bullet.indent")
                    }

                }
            
            Text("Here2")
                .tabItem {
                    Label {
                        Text("Profile")
                    } icon: {
                        Image(systemName: "person")
                    }

                }
        }
    }
}

struct MainTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbarView()
    }
}
