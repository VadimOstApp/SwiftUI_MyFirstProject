//
//  MainPage.swift
//  SwiftUI_MyFirstProject
//
//  Created by Vadim Ostashkevich on 24.08.22.
//

import SwiftUI

struct MainPage: View {
    // Current Tab...
    @State var currentTab: Tab = .Home
    
    // Hiding Tab bar...
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        VStack(spacing: 0) {
            
            // Tab View...
            TabView(selection: $currentTab) {
                
                Home()
                    .tag(Tab.Home)
                
                Text("Liked")
                    .tag(Tab.Liked)
                
                Text("Profile")
                    .tag(Tab.Profile)
                
                Text("Cart")
                    .tag(Tab.Cart)
            }
            
            // Custom Tab bar...
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        // updatig tab...
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            // Applying little shadow at bg...
                            .background(
                                
                                Color("DarkBlue")
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                // blurring...
                                    .blur(radius: 5)
                                // making littlebig...
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("DarkBlue") : Color.black.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

// Making Case Iteratable...
// Tab Cases...
enum Tab: String, CaseIterable {
    
    // Raw Value must be image Name in asset...
    case Home = "Home.Fill"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart.Fill"
}
