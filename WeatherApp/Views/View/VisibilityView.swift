//
//  VisibilityView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 7/3/2024.
//

import SwiftUI

struct VisibilityView: View {
    let weather:Weather
    var body: some View {
        
        CustomStackView {
            Label{
                Text("VISIBILITY")
                
            } icon: {
                Image(systemName: "eye.fill")
                
            }
        } contentView: {
            VStack(alignment:.leading, spacing: 10){
                Text("\(weather.currentConditions.visibility, specifier: "%.0f") km")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("Perfectly clear view.")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
        }
    }
}
