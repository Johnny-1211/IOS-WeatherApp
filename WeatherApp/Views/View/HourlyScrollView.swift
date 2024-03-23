//
//  HourlyScrollView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 3/3/2024.
//

import SwiftUI

struct HourlyScrollView: View {
    
    let weather:Weather
    
    var body: some View{
        VStack(spacing: 8){
            
            CustomStackView {
                Label{
                    Text("Hourly Forecast")
                } icon:{
                    Image(systemName: "clock")
                }
            } contentView: {
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 15){
                        ForEach(weather.days.first!.hours, id:\.self) { hours in
                            VStack(spacing: 15){
                                Text("\(formattedTime(from:hours.datetime))")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                
                                weatherImage(for: hours)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .font(.title2)
                                
                                Text("\(hours.temp, specifier: "%.0f")º")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                
                            }
                            
                        }
                        
                    }
                }
                
            }
        }
    }
    
    func formattedTime(from timeString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        guard let date = dateFormatter.date(from: timeString) else {
            return "Invalid time format"
        }
        
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: date)
    }
    
    func weatherImage(for hoursWeather: HoursWeather) -> Image{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        if let date = dateFormatter.date(from: hoursWeather.datetime) {
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = dateFormatter.timeZone!
            
            let hour = calendar.component(.hour, from: date)
            if hour >= 18 || hour < 6 {
                if hoursWeather.conditions.contains("Clear"){
                    return Image(systemName: "moon.stars.fill")
                } else if hoursWeather.conditions.contains("cloudly"){
                    return Image(systemName: "cloud.moon.fill")
                }else if hoursWeather.conditions.contains("Overcast"){
                    return Image(systemName: "smoke.fill")
                }else if hoursWeather.conditions.contains("Snow"){
                    return Image(systemName: "snowflake")
                }else if hoursWeather.conditions.contains("Rain"){
                    return Image(systemName: "cloud.fill")
                }
            } else {
                if hoursWeather.conditions.contains("Clear"){
                    return Image(systemName: "sun.max.fill")
                } else if hoursWeather.conditions.contains("cloudly"){
                    return Image(systemName: "cloud.sun.fill")
                }else if hoursWeather.conditions.contains("Overcast"){
                    return Image(systemName: "smoke.fill")
                }else if hoursWeather.conditions.contains("Snow"){
                    return Image(systemName: "sun.snow.fill")
                }else if hoursWeather.conditions.contains("Rain"){
                    return Image(systemName: "cloud.fill")
                }
            }
        }
        return Image("sunSky")
    }
    
}
    
    
    
