//
//  WeatherCitiesListCell.swift
//  WeatherApp
//
//  Created by Johnny Tam on 15/3/2024.
//

import SwiftUI
import SpriteKit

struct WeatherCitiesListCell: View {
    let city: Weather
    @EnvironmentObject var locationHelper: LocationHelper
    @State private var countryName = ""
    @Binding var backgroundImage :String

    var body: some View {
        Section{
            VStack(alignment:. leading){
                HStack{
                    Text(countryName.isEmpty ? "Loading..." : countryName)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(city.currentConditions.temp, specifier: "%.0f")º")
                        .font(.system(size: 50))
                }
                HStack{
                    Text("\(city.currentConditions.conditions)")
                    Spacer()
                    Text("H:\(city.days.first!.tempmax, specifier: "%.0f")º")
                    Text("L:\(city.days.first!.tempmin, specifier: "%.0f")º")
                }
                .padding(.bottom, 15)
            }
        }
        .onAppear{
            locationHelper.getCountryFromCoordinates(latitude: city.latitude, longitude: city.longitude) { country in
                countryName = country
            }
        }
        .listRowBackground(self.background(for:city))
    }
    
    func background(for weather: Weather) -> some View {
        
        let dateFormatter = DateFormatter()
        let currentDate = Date()

        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "\(weather.timezone)")
        
        if let date = dateFormatter.date(from: weather.currentConditions.datetime) {
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = dateFormatter.timeZone!
            
            let hour = calendar.component(.hour, from: date)
            
            if hour >= 17 || hour < 6 {
                backgroundImage = "nightSky"
                return Image("nightSky")
                    .resizable()
                    .scaledToFill()
            } else {
                backgroundImage = "sunSky"
                return Image("sunSky")
                    .resizable()
                    .scaledToFill()
            }
        }else{
            backgroundImage = "sunSky"
            return Image("sunSky")
                .resizable()
                .scaledToFill()
        }
    }
}


