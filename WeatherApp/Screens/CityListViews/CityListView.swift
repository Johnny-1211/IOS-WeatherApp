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
//    @EnvironmentObject var locationSearch: LocationSearchService
    @EnvironmentObject var locationHelper: LocationHelper
    @EnvironmentObject var city: City
    
    @State private var countryName = ""
    @State private var selectedTabIndex = 0
    @State private var selectedNavLink: Int?
    @State var backgroundImage = ""
    @State var cityName = ""

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
                    .onDelete(perform: { indexSet in
                        city.cities.remove(atOffsets: indexSet)
                        saveItemsToUserDefaults(weather: city.cities)
                    })
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
            .onAppear {
                retrieveItemsFromUserDefaults()

                if city.cities.isEmpty{
                    locationHelper.requestPermission()
                    Task{
                        do{
                            try await weatherViewModel.getWeather(location: locationHelper.currentLocation!)
                            
                            try await Task.sleep(nanoseconds: 1_000_000_000)
                            if let currentWeather = weatherViewModel.weather{
                                city.add(currentWeather)
                                saveItemsToUserDefaults(weather: city.cities)
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
    
    func saveItemsToUserDefaults(weather: [Weather]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(weather)
            UserDefaults.standard.set(data, forKey: "weatherList")
        } catch {
            print("Error encoding items: \(error)")
        }
    }

    func retrieveItemsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "weatherList") {
            do {
                let decoder = JSONDecoder()
                let decodedItems = try decoder.decode([Weather].self, from: data)
                city.cities = decodedItems
            } catch {
                print("Error decoding items: \(error)")
            }
        }
    }
    
    
    
    func centeredFooterView() -> some View {
        HStack {
            Spacer()
            Text("Learn more about weather data and map data")
                .foregroundColor(.white)
                .font(.footnote)
            Spacer()
        }
    }
}






