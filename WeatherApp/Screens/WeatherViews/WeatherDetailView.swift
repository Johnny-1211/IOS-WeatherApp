//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 15/3/2024.
//

import SwiftUI

struct WeatherDetailView: View {
    let selectedAddress: AddressResult
    var topEdge:CGFloat
    
    @State var offset : CGFloat = 0
    @Binding var isShowingWeatherSheetView : Bool
    @EnvironmentObject var locationHelper: LocationHelper
    @ObservedObject var weatherViewModel = WeatherViewModel()
    @EnvironmentObject var city: City
    
    var body: some View {
        ZStack{
            if let selectedWeather = weatherViewModel.weather{
                GeometryReader{ proxy in
                    switch selectedWeather.currentConditions.conditions{
                    case "Rain","Partially cloudy" , "Overcast":
                        Image("rainSky")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width, height: proxy.size.height)
                    case "Clear":
                        if selectedWeather.currentConditions.datetime > "17:00:00"{
                            Image("nightSky")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.size.width, height: proxy.size.height)
                        }else{
                            Image("sunSky")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.size.width, height: proxy.size.height)
                        }
                    default:
                        Image("nightSky")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.size.width, height: proxy.size.height)
                    }
                }
                .ignoresSafeArea()
            }
            
            if isShowingWeatherSheetView{
                if let selectedWeather = weatherViewModel.weather{
                    
                    VStack{
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
                        .padding(.horizontal)
                        
                        ScrollView(.vertical, showsIndicators: false){
                            VStack{
                                WeatherSummaryView(weather: selectedWeather, opacity: getTitleOpacity())
                                    .offset(y:-offset)
                                    .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 140 : 0)
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
                            .padding(.top,45)
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
        
        let titleOffset = -getTitleOffset()
        
        let progress = titleOffset / 20
        
        let opacity = 1 - progress
        
        return opacity
    }
    
    
    func getTitleOffset() -> CGFloat{
        if offset < 0 {
            let progress = -offset/140
            
            let newOffset = (progress <= 1.0 ? progress : 1) * 20
            return -newOffset
        }
        return 0
    }
}

