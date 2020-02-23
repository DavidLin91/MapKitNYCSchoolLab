//
//  CoreLocationSession.swift
//  MapKitNYCSchoolLab
//
//  Created by David Lin on 2/22/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import Foundation
import CoreLocation


class CoreLocationSession: NSObject {
    
    public var locationManager: CLLocationManager
    
    
   override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
    
        // request the user's location
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()
    
    // the following keys need ot be added to the info.plist file
    /*
     NSLocationAlwaysAndWhenInUseUsageDescription
     NSLOcationWhenInUseageDescription
     */
    
    // more agressive solution to GPS data collection
    // locationManager.startUpdatingLocation()
    
    // get updates for user location (less agressive on batter consumption and GPS data colleciton)
    startSignificantLocationChanges()
    
    
    startMonitoringRegion()
    }
    
    // only updates location if there are significant changes
    private func startSignificantLocationChanges() {
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            // not availabe on the device
            return
        }
        // less agressive than the statUpdatingLocaiton() in GPS monitor changes
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    
    
    
    
    public func convertCoordinateToPlacemark(coordinate: CLLocationCoordinate2D) {
        // we will use the CLGeocoder() class for converting coordinate (CLLocationCoordinate2D) to placemark (CLPlacemark)
        
        // we need to create CLLocaiton
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("reverseGeocodeLocation: \(error)")
            }
            if let firstPlacemark = placemarks?.first {
                print("placemark info: \(firstPlacemark)")
            }
        }
    }
    
    
    public func convertPlaceNameToCoordinate(addressString: String) {
        // convert an address to a coordinate
        CLGeocoder().geocodeAddressString(addressString) { (placemarks, error) in
            if let error = error {
                print("geocordAddressString: \(error)")
            }
            if let firstPlacemark = placemarks?.first,
                let location = firstPlacemark.location {
                    print("place name coordinate is \(location.coordinate)")
                }
            }
        }

    
    // monitor a CLRegion
    // CLRegion is made up of a center coordinate and a radius in meters
    private func startMonitoringRegion() {
        let location = AllSchools.getLocations() // central park
        let identifier = "monitoring region"
        let region = CLCircularRegion(center: location, radius: 500, identifier: identifier)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        locationManager.startMonitoring(for: region)
    }
    
    
}


extension CoreLocationSession: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations \(locations)")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("did fail with error: \(error)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .denied:
            print("denied")
        case .notDetermined:
            print("not determined")
        case .restricted:
            print("restricted")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        // region has a center and a radius
        print("didEnterRegion: \(region)")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didExitRegion")
    }
    
}


