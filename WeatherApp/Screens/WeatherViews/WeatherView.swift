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
    @State private var currentWeatherCondition = ""
    @Binding var selectedTabIndex : Int

    
    var body: some View {
        ZStack(alignment:.bottom){
            
            GeometryReader{ proxy in
                switch currentWeatherCondition{
                case "Rain","Partially cloudy" , "Overcast":
                    Image("rainSky")
                        .resizable()
                        .ignoresSafeArea()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                case "Clear":
                    if selectedWeather.currentConditions.datetime > "17:00:00" &&
                        selectedWeather.currentConditions.datetime < "24:00:00"{
                        Image("nightSky")
                            .resizable()
                            .ignoresSafeArea()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width, height: proxy.size.height)
                    }else{
                        Image("sunSky")
                            .resizable()
                            .ignoresSafeArea()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width, height: proxy.size.height)
                    }
                default:
                    Image("nightSky")
                        .resizable()
                        .ignoresSafeArea()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                }
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

            WeatherTabView(city: city, selectedTabIndex: $selectedTabIndex, currentWeatherCondition: $currentWeatherCondition)
                
                VStack{
                    Spacer()
                    ControlBar(isShowingMap: $isShowingMap)
                        .padding()
                        .background(Color(UIColor.systemBackground))
                    Spacer()
                        .frame(height: 2)
                }
            }
                .padding(.horizontal)
                .navigationBarBackButtonHidden(true)
                .ignoresSafeArea(edges: .bottom)
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
