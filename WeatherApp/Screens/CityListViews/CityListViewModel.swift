//
//  CityListViewModel.swift
//  WeatherApp
//
//  Created by Johnny Tam on 10/3/2024.
//

import Foundation

//class CityListViewModel : ObservableObject {
//    
//    @EnvironmentObject var locationHelper: LocationHelper
//    @Published var searchingAddress : String = ""
//    @Published var lat : String = ""
//    @Published var lng : String = ""
//    
//    
//    private func doGeocoding(address: String){
//        // call the helper function
//        self.locationHelper.doForwardGeocoding(address: address, completionHandler: {
//            (coordinates, error) in
//            if (error == nil && coordinates != nil){
//                self.lat = "\(String(describing: coordinates?.coordinate.latitude))"
//                self.lng = "\(String(describing: coordinates?.coordinate.longitude))"
//            }else{
//                return
//            }
//        })
//
//    }
//}
