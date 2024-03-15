//
//  CityListView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 9/3/2024.
//

import SwiftUI

struct CityListView: View {
    
    @ObservedObject var viewModel: CityListViewModel = CityListViewModel()
    @State var cityList : [Weather] = []
    @EnvironmentObject var locationSearch: LocationSearchService
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    List(self.viewModel.results) { address in
                        AddressRow(address: address)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
                .searchable(text: $viewModel.searchableText, prompt: Text("Search address")){}
                .onChange(of: viewModel.searchableText) { searchText in
                    viewModel.searchAddress(searchText)
                }
                
                
                List{
                    ForEach(cityList){ city in
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

