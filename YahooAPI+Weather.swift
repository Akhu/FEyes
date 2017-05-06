//
//  YahooAPI+Weather.swift
//  fannyEyes
//
//  Created by Anthony Da Cruz on 21/04/2017.
//  Copyright © 2017 Anthony. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol WeatherDelegate {
    func weatherUpdated(weatherData: YWeather.weatherData)
}
class YWeather {
    
    struct weatherData {
        var temperature:String
        var wind:String
        var weatherDescription:String
        var weatherCode:Int
        
        func description() -> String {
            return "\(self.weatherDescription) / temperature : \(self.temperature) / code: \(self.weatherCode)"
        }
    }
    
    
    var delegate:WeatherDelegate?
    //select * from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text="({lat},{lon})")

    
    private let clientID = "dj0yJmk9cUFoR1J1Y2RkWnNEJmQ9WVdrOWFHZGxlVWxUTm04bWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00YQ--"
    private let clientSecret = "59a48b4fa791057fa7d4cfe8ff2bc904a8a8dd12"
    
    static func currentWeatherForPosition(position:String) -> String{
        return "Sunny"
    }
    
    func apiCall(forPosition position:FPosition){
        
        let yql = "select * from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text=\"(" + String(position.coordinates.latitude) + "," + String(position.coordinates.longitude) + ")\")"
        
        let url = "https://query.yahooapis.com/v1/public/yql"
            
        Alamofire.request(url, method: .get, parameters: ["q":yql,"format":"json"], encoding: URLEncoding.default, headers: nil).responseJSON { response in
            print(response.result.value)
            
            let json = JSON(response.result.value as Any)
            
            guard json["query"]["results"]["channel"]["item"]["condition"].exists() else {
                return
            }
            
            let item = json["query"]["results"]["channel"]["item"]["condition"]
            let weatherLocationData = weatherData(temperature: item["temp"].stringValue, wind: "unkown", weatherDescription: item["text"].stringValue, weatherCode: item["code"].intValue)
            
            if let delegateClass = self.delegate {
                delegateClass.weatherUpdated(weatherData: weatherLocationData)
            }
        }
        
        

    }
    
    private static let yWeatherDescriptionReference:[Int:String] = [
        0:"tornado",
        1:"tropical storm",
        2:"hurricane",
        3:"severe thunderstorms",
        4:"thunderstorms",
        5:"mixed rain and snow",
        6:"mixed rain and sleet",
        7:"mixed snow and sleet",
        8:"freezing drizzle",
        9:"drizzle",
        10:"freezing rain",
        11:"showers",
        12:"showers",
        13:"snow flurries",
        14:"light snow showers",
        15:"blowing snow",
        16:"snow",
        17:"hail",
        18:"sleet",
        19:"dust",
        20:"foggy",
        21:"haze",
        22:"smoky",
        23:"blustery",
        24:"windy",
        25:"cold",
        26:"cloudy",
        27:"mostly cloudy (night)",
        28:"mostly cloudy (day)",
        29:"partly cloudy (night)",
        30:"partly cloudy (day)",
        31:"clear (night)",
        32:"sunny",
        33:"fair (night)",
        34:"fair (day)",
        35:"mixed rain and hail",
        36:"hot",
        37:"isolated thunderstorms",
        38:"scattered thunderstorms",
        39:"scattered thunderstorms",
        40:"scattered showers",
        41:"heavy snow",
        42:"scattered snow showers",
        43:"heavy snow",
        44:"partly cloudy",
        45:"thundershowers",
        46:"snow showers",
        47:"isolated thundershowers"]
    
    
}
