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
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "eye.fill")
                Text("VISIBILITY")
            }
            .opacity(0.4)
            
            Divider()
            
            Text("\(weather.currentConditions.visibility, specifier: "%.0f") km")
                .font(.title)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            
            Spacer()
            
            Text("Perfectly clear view.")
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
        VisibilityView(weather: MockData.sampleWeather)
    }
    
}
