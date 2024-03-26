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
    @Binding var isShowingMap: Bool
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        TabView(selection:$selectedTabIndex){
            ForEach(city.cities.indices, id: \.self){ index in
                let topEdge = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
                ScrollingWeatherView(topEdge: topEdge, selectedWeather: city.cities[index])
                    .tag(index)
            }
        }
        .toolbar{
            ToolbarItemGroup(placement: .bottomBar) {
                Button{
                    isShowingMap.toggle()
                }label: {
                    Image(systemName: "map")
                }
                
                Spacer()
                
                    PageControlView(
                        currentPage: $selectedTabIndex,
                        numberOfPages: city.cities.count
                    )
                
                Spacer()
            
                    Button{
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "list.bullet")
                    }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}
