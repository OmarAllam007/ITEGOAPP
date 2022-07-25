//
//  LoginView.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 31/05/2022.
//

import SwiftUI

struct LoginView: View {
    
    @State private var name =  ""
    @State private var mobile =  "966563238328"
    @State private var password =  "1234567"
    @State private var nagivateToMainController = false
    @State private var isRegisterState = 0
    @State private var hasErrors = false
    @State private var errors:[String] = []
    
    let model = AuthService()
    
    init(){
        
        UITableView.appearance().backgroundColor =  UIColor.rgb(red: 244, green: 247, blue: 254)
        
    }


    
    var body: some View {
        VStack {
            
            VStack{
                
                ZStack {
                    Image("main_pic")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.width * 0.9)
                        .scaledToFit()
                        .offset(y:UIScreen.main.bounds.origin.y)
                }
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .black,.black, .clear]), startPoint: .top, endPoint: .bottom))
                
                
            } //Top Image
            
            Spacer().frame(height:5)
            
            
            FormFields(isRegisterState: $isRegisterState, name: $name, mobile: $mobile, password: $password, hasErrors: $hasErrors, errors: $errors, model: model, nagivateToMainController: $nagivateToMainController)
        
            Spacer()
            
            HStack{
                Text(self.isRegisterState == 0 ? "New to ITEGO" : "Already have account? ")
                Button{
                    self.isRegisterState = self.isRegisterState == 1 ? 0 : 1
                } label: {
                    Text(isRegisterState == 0 ? "Register" : "Login")
                        .foregroundColor(Color("LinkColor"))
                }
                
            }
            .padding()
            .safeAreaInset(edge: .bottom) {
                Text("")
            }// Bottom Text
            
        }
        .ignoresSafeArea()
        .background(Color(uiColor: UIColor.rgb(red: 244, green: 247, blue: 254)))
        .fullScreenCover(isPresented: $nagivateToMainController) {
            withAnimation(.spring()) {
                MainTabbarView()
                    .transition(.slide)
            }
            
        }.alert(isPresented: $hasErrors) {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let messageText = NSAttributedString(
                string: errors.joined(separator: "\n"),
                attributes: [
                    NSAttributedString.Key.paragraphStyle: paragraphStyle,
                    NSAttributedString.Key.foregroundColor : UIColor.black,
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
                ]
            )
            return Alert(title: Text("Error Message"), message: Text(messageText.string), dismissButton: .cancel())
        }

        
        
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewInterfaceOrientation(.portrait)
    }
}
