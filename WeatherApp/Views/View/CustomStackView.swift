//
//  CustomStackView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 18/3/2024.
//

import SwiftUI

struct CustomStackView<Title:View, Content:View>: View {
    var titleView:Title
    var contentView:Content
    
    @State var topOffset: CGFloat = 0
    @State var bottomOffset: CGFloat = 0
    
    
    
    init(@ViewBuilder titleView: @escaping ()-> Title,@ViewBuilder contentView: @escaping () -> Content) {
        self.titleView = titleView()
        self.contentView = contentView()
    }
    
    var body: some View {
        VStack(spacing: 0){
            
            titleView
                .font(.callout)
                .lineLimit(1)
                .frame(height: 38)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .background(.ultraThinMaterial,
                            in: CustomConer(corners: [.topLeft,.topRight],
                                            radius: 12))
            
            VStack{
                Divider()
                
                contentView
                    .padding()
            }
            .background(.ultraThinMaterial,in:
                            CustomConer(corners: [.bottomLeft,.bottomRight],
                                        radius: 12))
        }
        .colorScheme(.dark)
        .cornerRadius(12)
        .offset(y:topOffset >= 120 ? 0 : -topOffset)
        .background(
            
            GeometryReader{ proxy -> Color in
                
                let minY = proxy.frame(in: .global).minY
                
                DispatchQueue.main.async{
                    self.topOffset = minY
                }
                
                return Color.clear
                
            }
            
        )
    }
}


