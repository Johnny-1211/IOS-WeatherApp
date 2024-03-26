
import Foundation


struct DaysWeather: Codable, Hashable{
    let datetime:String
    let tempmax:Double
    let tempmin:Double
    let temp:Double
    let feelslike:Double
    let humidity:Double
    let windgust:Double
    let visibility:Double
    let uvindex:Int
    let conditions:String
    let description:String
    let hours:[HoursWeather]
}
