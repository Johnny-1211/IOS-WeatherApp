//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 15/3/2024.
//

import SwiftUI

struct WeatherDetailView: View {
    @StateObject private var selectedWeather: Weather
    @Binding var selectedAddress: AddressResult
    @Binding var isShowingWeatherSheetView : Bool
    
    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()
            
            VStack {
                if isShowingWeatherSheetView{
                    HStack{
                        Button{
                            isShowingWeatherSheetView = false
                        }label: {
                            Text("Cancel")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width: 60, height: 60)
                        }
                        
                        Spacer()
                        
                        Button{

                        }label: {
                            Text("Add")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width: 60, height: 60)
                        }
                    }
                }
                
                Spacer()
                                    
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
                .padding(.horizontal)
        }
    } 
}


