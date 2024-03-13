//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Johnny Tam on 4/3/2024.
//

import SwiftUI

@MainActor final class WeatherViewModel : ObservableObject{
    
    @Published var alertItem: AlertItem?
    @Published var weather: Weather?
    
    func getWeather(){
        Task{
            do{
                weather = try await NetworkManager.shared.getWeather()
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
