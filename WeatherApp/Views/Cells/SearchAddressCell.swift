//
//  AddressRow.swift
//  WeatherApp
//
//  Created by Johnny Tam on 15/3/2024.
//

import SwiftUI

struct SearchAddressCell: View {
    @State var isShowingWeatherSheetView :Bool = true
    @EnvironmentObject var locationHelper: LocationHelper
    @Binding var address: AddressResult
    
    
    var body: some View {
        NavigationLink {
//            WeatherDetailView(
        } label: {
            VStack(alignment: .leading) {
                Text(address.title)
                Text(address.subtitle)
                    .font(.caption)
            }
        }
        .onAppear{
            
        }
        .padding(.bottom, 2)
    }
}

