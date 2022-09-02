//
//  Home.swift
//  SwiftUI_MyFirstProject
//
//  Created by Vadim Ostashkevich on 24.08.22.
//

import SwiftUI

struct Home: View {
    @Namespace var animation
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 15) {
                
                //search bar...
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    //Since we need a separate view for search bar...
                    TextField("Search", text: .constant(""))
                        .disabled(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color.gray, lineWidth: 0.8)
                )
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                
                Text("Order online\ncollect in store")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                //Product Tab..
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 18) {
                        
                        ForEach(ProductType.allCases, id: \.self) { type in
                            
                            // Product Type View...
                            ProductTypeView(type: type)
                            
                        }
                    }
                    .padding(.horizontal, 25)
                } //ScrollView
                .padding(.top, 28)
                
                // Products Page...
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 25) {
                        ForEach(homeData.filteredProducts) { product in
                            // Product Card View...
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                }
                .padding(.top, 30)
                
                Button {
                    
                } label: {
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("see more")
                            .font(.custom(customFont, size: 15).bold())
                            .foregroundColor(Color("DarkBlue"))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                    .padding(.top, 10)
                }
                
            } //: VSTACK
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBG"))
        // Updating data shenever tab change...
        .onChange(of: homeData.productType) { newValue in
            homeData.filterProductByType()
        }
    }
    
    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        
        VStack(spacing: 10) {
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
            
            // Moving image to top to look like its fixed at half top...
                .offset(y: -80)
                .padding(.bottom, -80)
            
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.custom(customFont, size: 18))
                .fontWeight(.bold)
                .foregroundColor(Color("DarkBlue"))
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color("ProductBG")
                .cornerRadius(25)
        )

    }
    
    @ViewBuilder
    func ProductTypeView(type: ProductType) -> some View {
        
        Button {
            //Updating Current Type...
            withAnimation {
                homeData.productType = type
            }
            
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 15))
                .fontWeight(.semibold)
            // Changing Color based on Current product Type...
                .foregroundColor(homeData.productType == type ? Color("DarkBlue") : Color.gray)
                .padding(.bottom, 10)
            // Adding Indicator at bottom...
                .overlay(
                    // Adding Matched Geometry Efffect...
                    ZStack {
                        if homeData.productType == type {
                            Capsule()
                                .fill(Color("DarkBlue"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        } else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    } //: ZSTACK
                        .padding(.horizontal, -5)
                    , alignment: .bottom
                )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
