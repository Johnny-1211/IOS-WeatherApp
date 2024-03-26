//
//  DayForecast.swift
//  WeatherApp
//
//  Created by Johnny Tam on 3/3/2024.
//

import SwiftUI

struct DayForecast: View {
    
    let weather:Weather
    
    var body: some View{
        
        VStack(spacing: 8){
            CustomStackView {
                Label{
                    Text("15-DAY FORECAST")
                }   icon:{
                    Image(systemName: "calendar")
                }
            } contentView: {
                VStack(alignment: .leading, spacing: 10){
                    ForEach(weather.days, id: \.self){ day in
                        HStack(spacing: 15){
                            HStack{
                                if day == weather.days.first!{
                                    Text("Today")
                                }else{
                                    Text(convertToWeekdayFormat(dateString: day.datetime)!)
                                }
                            }
                            .font(.title3.bold())
                            .foregroundColor(.white)
                            .frame(width: 60, alignment: .leading)
                            
                            HStack{
                                
                                weatherImage(for: day)
                                    .font(.title3)
                                    .symbolVariant(.fill)
                                    .symbolRenderingMode(.palette)
                                    .frame(width: 30)
                                    
                                Spacer()
                                
                                Text("\(day.tempmin, specifier: "%.0f")º")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.secondary)
                                    .foregroundStyle(.white)
                                
                            }
                            .frame(width: 100)
                            
                            HStack {
                                
                                ProgressView(value: min(max(day.tempmin,0) ,40), total: 40)
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .frame(width: 100)
                                
                                
                                Spacer()
                                
                                Text("\(day.tempmax, specifier: "%.0f")º")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 140)
                        }
                        Divider()
                    }
                    
                }
            }
            
            
        }
    }
    func convertToWeekdayFormat(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "E"
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
    
    func weatherImage(for daysWeather: DaysWeather) -> Image{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        if daysWeather.conditions.contains("Clear"){
            return Image(systemName: "sun.max.fill")
        } else if daysWeather.conditions.contains("cloudly"){
            return Image(systemName: "cloud.fill")
        }else if daysWeather.conditions.contains("Overcast"){
            return Image(systemName: "smoke.fill")
        }else if daysWeather.conditions.contains("Snow"){
            return Image(systemName: "snowflake")
        }
        return Image(systemName: "cloud.fill")
    }
    
    
}


