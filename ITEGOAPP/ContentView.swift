//
//  ContentView.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 29/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    init(){
//        UserDefaults.standard.removeObject(forKey: "user")
    }
    
    var body: some View {
//        let _ = print(UserDefaults.standard.bool(forKey: "user"))
        if (UserDefaults.exists(key: "user")){
            
            MainTabbarView()
        }else{
            LoginView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
