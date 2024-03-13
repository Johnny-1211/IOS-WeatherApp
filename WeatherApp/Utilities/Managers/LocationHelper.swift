//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Johnny Tam on 10/3/2024.
//

import SwiftUI
import CoreLocation
import Contacts
class LocationHelper: NSObject, ObservableObject, CLLocationManagerDelegate{
    private let geoCoder = CLGeocoder()
    private let locationManager = CLLocationManager()
    @Published var authorizationStatus : CLAuthorizationStatus = .notDetermined
    @Published var currentLocation: CLLocation?
    
    override init() {
        super.init()
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest            
        }
        
        self.checkPermission()
        
        if (CLLocationManager.locationServicesEnabled() && (self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse)){
            self.locationManager.startUpdatingLocation()
        }else{
            self.requestPermission()
        }
        
    }// init
    
    func requestPermission(){
        if (CLLocationManager.locationServicesEnabled()){
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    func checkPermission(){
        switch self.locationManager.authorizationStatus{
        case .denied:
            self.requestPermission()
            
        case .notDetermined:
            self.requestPermission()
            
        case .restricted:
            self.requestPermission()
            
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
            
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            
        default:
            break
        }
    }//checkPerm
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.last != nil{
            //most recent
            self.currentLocation = locations.last!
        }else{
            //oldest known location
            self.currentLocation = locations.first
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "Error while trying to get location updates : \(error)")
    }
    
    deinit{
        self.locationManager.stopUpdatingLocation()
    }

    // convert address to coordinates
    func doForwardGeocoding(address : String, completionHandler: @escaping(CLLocation?, NSError?) -> Void){
        self.geoCoder.geocodeAddressString(address, completionHandler: {
            (placemarks, error) in
            if (error != nil){
                print(#function, "Unable to obtain coord for the given address \(error)")
                completionHandler(nil, error as NSError?)
            }else{
                if let place = placemarks?.first{
                    let matchedLocation = place.location!
                    print(#function, "matchedLocation: \(matchedLocation)")
                    completionHandler(matchedLocation, nil)
                    return
                }
                completionHandler(nil, error as NSError?)
            }
        })
    }//doforward()
    
    // coordinates > address
    func doReverseGeocoding(location: CLLocation, completionHandler: @escaping(String?, NSError?) -> Void){
        self.geoCoder.reverseGeocodeLocation(location
                                             , completionHandler: {
            (placemarks, error) in
            
            if(error != nil){
                print(#function, "Unable to obtain street address for the given coordinates \(error)")
                
                completionHandler(nil, error as NSError?)
            }else{
                if let placemarkList = placemarks, let firstPlace = placemarks?.first{
                    // get street address from coordinates
                    
                    let street = firstPlace.thoroughfare ?? "NA"
                    let postalCode = firstPlace.postalCode ?? "NA"
                    let country = firstPlace.country ?? "NA"
                    let province = firstPlace.administrativeArea ?? "NA"
                    
                    print(#function, "\(street), \(postalCode), \(country), \(province)")
                    
                    //An object that you use to format a contact's postal addresses.
                    let address = CNPostalAddressFormatter.string(from: firstPlace.postalAddress!, style: .mailingAddress)
                    
                    completionHandler(address, nil)
                    return
                    
                }
            }
            
        })
    }
    
}
