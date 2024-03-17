//
//  CityListView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 9/3/2024.
//

import SwiftUI
import CoreLocation

struct CityListView: View {
    @StateObject var cityListViewModel = CityListViewModel()
    @StateObject var weatherViewModel = WeatherViewModel()
    @EnvironmentObject var locationSearch: LocationSearchService
    @EnvironmentObject var locationHelper: LocationHelper
    @EnvironmentObject var city: City
    @State var isShowingWeatherView = false
    
    @State private var countryName = ""

    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(city.cities, id: \.self){ city in
                        NavigationLink(destination: WeatherView(selectedWeather: city)) {
                            WeatherCitiesListCell(city: city)
                        }
                    }
                }
                .navigationTitle("Weather")
                .searchable(text: $cityListViewModel.searchableText, prompt: Text("Search address")){}
                .onChange(of: cityListViewModel.searchableText) { searchText in
                    cityListViewModel.searchAddress(searchText)
                }
                .overlay {
                    if !cityListViewModel.searchableText.isEmpty{
                        VStack{
                            List(self.cityListViewModel.results) { address in
                                SearchAddressCell(address: address )
                            }
                            .listStyle(.plain)
                            .scrollContentBackground(.hidden)
                        }
                    }
                }
//                .onTapGesture {
//                    withAnimation {
//                        isShowingWeatherView.toggle()
//                    }
//                }
            }
            .onAppear{
                if city.cities.isEmpty{
                    locationHelper.requestPermission()
                    Task{
                        do{
                            try await weatherViewModel.getWeather(location: locationHelper.currentLocation!)

                            try await Task.sleep(nanoseconds: 700_000_000)
                            if let currentWeather = weatherViewModel.weather{
                                city.add(currentWeather)
                            }else{
                                print("invalided weather data")
                            }
                        } catch{
                            print("Error fetching weather data: \(error)")
                            
                        }
                    }
                }
            }
            
        }
    }
    
    func centeredFooterView() -> some View {
        HStack {
            Spacer()
            Text("Learn more about weather data and map data")
                .foregroundColor(.gray)
                .font(.footnote)
            Spacer()
        }
    }
}






