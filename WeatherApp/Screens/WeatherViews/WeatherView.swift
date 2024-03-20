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
    
    
    
    var body: some View {
        ZStack(alignment:.bottom){
            
            GeometryReader{ proxy in
                Image("rainSky")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .ignoresSafeArea()
            .overlay(.ultraThinMaterial)
            
            GeometryReader{_ in
                SpriteView(scene: RainFall(), options: [.allowsTransparency])
            }
            .ignoresSafeArea()
            
            WeatherTabView(city: city)
                    
            VStack{
                Spacer()
                ControlBar(isShowingMap: $isShowingMap)
                    .padding()
                    .background(Color(UIColor.systemBackground))
//                    .ignoresSafeArea(edges: .horizontal)
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
    }
}
