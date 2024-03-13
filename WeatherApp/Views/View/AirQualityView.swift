//
//  AirQualityView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 4/3/2024.
//

import SwiftUI

struct AirQualityView: View {
    let weather:Weather
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "aqi.low")
                Text("AIR QUALITY")
            }
            .opacity(0.4)

            Divider()
            
            Text("2")
            Text("Low Health Risk")
            
            ProgressView(value: 0.2)
                .progressViewStyle(LinearProgressViewStyle())
            
            Text("Air quality index is 2, which is similar to yesterday at about this time.")

        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
    }
}

#Preview {
    ZStack{
        Color.blue
            .ignoresSafeArea()
        AirQualityView(weather: MockData.sampleWeather)
    }
}
