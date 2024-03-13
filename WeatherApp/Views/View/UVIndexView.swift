//
//  UVIndexView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 6/3/2024.
//

import SwiftUI

struct UVIndexView: View {
    let weather : Weather
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "sun.max.fill")
                Text("UV INDEX")
            }
            .opacity(0.4)
            
            Divider()
            
            Text("\(weather.currentConditions.uvindex)")
                .font(.title)
                .foregroundColor(.white)
                .fontWeight(.semibold)
            
            VStack{
                switch weather.currentConditions.uvindex {
                case let uv where uv <= 3:
                    Text("Low")
                case let uv where uv <= 6:
                    Text("Moderate")
                default:
                    Text("High")
                }
            }
            .font(.title2)
            .foregroundColor(.white)
            .fontWeight(.bold)
            
            Spacer()

            ProgressView(value: Double(weather.currentConditions.uvindex)/10)
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [.green,.yellow,.orange,.red,.purple]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                .overlay(
                    GeometryReader { geometry in
                        let dotPosition = CGFloat(Double(weather.currentConditions.uvindex)/10) * geometry.size.width
                        ZStack{
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 6, height: 6)
                            Circle()
                                .stroke(Color.black, lineWidth: 1)
                                .frame(width: 6, height: 6)
                        }
                        .offset(x: dotPosition - 1, y: -1)
                    }
                )
        }
        .frame(width:150, height: 150)
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
    }
}

#Preview {
    ZStack{
        Color.blue
            .ignoresSafeArea()
        UVIndexView(weather: MockData.sampleWeather)
    }
}
