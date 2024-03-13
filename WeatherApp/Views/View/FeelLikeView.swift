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
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "thermometer.medium")
                Text("FEELS LIKE")
            }
            .opacity(0.4)
            
            Divider()
            
            Text("\(weather.currentConditions.feelslike, specifier: "%.0f")º")
                .font(.title)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            
            Spacer()
            
            Text("Wind is making it feel colder.")
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
        FeelLikeView(weather: MockData.sampleWeather)
    }
}
