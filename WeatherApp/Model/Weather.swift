//
//  Weather.swift
//  WeatherApp
//
//  Created by Johnny Tam on 4/3/2024.
//

import Foundation


struct Weather: Codable,Identifiable, Hashable{
    let id:UUID = UUID()
    let latitude:Double
    let longitude:Double
    let resolvedAddress:String
    let description:String
    let days:[DaysWeather]
    let currentConditions: CurrentConditions
}
