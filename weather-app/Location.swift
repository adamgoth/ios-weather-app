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
    private var _location: CLLocation!
    private var _longitude: CLLocationDegrees!
    private var _latitude: CLLocationDegrees!
    private var _city: String!
    private var _temp: String!
    private var _humidity: String!
    private var _windSpeed: String!
    private var _weatherDesc: String!
    
    init(location: CLLocation) {
        self._latitude = location.coordinate.latitude
        self._longitude = location.coordinate.longitude
        self._weatherUrl = "\(OWM_URL)lat=\(_latitude)&lon=\(_longitude)&appid=\(API_KEY)"
    }

    func downloadWeatherDetails(completed: DownloadComplete) {
        let url = NSURL(string: _weatherUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let city = dict["name"] as? String {
                    self._city = city
                    print(self._city)
                }
                
                if let mainDict = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let temp = mainDict["temp"] as? Double {
                        self._temp =  "\(temp)"
                        print(self._temp)
                    }
                    
                    if let humidity = mainDict["humidity"] as? Int {
                        self._humidity = "\(humidity)"
                        print(self._humidity)
                    }
                }
                
                if let weatherArr = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let weatherDesc = weatherArr[0]["main"] as? String {
                        self._weatherDesc = weatherDesc
                        print(self._weatherDesc)
                    }
                }
                
                if let windDict = dict["wind"] as? Dictionary<String, AnyObject> {
                    if let windSpeed = windDict["speed"] as? Double {
                        self._windSpeed = "\(windSpeed)"
                        print(self._windSpeed)
                    }
                }
            }
        }
    }
}
