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
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "humidity.fill")
                Text("HUMIDITY")
            }
            .opacity(0.4)
            
            Divider()
            
            Text("\(weather.currentConditions.humidity, specifier: "%.0f")%")
                .font(.title)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            
            Spacer()
            
            Text("The dew point is 2º right now.")
                .foregroundColor(.white)
                .fontWeight(.semibold)
        }
        .frame(width:150, height: 150)
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
    }
}

#Preview {
    ZStack{
        Color.blue
            .ignoresSafeArea()
        HumidityView(weather: MockData.sampleWeather)
    }
    
}
