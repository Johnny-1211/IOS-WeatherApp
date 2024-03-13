//
//  HoursWeather.swift
//  WeatherApp
//
//  Created by Johnny Tam on 4/3/2024.
//

import Foundation

struct HoursWeather:Codable, Hashable{
    let datetime:String
    let temp:Double
    let conditions:String
}
