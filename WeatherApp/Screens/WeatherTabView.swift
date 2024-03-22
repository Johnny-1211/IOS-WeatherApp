//
//  WeatherTabView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 17/3/2024.
//

import SwiftUI

struct WeatherTabView: View {
    let city : City
    @Binding var selectedTabIndex : Int
    @Binding var currentWeatherCondition: String
    
    var body: some View {
        TabView(selection:$selectedTabIndex){
            ForEach(city.cities.indices, id: \.self){ index in
                let topEdge = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
                ScrollingWeatherView(topEdge: topEdge, selectedWeather: city.cities[index])
                    .tag(index)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
    

    
}
