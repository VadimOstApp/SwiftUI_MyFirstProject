//
//  LoginPage.swift
//  SwiftUI_MyFirstProject
//
//  Created by Vadim Ostashkevich on 24.08.22.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    var body: some View {
        VStack {
            //Welcome back text for 3 half of the screen...
            VStack {
                Text("Welcome\nback")
                    .font(.custom(customFont, size: 55).bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: getRect().height / 3.5)
                    .padding()
                    .background(
                        ZStack {
                            LinearGradient(colors: [
                                Color("MagicMint"),
                                Color("MagicMint").opacity(0.8),
                                Color("DarkBlue")
                            
                            ], startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(.trailing)
                            .offset(y: -25)
                            .ignoresSafeArea()
                            
                            Circle()
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                                .frame(width: 30, height: 30)
                                .blur(radius: 2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                .padding(30)
                            
                            Circle()
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                                .frame(width: 30, height: 30)
                                .blur(radius: 2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(.leading,30)
                        }
                    )
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                
                // Login Page Form...
                VStack(spacing: 15) {
                    Text(loginData.registerUser ? "Register" : "Login")
                        .font(.custom(customFont, size: 22).bold())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    
                    // Customm text Field...
                    
                    CustomTextField(icon: "envelope", title: "Email", hint: "test@test.com", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top, 30)
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "password", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top, 10)
                    
                    // Register Reenter Password
                    if loginData.registerUser {
                        CustomTextField(icon: "lock", title: "Re-Enter Password", hint: "test123", value: $loginData.re_Enter_Password, showPassword: $loginData.showReEnterPassword)
                            .padding(.top, 10)
                    }
                    
                    //Forgot Password Button...
                    Button {
                        loginData.ForgotPassword()
                    } label: {
                        Text("Forgot password?")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("DarkBlue"))
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Login Button...
                    Button {
                        if loginData.registerUser {
                            loginData.Register()
                        } else {
                            loginData.Login()
                        }
                    } label: {
                        Text("Login")
                            .font(.custom(customFont, size: 14).bold())
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white)
                            .background(Color("DarkBlue"))
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    
                    // Register User Button
                    
                    Button {
                        withAnimation {
                            loginData.registerUser.toggle()
                        }
                    } label: {
                        Text(loginData.registerUser ? "Back to login" : "Create account")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("DarkBlue"))
                    }
                    .padding(.top, 8)
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color("MagicMint"))
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DarkBlue"))
        
        //Clearing data when Changes...
        // Optional...
        .onChange(of: loginData.registerUser) { newValue in
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
            
        }
    }
    
    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        //Showing Show Button for password Field..
        .overlay(
            
            Group {
                if title.contains("Password") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundColor(Color("DarkBlue"))
                    })
                    .offset(y: 8)
                }
            }
            
            ,alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
