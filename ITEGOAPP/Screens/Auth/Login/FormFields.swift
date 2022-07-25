//
//  FormFields.swift
//  ITEGOAPP
//
//  Created by Omar Khaled on 01/06/2022.
//

import SwiftUI

struct FormFields:View {
    
    @Binding var isRegisterState:Int
    @Binding var name:String
    @Binding var mobile:String
    @Binding var password:String
    @Binding var hasErrors:Bool
    @Binding var errors:[String]
    
    var model:AuthService
    
    @Binding var nagivateToMainController:Bool
    
    var body: some View {
        VStack{
            if isRegisterState == 1 {
                TextField("Name",text: $name)
                    .padding()
                    .background(Color.white.cornerRadius(10))
            }
            
            
            TextField("Mobile",text: $mobile)
                .padding()
                .background(Color.white.cornerRadius(10))
            
            
            SecureField("Password",text: $password)
                .padding()
                .background(Color.white.cornerRadius(10))
            
            HStack{
                Button{
                    if isRegisterState  == 1{
                        let userData = ["name":name, "mobile":mobile, "password":password]
                        model.register(userData: userData) { response in
                            self.nagivateToMainController = true
                        } errorCompletion: { errors in
                            
                            errors.forEach { errorModel in
                                self.errors.append(errorModel.value.joined(separator: "\n\n"))
                            }
                            self.hasErrors = true
                        }

                    }else{
                        let loginData = ["mobile":mobile, "password":password ,"device_name":UUID().uuidString]
                        model.login(userData: loginData) { _ in
                            self.nagivateToMainController = true
                        } errorCompletion: { errors in
                            self.errors = []
                            errors.forEach { errorModel in
                                self.errors.append(errorModel.value.joined(separator: "\n\n"))
                            }
                            self.hasErrors = true
                            //show error issue
                        }
                    }
                    

                } label: {
                    
                    HStack(alignment:.center) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(Font.system(size: 15, weight: .bold))
                            .foregroundColor(.black.opacity(0.7))
                        Text(isRegisterState == 1 ? "Register" : "Login")
                            .font(Font.system(size: 15, weight: .bold))
                            .foregroundColor(.black.opacity(0.7))
                        
                    }
                    .frame(maxWidth:.infinity)
                    .padding()
                    
                }
                
                .background(Color("AuthButton"))
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
                
            }
            
        }
        .padding()
        .cornerRadius(10)
    }
}

