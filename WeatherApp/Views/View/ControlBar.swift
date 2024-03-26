//
//  ControlBar.swift
//  WeatherApp
//
//  Created by Johnny Tam on 17/3/2024.
//

//import SwiftUI
//
//struct ControlBar: View {
//    @Binding var isShowingMap:Bool
//    var city:City
//    @Binding var selectedTabIndex:Int
//    @Environment(\.presentationMode) var presentationMode
//
//    
//    var body: some View {
//        HStack{
//            Button{
//                isShowingMap.toggle()
//            }label: {
//                Image(systemName: "map")
//            }
//            
//            Spacer()
//            
//            Button{
//                self.presentationMode.wrappedValue.dismiss()
//            } label: {
//                Image(systemName: "list.bullet")
//            }
//        }
//        .overlay{
//            Spacer()
//            PageControlView(
//                currentPage: $selectedTabIndex,
//                numberOfPages: city.cities.count
//            )
//            Spacer()
//
//        }
//    }
//}

