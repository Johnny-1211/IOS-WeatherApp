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
    
    @State private var countryName = ""
    @State private var selectedTabIndex = 0
    @State private var selectedNavLink: Int?
    @State var backgroundImage = ""

    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(city.cities.indices, id: \.self){ index in
                        WeatherCitiesListCell(city: city.cities[index], backgroundImage: $backgroundImage)
                            .background(
                                NavigationLink("",destination: WeatherView(selectedWeather: city.cities[index], selectedTabIndex: $selectedTabIndex, backgroundImage: $backgroundImage), tag: index, selection: $selectedNavLink)
                                    .opacity(0)
                                    
                            )
                            .tag(index)
                    }
                }
                .listRowSpacing(4)
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






