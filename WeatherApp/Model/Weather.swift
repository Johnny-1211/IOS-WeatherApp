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

struct MockData {
    static let sampleWeather = Weather(latitude: 43.6487,
                                       longitude: -79.3855,
                                       resolvedAddress: "Toronto, ON, Canada",
                                       description: "Similar temperatures continuing with a chance of rain tomorrow, Saturday & Sunday.",
                                       days: [DaysWeather(datetime: "2024-03-05",
                                                          tempmax: 13.4,
                                                          tempmin: 6.7,
                                                          temp: 10,
                                                          feelslike: 9,
                                                          humidity: 77,
                                                          windgust: 40.7,
                                                          visibility: 13.2,
                                                          uvindex: 1,
                                                          conditions: "Rain, Partially cloudy",
                                                          description: "Partly cloudy throughout the day with rain.",
                                                          hours: [HoursWeather(datetime: "01:00:00",
                                                                               temp: 8.1,
                                                                               conditions: "Clear"),
                                                                  HoursWeather(datetime: "09:00:00",
                                                                                       temp: 10.1,
                                                                                       conditions: "Clear"),
                                                                  HoursWeather(datetime: "15:00:00",
                                                                                       temp: 13.1,
                                                                                       conditions: "Clear"),
                                                                  HoursWeather(datetime: "20:00:00",
                                                                                       temp: 20.1,
                                                                                       conditions: "Clear")]),
                                              DaysWeather(datetime: "2024-03-13",
                                                                 tempmax: 5,
                                                                 tempmin: 10,
                                                                 temp: 10,
                                                                 feelslike: 9,
                                                                 humidity: 77,
                                                                 windgust: 40.7,
                                                                 visibility: 13.2,
                                                                 uvindex: 1,
                                                                 conditions: "Rain, Partially cloudy",
                                                                 description: "Partly cloudy throughout the day with rain.",
                                                                 hours: [HoursWeather(datetime: "15:00:00",
                                                                                      temp: 8.1,
                                                                                      conditions: "Clear")])],
                                       currentConditions: CurrentConditions(temp: 10.5,
                                                                            feelslike: 8,
                                                                            humidity: 87.1,
                                                                            windgust: 6.5,
                                                                            visibility: 14,
                                                                            uvindex: 0,
                                                                            conditions: "Overcast")
    )
                                       
}
