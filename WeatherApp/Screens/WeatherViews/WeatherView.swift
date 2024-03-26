//
//  ContentView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 3/3/2024.
//

import SwiftUI
import SpriteKit

/// https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Toronto?unitGroup=metric&key=RUBWT6MY6R7DZ3D9JMZGFTXKY&include=obs%2Cfcst%2Chours%2Ccurrent
///


struct WeatherView: View {
    let selectedWeather : Weather
    
    @StateObject var weatherViewModel = WeatherViewModel()
    @EnvironmentObject var city:City
    @State var isShowingMap = false
    @State var currentWeatherCondition = ""
    @Binding var selectedTabIndex : Int
    
    @Binding var backgroundImage :String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment:.bottom){
            
            GeometryReader{ proxy in
                
                Image(backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .ignoresSafeArea()
            
            if selectedWeather.currentConditions.conditions.contains("Rain"){
                GeometryReader{_ in
                    SpriteView(scene: RainFall(), options: [.allowsTransparency])
                        .ignoresSafeArea()
                }
            }else if selectedWeather.currentConditions.conditions.contains("Snow"){
                GeometryReader{_ in
                    SpriteView(scene: RainFall(), options: [.allowsTransparency])
                        .ignoresSafeArea()
                }
            }
            
            WeatherTabView(city: city, selectedTabIndex: $selectedTabIndex, currentWeatherCondition: $currentWeatherCondition, isShowingMap: $isShowingMap)
                .onChange(of: selectedTabIndex) { newIndex in
                    currentWeatherCondition = city.cities[newIndex].currentConditions.conditions
                }
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .bottom, content: {
            Color.clear
                .frame(height: 0)
                .background(.bar)
                .border(Color.black)
        })
        .alert(item: $weatherViewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
        .onAppear{
            currentWeatherCondition = selectedWeather.currentConditions.conditions
        }
    }
    

    
}
