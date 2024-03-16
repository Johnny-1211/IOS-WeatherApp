//
//  ContentView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 3/3/2024.
//

import SwiftUI

/// https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Toronto?unitGroup=metric&key=RUBWT6MY6R7DZ3D9JMZGFTXKY&include=obs%2Cfcst%2Chours%2Ccurrent
///


struct WeatherView: View {

    @StateObject var viewModel = WeatherViewModel()
    let selectedWeather : Weather
    
    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()
            
            VStack {
//                if let weather = viewModel.weather{
                    
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
//                    }else {
//                        Text("No data available")
//                    }
                }
                .padding(.horizontal)

        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
        
    }
}
