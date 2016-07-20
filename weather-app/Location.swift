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
    
    var city: String {
        if _city == nil {
            _city = ""
        }
        return _city
    }
    
    var temp: String {
        if _temp == nil {
            _temp = ""
        }
        return _temp
    }
    
    var humidity: String {
        if _humidity == nil {
            _humidity = ""
        }
        return _humidity
    }
    
    var windSpeed: String {
        if _windSpeed == nil {
            _windSpeed = ""
        }
        return _windSpeed
    }
    
    var weatherDesc: String {
        if _weatherDesc == nil {
            _weatherDesc = ""
        }
        return _weatherDesc
    }
    
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
                    
                    if let tempK = mainDict["temp"] as? Double {
                        let tempF = Int(round(tempK * (9.0/5.0) - 459.67))
                        self._temp =  "\(tempF)°"
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
                    if let windSpeedDouble = windDict["speed"] as? Double {
                        let windSpeedInt = Int(round(windSpeedDouble))
                        self._windSpeed = "\(windSpeedInt)"
                        print(self._windSpeed)
                    }
                }
            }
            
            completed()
        }
    }
}
