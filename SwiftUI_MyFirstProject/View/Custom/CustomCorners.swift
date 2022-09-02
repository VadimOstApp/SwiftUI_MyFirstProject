//
//  CustomCorners.swift
//  SwiftUI_MyFirstProject
//
//  Created by Vadim Ostashkevich on 24.08.22.
//

import SwiftUI
import Foundation

struct CustomCorners: Shape {
    
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

