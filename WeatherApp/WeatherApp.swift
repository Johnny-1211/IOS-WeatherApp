

import SwiftUI

@main
struct WeatherApp: App {
    
    let locationHelper = LocationHelper()
    var city = City()

    var body: some Scene {
        WindowGroup {
            CityListView()
                .environmentObject(city)
                .environmentObject(locationHelper)
        }
    }
}
