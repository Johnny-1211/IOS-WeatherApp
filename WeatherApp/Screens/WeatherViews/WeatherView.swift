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
    let selectedWeather : Weather
    
    @StateObject var weatherViewModel = WeatherViewModel()
    @EnvironmentObject var city:City
    @State var isShowingMap = false
    
    var body: some View {
        ZStack{
            TabView{
                ForEach(city.cities, id: \.self){ city in
                    ScrollingWeatherView(selectedWeather: city)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .bottomBar){
                    HStack{
                        Button{
                            isShowingMap.toggle()
                        }label: {
                            Image(systemName: "map")
                        }
                        .fullScreenCover(isPresented: $isShowingMap){
                            WeatherMapView()
                        }
                        
                        Spacer()
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "list.bullet")
                        }
                    }
                }
            }
            .background(Color.blue)
        }
        .padding(.horizontal)
        .alert(item: $weatherViewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}
