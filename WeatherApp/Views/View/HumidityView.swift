//
//  HumidityView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 7/3/2024.
//

import SwiftUI

struct HumidityView: View {
    let weather: Weather
    var body: some View {
        
        CustomStackView {
            Label{
                Text("HUMIDITY")

            } icon: {
                Image(systemName: "humidity.fill")

            }
        } contentView: {
            VStack(alignment:.leading, spacing: 10){
                Text("\(weather.currentConditions.humidity, specifier: "%.0f")%")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("The dew point is \(weather.currentConditions.feelslike, specifier: "%.0f")º right now.")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
        }
    }
}

