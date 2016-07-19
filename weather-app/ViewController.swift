//
//  ViewController.swift
//  weather-app
//
//  Created by Adam Goth on 7/17/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //outlets
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var weatherDescLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var weatherImg: UIImage!
    
    //let locationManager = CLLocationManager()

    //hard code coordinates for now
    let userLocation: Location = Location(location: CLLocation.init(latitude: 35, longitude: 139))

    override func viewDidLoad() {
        super.viewDidLoad()

        //locationManager.delegate = self
        //locationManager.distanceFilter = kCLDistanceFilterNone
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.startUpdatingLocation()

        userLocation.downloadWeatherDetails { () -> () in

        }
    }
    
    /*override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            print()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        let userLocation = locations.last
        let longitude = userLocation!.coordinate.longitude
        let latitude = userLocation!.coordinate.latitude
        
        }*/
}

