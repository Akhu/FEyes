//
//  GeoPosition.swift
//  fannyEyes
//
//  Created by Anthony Da Cruz on 21/04/2017.
//  Copyright © 2017 Anthony. All rights reserved.
//

import Foundation
import CoreLocation

struct FPosition {
    var coordinates:CLLocationCoordinate2D
    var altitude:CLLocationDistance
    
    func getAltitude() -> String {
        return String(self.altitude)
    }
    
    func getCoordinates() -> String{
        return String(self.coordinates.latitude) + "+" + String(self.coordinates.longitude)
    }
}
