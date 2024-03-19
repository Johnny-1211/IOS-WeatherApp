//
//  WeatherTabView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 17/3/2024.
//

import SwiftUI

struct WeatherTabView: View {
    let city : City
    
    var body: some View {
        
        TabView{
            GeometryReader{ proxy in
                let topEdge = proxy.safeAreaInsets.top
                ForEach(city.cities, id: \.self){ city in
                    ScrollingWeatherView(topEdge: topEdge,selectedWeather: city)
                }
            }
//            .ignoresSafeArea(.all, edges: .top)
        }
        .frame(
            width: UIScreen.main.bounds.width
        )
        .tabViewStyle(.page(indexDisplayMode: .always))
        
    }
    
}
