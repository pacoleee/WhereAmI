//
//  ViewController.swift
//  Where Am I?
//
//  Created by Paco Lee on 2016-05-16.
//  Copyright © 2016 Paco Lee. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var latitude: UILabel!
    @IBOutlet var longitude: UILabel!
    @IBOutlet var course: UILabel!
    @IBOutlet var speed: UILabel!
    @IBOutlet var altitude: UILabel!
    @IBOutlet var nearestAddress: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        let userLocation: CLLocation = locations[0] 
        self.latitude.text = "Latitude: \(userLocation.coordinate.latitude)"
        self.longitude.text = "Longitude: \(userLocation.coordinate.longitude)"
        self.course.text = "Course: \(userLocation.course)"
        self.speed.text = "Speed: \(userLocation.speed)"
        self.altitude.text = "Altitude: \(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
           
            if(error != nil) {
                print(error)
            } else {
                if let p = placemarks?[0] {
                
                    let subThoroughfare = p.subThoroughfare != nil ?  p.subThoroughfare! : ""
                    let thoroughfare = p.thoroughfare != nil ?  p.thoroughfare! : ""
                    let subLocality = p.subLocality != nil ?  p.subLocality! : ""
                    let subAdministrativeArea = p.subAdministrativeArea != nil ? p.subAdministrativeArea! : ""
                    let postalCode = p.postalCode != nil ? p.postalCode! : ""
                    let country = p.country != nil ? p.country! : ""
                    
                    self.nearestAddress.text = "\(subThoroughfare) \n \(thoroughfare) \n \(subLocality) \n \(subAdministrativeArea) \n \(postalCode) \n \(country) \n"
                    
                    print(subThoroughfare)
                    print(thoroughfare)
                    print(subLocality)
                    print(subAdministrativeArea)
                    print(postalCode)
                    print(country)
                }
            }
            
        })
    }
}

