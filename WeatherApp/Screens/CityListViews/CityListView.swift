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
        
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(city.cities, id: \.self){ city in
                        Section(footer:centeredFooterView()){
                            VStack(alignment:. leading){
                                HStack{
                                    VStack(alignment:. leading){
                                        Text(locationHelper.getCountryFromCoordinates(latitude: city.latitude, longitude: city.longitude))
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                    }
                                    Spacer()
                                    Text("\(city.currentConditions.temp, specifier: "%.0f")º")
                                        .font(.system(size: 50))
                                }
                                Spacer()
                                HStack{
                                    Text("\(city.currentConditions.conditions)")
                                    Spacer()
                                    Text("H:\(city.days.first!.tempmax, specifier: "%.0f")º")
                                    Text("L:\(city.days.first!.tempmin, specifier: "%.0f")º")
                                }
                            }
                            
                        }
                        .padding()
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
                
            }
            .onAppear{
//                if cityListViewModel.citiesList.isEmpty{
//                Task{
//                        await weatherViewModel.getWeather(location: locationHelper.currentLocation!)
//                        try await Task.sleep(nanoseconds: 30_000_000)
//                        if let currentWeather = weatherViewModel.weather{
//                            cityListViewModel.citiesList.append(currentWeather)
//                        }
//                    }
//                    
//                }
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

