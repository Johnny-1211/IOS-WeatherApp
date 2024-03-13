//
//  DayForecast.swift
//  WeatherApp
//
//  Created by Johnny Tam on 3/3/2024.
//

import SwiftUI

struct DayForecast: View {
    
    let weather:Weather
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "calendar")
                Text("15-DAY FORECAST")
            }
            .opacity(0.4)

            Divider()
                .padding(.horizontal)

            ForEach(weather.days, id: \.self){ day in
                HStack{
                    HStack{
                        if day == weather.days.first!{
                            Text("Today")
                        }else{
                            Text(convertToWeekdayFormat(dateString: day.datetime)!)
                        }
                    }
                    .foregroundColor(.white)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    Spacer()
                    
                    HStack{
                        Image(systemName: "sun.max")
                            .frame(width: 20, height: 20)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("\(day.tempmin, specifier: "%.0f")º")
                            .opacity(0.4)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                    }
                    .frame(width: 100)
                    
                    HStack{
                        ProgressView(value: 0.6)
                            .progressViewStyle(LinearProgressViewStyle())
                            .frame(width: 100)
                        
                        Spacer()
                        
                        Text("\(day.tempmax, specifier: "%.0f")º")
                            .foregroundColor(.white)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .frame(width: 135)
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
    }
    
    func convertToWeekdayFormat(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "E" // "E" represents the abbreviated weekday name (e.g., "Thu")
            return dateFormatter.string(from: date)
        }
        
        return nil
    }

}

#Preview {
    ZStack{
        Color.blue
            .ignoresSafeArea()
        DayForecast(weather: MockData.sampleWeather)
    }
}
