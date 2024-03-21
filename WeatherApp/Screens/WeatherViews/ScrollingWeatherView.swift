//
//  ScrollingWeatherView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 17/3/2024.
//

import SwiftUI
import SpriteKit

struct ScrollingWeatherView: View {
    
    @State var offset:CGFloat = 0
    var topEdge:CGFloat
    let selectedWeather : Weather
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    WeatherSummaryView(weather: selectedWeather,opacity: getTitleOpacity())
                        .offset(y:-offset)
                        .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 120 : 0)
                        .offset(y: getTitleOffset())
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
                .padding(.top,25)
                .padding(.top, topEdge)
                .padding([.horizontal,.bottom])
                .padding(.bottom, 20)
                .overlay{
                    GeometryReader{ proxy -> Color in
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async{
                            self.offset = minY
                        }
                        return Color.clear
                    }
                }
            }
    }
    
    func getTitleOpacity() -> CGFloat{
        
        let titleOffset = -getTitleOffset()
        
        let progress = titleOffset / 20
        
        let opacity = 1 - progress
        
        return opacity
    }
    
    
    func getTitleOffset() -> CGFloat{
        if offset < 0 {
            let progress = -offset/120
            
            let newOffset = (progress <= 1.0 ? progress : 1) * 20
            
            return -newOffset
        }
        return 0
    }
}

