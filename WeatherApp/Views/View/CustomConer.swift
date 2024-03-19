//
//  CustomConer.swift
//  WeatherApp
//
//  Created by Johnny Tam on 18/3/2024.
//

import SwiftUI

struct CustomConer: Shape {
    
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, 
                                byRoundingCorners:corners ,
                                cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

