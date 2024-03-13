//
//  City.swift
//  WeatherApp
//
//  Created by Johnny Tam on 10/3/2024.
//

import SwiftUI

final class City: ObservableObject {
    
    @Published var cities : [Weather] = []
    
    func add(_ weather:Weather){
        cities.append(weather)
    }
    
    func deleteItem(at offsets: IndexSet){
        cities.remove(atOffsets: offsets)
    }
    
    
}

