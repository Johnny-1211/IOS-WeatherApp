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
                    
                    self.backgroundImage(selectedWeather: selectedWeather)
                        .resizable()
                        .ignoresSafeArea()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width, height: proxy.size.height)

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
                                    saveItemsToUserDefaults(weather: city.cities)
                                    isShowingWeatherSheetView = false
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
    
    func saveItemsToUserDefaults(weather: [Weather]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(weather)
            UserDefaults.standard.set(data, forKey: "weatherList")
        } catch {
            print("Error encoding items: \(error)")
        }
    }
    
    func backgroundImage(selectedWeather:Weather) -> Image{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "\(selectedWeather.timezone)")

        
        if let date = dateFormatter.date(from: selectedWeather.currentConditions.datetime) {
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = dateFormatter.timeZone!
            
            let hour = calendar.component(.hour, from: date)
            
            if hour >= 17 || hour < 6 {
                return Image("nightSky")
            } else {
                return Image("sunSky")
            }
        }else{
            return Image("sunSky")
        }
    }
    
}

