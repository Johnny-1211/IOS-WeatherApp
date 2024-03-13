//
//  CityListView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 9/3/2024.
//

import SwiftUI

struct CityListView: View {
    
    @EnvironmentObject var city: City
    @EnvironmentObject var locationSearch: LocationSearchService
    
    var body: some View {
        NavigationStack{
            VStack{
                Section(header: Text("Location Search")) {
                    ZStack(alignment: .trailing) {
                        TextField("Search", text: $locationSearch.queryFragment)
                        // This is optional and simply displays an icon during an active search
                        if locationSearch.status == .isSearching {
                            Image(systemName: "clock")
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                Section(header: Text("Results")) {
                    List {
                        // With Xcode 12, this will not be necessary as it supports switch statements.
                        Group { () -> AnyView in
                            switch locationSearch.status {
                            case .noResults: return AnyView(Text("No Results"))
                            case .error(let description): return AnyView(Text("Error: \(description)"))
                            default: return AnyView(EmptyView())
                            }
                        }.foregroundColor(Color.gray)
                        
                        ForEach(locationSearch.searchResults, id: \.self) { completionResult in
                            // This simply lists the results, use a button in case you'd like to perform an action
                            // or use a NavigationLink to move to the next view upon selection.
                            Text(completionResult.title)
                        }
                    }
                }
                
                
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

