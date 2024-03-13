//
//  WeatherSummaryView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 4/3/2024.
//

import SwiftUI

struct WeatherSummaryView: View {
    
    let weather: Weather
    
    var body: some View {
        VStack {
            
            Text("\(subString(Address:weather.resolvedAddress))")
                .font(.title3)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            Text("\(weather.currentConditions.temp, specifier: "%.0f")º")
                .font(.system(size: 80))
                .foregroundColor(.white)
            Text("\(weather.currentConditions.conditions)")
                .foregroundColor(.white)
                .fontWeight(.semibold)
            HStack{
                Text("H:\(weather.days.first!.tempmax, specifier: "%.0f")º")
                Text("L:\(weather.days.first!.tempmin, specifier: "%.0f")º")
            }
            .foregroundColor(.white)
            .fontWeight(.semibold)
        }
    }
    
    func subString(Address address:String) -> String{
        let index = address.firstIndex(of: ",") ?? address.endIndex
        let result = address[..<index]
        return String(result)
    }
    
}

#Preview {
    ZStack{
        Color.blue
            .ignoresSafeArea()
        WeatherSummaryView(weather: MockData.sampleWeather)
    }
}

