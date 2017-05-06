//
//  FECellEntry.swift
//  fannyEyes
//
//  Created by Anthony Da Cruz on 25/04/2017.
//  Copyright © 2017 Anthony. All rights reserved.
//

import UIKit

class FECellEntry: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var painLvlLabel: UILabel!
    @IBOutlet weak var flowLvlLabel: UILabel!

    @IBOutlet weak var positionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(entry: FEntry){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.mm.yyyy"
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        
        self.dateLabel.text = dateFormatter.string(from: entry.date! as Date)
        
        self.flowLvlLabel.text = String(entry.flowLevel)
        self.painLvlLabel.text = String(entry.painLevel)
        
        if let altitude = entry.altitude, let position = entry.location {
            self.positionLabel.text = "Altitude: \(altitude), Coordonnées: \(position)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
