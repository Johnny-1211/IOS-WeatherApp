//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Johnny Tam on 3/3/2024.
//

import SwiftUI

@main
struct WeatherApp: App {
    
    let locationHelper = LocationHelper()
    var city = City()
    let locationSearch = LocationSearchService()
    var body: some Scene {
        WindowGroup {
            CityListView()
                .environmentObject(city)
                .environmentObject(locationHelper)
                .environmentObject(locationSearch)
        }
    }
}
