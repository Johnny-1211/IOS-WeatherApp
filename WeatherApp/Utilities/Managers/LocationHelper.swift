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
    @Published var searchLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        requestPermission()
        
    }// init
    
    func requestPermission(){
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    func checkPermission(){
        authorizationStatus = locationManager.authorizationStatus

        switch self.locationManager.authorizationStatus{
        case .denied, .notDetermined, .restricted:
            self.requestPermission()
            
        case .authorizedAlways,.authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            
        default:
            break
        }
    }//checkPerm
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkPermission()
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
                    self.searchLocation = matchedLocation
                    print(#function, "matchedLocation: \(matchedLocation)")
                    completionHandler(matchedLocation, nil)
                    return
                }
                completionHandler(nil, error as NSError?)
            }
        })
    }//doforward()
    
    // coordinates > address
    func getCountryFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error)")
                completion("") // Pass empty string if there's an error
                return
            }

            guard let placemark = placemarks?.first else {
                print("No placemark found")
                completion("") // Pass empty string if no placemark is found
                return
            }

            if let country = placemark.locality {
                completion(country) // Pass the country name to the completion handler
            } else {
                completion("") // Pass empty string if country name is not available
            }
        }
    }

    
}
