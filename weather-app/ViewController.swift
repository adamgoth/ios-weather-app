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
    @IBOutlet weak var datetimeLbl: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    
    let locationManager = CLLocationManager()

    //hard code coordinates for now
    let userLocation: Location = Location(location: CLLocation.init(latitude: 39.74, longitude: -104.98))
    //var userLocation: Location

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

        userLocation.downloadWeatherDetails { () -> () in
            self.updateUI()
        }
    }
    
    func updateUI() {
        cityLbl.text = userLocation.city.uppercaseString
        tempLbl.text = userLocation.temp
        windSpeedLbl.text = userLocation.windSpeed
        humidityLbl.text = userLocation.humidity
        datetimeLbl.text = NSDate().dayMonthTime()?.uppercaseString
        weatherImg.image = UIImage(named: userLocation.weatherDesc)
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
        let loc = locations.last
        let longitude = loc!.coordinate.longitude
        let latitude = loc!.coordinate.latitude
        userLocation = Location(location: CLLocation.init(latitude: latitude, longitude: longitude))
        print(latitude)
        print(longitude)
        }
    */
}

extension NSDate {
    func dayMonthTime() -> String? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, h:mm a"
        return dateFormatter.stringFromDate(self)
    }
}

