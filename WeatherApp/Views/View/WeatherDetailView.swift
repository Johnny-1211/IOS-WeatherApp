//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 15/3/2024.
//

import SwiftUI

struct WeatherDetailView: View {
    let selectedAddress: AddressResult
    @Binding var isShowingWeatherSheetView : Bool
    @EnvironmentObject var locationHelper: LocationHelper
    @ObservedObject var viewModel: WeatherViewModel = WeatherViewModel()


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
                            print("isShowingWeatherSheetView::\(isShowingWeatherSheetView)")
                            
                        }label: {
                            Text("Cancel")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width: 60, height: 60)
                        }
                        
                        Spacer()
                        
                        Button{
                            
                        }label: {
                            Text("Add")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width: 60, height: 60)
                        }
                    }
                }
                
                Spacer()
                
                if let weather = viewModel.weather{
                    WeatherSummaryView(weather: viewModel.weather!)
                
                    ScrollView{
                        HourlyScrollView(weather: viewModel.weather!)
                        
                        DayForecast(weather: viewModel.weather!)
                        
                        HStack{
                            UVIndexView(weather: viewModel.weather!)
                            FeelLikeView(weather: viewModel.weather!)
                        }
                        
                        HStack{
                            VisibilityView(weather: viewModel.weather!)
                            HumidityView(weather: viewModel.weather!)
                        }
                    }
                }else {
                    Text("No data available")
                }
                
            }
            .padding(.horizontal)
        }
        .onAppear{
            Task{
                print("doForwardGeocoding on: \(selectedAddress)")
                 await locationHelper.doForwardGeocoding(address: "\(selectedAddress.title)", completionHandler: { (location, error) in
                    if location == nil {
                        print("location not found")
                        viewModel.weather = nil
                    }else{
                        print("Get event from: \(locationHelper.searchLocation!.coordinate.latitude), \(locationHelper.searchLocation!.coordinate.longitude)")
                        viewModel.getWeather(location: locationHelper.searchLocation!)
                    }
                    
                })
                try await Task.sleep(nanoseconds: 30_000_000)
            }
        }
    }
}


