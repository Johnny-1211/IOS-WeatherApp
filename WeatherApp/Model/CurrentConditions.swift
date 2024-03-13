//
//  CurrentConditions.swift
//  WeatherApp
//
//  Created by Johnny Tam on 5/3/2024.
//

import Foundation


struct CurrentConditions:Codable, Hashable{
    let temp:Double
    let feelslike:Double
    let humidity:Double
    let windgust:Double
    let visibility:Double
    let uvindex:Int
    let conditions:String
}
