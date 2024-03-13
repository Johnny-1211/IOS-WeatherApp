//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Johnny Tam on 4/3/2024.
//

import UIKit

final class NetworkManager{

    static let shared = NetworkManager()
    
    private let weatherURL =  "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Toronto?unitGroup=metric&key=RUBWT6MY6R7DZ3D9JMZGFTXKY&include=obs%2Cfcst%2Chours%2Ccurrent"
    
    private init() {}
  
    func getWeather() async throws -> Weather {
        guard let url = URL(string: weatherURL) else {
            throw WTError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let weather =  try JSONDecoder().decode(Weather.self, from: data)
            return weather
        } catch {
            throw WTError.invalidData
        }
    }
}

