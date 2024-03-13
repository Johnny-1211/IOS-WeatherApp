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
        VStack{
            Text("\(weather.description)")
                .foregroundColor(.white)
                .fontWeight(.semibold)
            
            Divider()
            
            ScrollView(.horizontal){
                HStack(spacing: 10){
                    ForEach(weather.days.first!.hours, id:\.self) { hours in
                        VStack{
                            Text("\(formattedTime(from:hours.datetime))")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)

                            Image(systemName: "cloud.sun.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 40)

                            Text("\(hours.temp, specifier: "%.0f")º")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)

                        }
                    }
                    
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
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


#Preview {
    ZStack{
        Color.blue
            .ignoresSafeArea()
        HourlyScrollView(weather: MockData.sampleWeather)
    }
}

