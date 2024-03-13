//
//  CityListView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 9/3/2024.
//

import SwiftUI

struct CityListView: View {

    @EnvironmentObject var city: City
//    @StateObject var viewModel = CityListViewModel()

    
    var body: some View {
        NavigationStack{
            VStack{
                Section{
                    List{
                        ForEach(city.cities){ city in
                            Section(footer:centeredFooterView()){
                                VStack(alignment:. leading){
                                    HStack{
                                        VStack(alignment:. leading){
                                            Text("My Location")
                                                .font(.system(size: 30))
                                                .fontWeight(.bold)
                                            Text("York")
                                        }
                                        Spacer()
                                        Text("3º")
                                            .font(.system(size: 50))
                                    }
                                    Spacer()
                                    HStack{
                                        Text("Colder tmorrow, with a height of 3º")
                                        Spacer()
                                        Text("H:9º")
                                        Text("L:3º")
                                    }
                                }
                                
                            }
                            .padding()
                        }
                        
                    }
                }
            }
            .navigationTitle("Weather")
        }
        
    }
    
    func centeredFooterView() -> some View {
        HStack {
            Spacer()
            Text("Learn more about weather data and map data")
                .foregroundColor(.gray)
                .font(.footnote)
            Spacer()
        }
    }
    
}

