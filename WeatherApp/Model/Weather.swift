import Foundation


struct Weather: Codable,Identifiable, Hashable{
    let id:UUID = UUID()
    let latitude:Double
    let longitude:Double
    let resolvedAddress:String
    let timezone:String
    let description:String
    let days:[DaysWeather]
    let currentConditions: CurrentConditions
}
