//
//  OnBoardingPage.swift
//  SwiftUI_MyFirstProject
//
//  Created by Vadim Ostashkevich on 23.08.22.
//

import SwiftUI

let customFont = "Raleway-Regular"

struct OnBoardingPage: View {
    // Showing Login Page...
    @State var showLoginPage: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            Text("Find your\nGadget")
                .font(.custom(customFont, size: 55))
                .fontWeight(.bold)
                .foregroundColor(.white)
//                .multilineTextAlignment(.center)
            
            Image("Onboard")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                withAnimation {
                    showLoginPage = true
                }
            } label: {
                Text("Get Started")
                    .font(.custom(customFont, size: 18))
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("DarkBlue"))
            }
            .padding(.horizontal, 30)
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()
        }
        .padding()
        .padding(.top, getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color("DarkBlue")
        )
        .overlay(
        
            Group {
                if showLoginPage {
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnBoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPage()
            .previewDevice("iPhone 12Pro")
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
