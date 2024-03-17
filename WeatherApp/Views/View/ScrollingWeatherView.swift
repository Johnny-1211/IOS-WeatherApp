//
//  ScrollingWeatherView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 17/3/2024.
//

import SwiftUI

struct ScrollingWeatherView: View {
    
    let selectedWeather : Weather
    
    var body: some View {
            VStack {
                WeatherSummaryView(weather: selectedWeather)
                ScrollView{
                    HourlyScrollView(weather: selectedWeather)
                    DayForecast(weather: selectedWeather)
                    HStack{
                        UVIndexView(weather: selectedWeather)
                        FeelLikeView(weather: selectedWeather)
                    }
                    HStack{
                        VisibilityView(weather: selectedWeather)
                        HumidityView(weather: selectedWeather)
                    }
                }
            }
            .padding()
    }
}

