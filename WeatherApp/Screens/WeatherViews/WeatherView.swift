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

    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()
            
            VStack {
                if let weather = viewModel.weather{
                    
                    WeatherSummaryView(weather: weather)
                    
                    ScrollView{
                        HourlyScrollView(weather: weather)
                        
                        DayForecast(weather: weather)
                        
                        HStack{
                            UVIndexView(weather: weather)
                            FeelLikeView(weather: weather)
                        }
                        
                        HStack{
                            VisibilityView(weather: weather)
                            HumidityView(weather: weather)
                        }
                    }
                    }else {
                        Text("No data available")
                    }
                }
                .padding(.horizontal)
                .task {
                    viewModel.getWeather()
                }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
        
    }
}
