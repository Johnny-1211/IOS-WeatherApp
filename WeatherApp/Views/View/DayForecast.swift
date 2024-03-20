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
                                Image(systemName: "sun.max")
                                    .font(.title3)
                                    .symbolVariant(.fill)
                                    .symbolRenderingMode(.palette)
                                    .frame(width: 30)
                                Spacer()
                                
                                Text("\(day.tempmin, specifier: "%.0f")º")
                                    .font(.title3.bold())
                                    .foregroundStyle(.secondary)
                                    .foregroundStyle(.white)
                                
                            }
                            .frame(width: 100)
                            
                            HStack {
                                
                                ProgressView(value: 0.6)
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .frame(width: 100)
                                
                                Spacer()
                                
                                Text("\(day.tempmax, specifier: "%.0f")º")
                                    .font(.title3.bold())
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
}

