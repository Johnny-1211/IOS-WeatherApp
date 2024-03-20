//
//  WeatherCitiesListCell.swift
//  WeatherApp
//
//  Created by Johnny Tam on 15/3/2024.
//

import SwiftUI

struct WeatherCitiesListCell: View {
    let city: Weather
    @EnvironmentObject var locationHelper: LocationHelper
    @State private var countryName = ""
    
    var body: some View {
        Section{
            VStack(alignment:. leading){
                HStack{
                    Text(countryName.isEmpty ? "Loading..." : countryName)
                        .onAppear{
                            locationHelper.getCountryFromCoordinates(latitude: city.latitude, longitude: city.longitude) { country in
                                countryName = country
                            }
                        }
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
    }
    
}


