//
//  ControlBar.swift
//  WeatherApp
//
//  Created by Johnny Tam on 17/3/2024.
//

import SwiftUI

struct ControlBar: View {
    @Binding var isShowingMap:Bool
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        HStack{
            Button{
                isShowingMap.toggle()
            }label: {
                Image(systemName: "map")
            }
            .fullScreenCover(isPresented: $isShowingMap){
                WeatherMapView()
            }
            
            Spacer()
            
            Button{
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "list.bullet")
            }
        }
    }
}

