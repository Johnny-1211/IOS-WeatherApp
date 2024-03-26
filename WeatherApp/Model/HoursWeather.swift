import Foundation

struct HoursWeather:Codable, Hashable{
    let datetime:String
    let temp:Double
    let conditions:String
}
