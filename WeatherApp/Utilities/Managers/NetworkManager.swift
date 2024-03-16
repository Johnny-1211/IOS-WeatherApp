//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Johnny Tam on 4/3/2024.
//

import UIKit

final class NetworkManager{

    static let shared = NetworkManager()
    let API_KEY = "RUBWT6MY6R7DZ3D9JMZGFTXKY"
    var lat: Double = 0.0
    var lng: Double = 0.0
    private var weatherURL: String {  return "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(lat)%2C\(lng)?unitGroup=metric&key=\(API_KEY)&include=obs%2Cfcst%2Chours%2Ccurrent"
    }
    
    private init() {}
  
    func getWeather(lat:Double, lng:Double) async throws -> Weather {
        self.lat = lat
        self.lng = lng
        
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

