//
//  FECellEntry.swift
//  fannyEyes
//
//  Created by Anthony Da Cruz on 25/04/2017.
//  Copyright © 2017 Anthony. All rights reserved.
//

import UIKit
import MapKit

class FECellEntry: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var painLvlLabel: UILabel!
    @IBOutlet weak var flowLvlLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!

    @IBOutlet weak var openInMapButton: UIButton!
    
    var entry:FEntry?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func positionButtonClicked(_ sender: UIButton) {
        guard let currentEntry = self.entry, let position = currentEntry.location else {
            return
        }
        let splittedPosition = position.components(separatedBy: "+")
        guard let latitude:CLLocationDegrees = Double(splittedPosition[0]), let longitude:CLLocationDegrees = Double(splittedPosition[1]) else {
            return
        }

        
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let regionSpan:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate:  regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placeMark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placeMark)
        
        mapItem.name = "Là"
        mapItem.openInMaps(launchOptions: options)
        
    }
    func configureCell(entry: FEntry){
        self.entry = entry
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.mm.yyyy"
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        
        self.dateLabel.text = dateFormatter.string(from: entry.date! as Date)
        
        self.flowLvlLabel.text = String(entry.flowLevel)
        self.painLvlLabel.text = String(entry.painLevel)
        if let weather = entry.weather {
            self.weatherLabel.text = weather
        }
        
        if let position = entry.location {
            self.openInMapButton.isEnabled = true
        }else{
            self.openInMapButton.isEnabled = false
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
        // Configure the view for the selected state
    }

}
