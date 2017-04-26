//
//  YahooAPI+Weather.swift
//  fannyEyes
//
//  Created by Anthony Da Cruz on 21/04/2017.
//  Copyright © 2017 Anthony. All rights reserved.
//

import Foundation

class YWeather {
    
    //select * from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text="({lat},{lon})")

    
    private let clientID = "dj0yJmk9cUFoR1J1Y2RkWnNEJmQ9WVdrOWFHZGxlVWxUTm04bWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00YQ--"
    private let clientSecret = "59a48b4fa791057fa7d4cfe8ff2bc904a8a8dd12"
    
    static func currentWeatherForPosition(position:String) -> String{
        return "Sunny"
    }
    
    private func apiCall(){
        
    }
    
    
}
