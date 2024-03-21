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
                                
                                Image(systemName: "cloud.sun.fill")
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
}



