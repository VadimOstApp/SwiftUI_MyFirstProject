//
//  LoginPageModel.swift
//  SwiftUI_MyFirstProject
//
//  Created by Vadim Ostashkevich on 24.08.22.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    
    //login properties...
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    // Login Call...
    func Login() {
        
    }
    
    func Register() {
        
    }
    
    func ForgotPassword() {
        
    }
    
}
