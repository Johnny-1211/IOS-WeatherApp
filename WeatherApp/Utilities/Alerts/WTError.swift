//
//  WTError.swift
//  WeatherApp
//
//  Created by Johnny Tam on 4/3/2024.
//

import Foundation

enum WTError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
