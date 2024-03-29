
import SwiftUI
import CoreLocation

@MainActor final class WeatherViewModel : ObservableObject{
    
    @Published var alertItem: AlertItem?
    @Published var weather: Weather?
    
    func getWeather(location: CLLocation){
        Task{
            do{
                weather = try await NetworkManager.shared.getWeather(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            }catch{
                if let wtError = error as? WTError{
                    switch wtError {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                }
            } else {
                alertItem = AlertContext.invalidResponse
            }
                
            }
        }
    }
}
