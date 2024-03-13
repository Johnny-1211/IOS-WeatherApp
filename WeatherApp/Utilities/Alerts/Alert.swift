//
//  Alert.swift
//  WeatherApp
//
//  Created by Johnny Tam on 5/3/2024.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

#Preview {
    Alert()
}
