//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 15/3/2024.
//

import SwiftUI

struct WeatherDetailView: View {
    let selectedAddress: AddressResult
    @State var offset : CGFloat = 0
    @Binding var isShowingWeatherSheetView : Bool
    @EnvironmentObject var locationHelper: LocationHelper
    @ObservedObject var weatherViewModel = WeatherViewModel()
    @EnvironmentObject var city: City

    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()

            VStack {
                if isShowingWeatherSheetView{
                    HStack{
                        Button{
                            withAnimation{
                                isShowingWeatherSheetView = false
                            }
                        }label: {
                            Text("Cancel")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width: 60, height: 60)
                        }
                        
                        Spacer()
                        
                        Button{
                            if let weather = weatherViewModel.weather{
                                city.add(weather)
                            }else{
                                print("weather cannot be added")
                            }
                        }label: {
                            Text("Add")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width: 60, height: 60)
                        }
                    }
                }
                
                Spacer()
                
                if let selectedWeather = weatherViewModel.weather{
                    WeatherSummaryView(weather: selectedWeather, opacity: getTitleOpacity())
                
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
                }else {
                    Text("No data available")
                }
                
            }
            .padding(.horizontal)
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
        .onAppear{
            Task{
                print("doForwardGeocoding on: \(selectedAddress)")
                 await locationHelper.doForwardGeocoding(address: "\(selectedAddress.title)", completionHandler: { (location, error) in
                    if location == nil {
                        weatherViewModel.weather = nil
                    }else{
                        weatherViewModel.getWeather(location: locationHelper.searchLocation!)
                    }
                    
                })
                try await Task.sleep(nanoseconds: 30_000_000)
            }
        }

    }
    
    func getTitleOpacity() -> CGFloat{
        
        let titleOffset = getTitleOffset()
        
        let progress = titleOffset / 50
        
        let opacity = 1 - progress
        
        return opacity
    }
    
    
    func getTitleOffset() -> CGFloat{
        let progress = offset/120
        let newOffset = (progress <= 1.0 ? progress : 1) * 50
        
        return newOffset
    }
}


