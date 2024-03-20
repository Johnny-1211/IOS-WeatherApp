//
//  FeelLikeView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 7/3/2024.
//

import SwiftUI

struct FeelLikeView: View {
    let weather:Weather
    var body: some View {
        
        CustomStackView {
            Label{
                Text("FEELS LIKE")

            } icon: {
                Image(systemName: "thermometer.medium")

            }
        } contentView: {
            VStack(alignment:.leading, spacing: 10){
                Text("\(weather.currentConditions.feelslike, specifier: "%.0f")º")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("Wind is making it feel colder.")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
        }
    }
}


