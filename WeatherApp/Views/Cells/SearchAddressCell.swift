//
//  AddressRow.swift
//  WeatherApp
//
//  Created by Johnny Tam on 15/3/2024.
//

import SwiftUI

struct SearchAddressCell: View {
    @State var isShowingWeatherSheetView :Bool = false
    let address: AddressResult
    

    var body: some View {
            Button {
                isShowingWeatherSheetView = true
                
            } label: {
                VStack(alignment: .leading) {
                    Text(address.title)
                    Text(address.subtitle)
                        .font(.caption)
                }
            }
            .sheet(isPresented: $isShowingWeatherSheetView){
                WeatherDetailView(selectedAddress: address, isShowingWeatherSheetView: $isShowingWeatherSheetView)
            }

            
            .padding(.bottom, 2)
        
    }
}

