import Foundation


struct CurrentConditions:Codable, Hashable{
    let datetime:String
    let temp:Double
    let feelslike:Double
    let humidity:Double
    let windgust:Double
    let visibility:Double
    let uvindex:Int
    let conditions:String
}
