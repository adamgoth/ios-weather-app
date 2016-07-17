//
//  Location.swift
//  weather-app
//
//  Created by Adam Goth on 7/17/16.
//  Copyright © 2016 Adam Goth. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class Location {
    
    private var _weatherUrl: String!
    private var _location: CLLocation = CLLocation.init(latitude: 45, longitude: 45)
    private var _longitude: CLLocationDegrees!
    private var _latitude: CLLocationDegrees!
    
    init(location: CLLocation) {
        self._latitude = location.coordinate.latitude
        self._longitude = location.coordinate.longitude
        self._weatherUrl = "\(OWM_URL)lat=\(_latitude)&lon=\(_longitude)&appid=\(API_KEY)"
    }

    func downloadWeatherDetails(completed: DownloadComplete) {
        let url = NSURL(string: _weatherUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            print(result.value)
        }
    }
}
