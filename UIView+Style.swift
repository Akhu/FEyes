//
//  UIView+Style.swift
//  fannyEyes
//
//  Created by Anthony Da Cruz on 06/05/2017.
//  Copyright © 2017 Anthony. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundBorder(roundValue:CGFloat? = nil) {
        
        if roundValue != nil {
            self.layer.cornerRadius = roundValue!
        }else {
            self.layer.cornerRadius = self.layer.bounds.width/2
        }
        self.clipsToBounds = true
    }
    
    open func configureDropShadow() {
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.4
        self.layer.masksToBounds = false
        
        self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: 15).cgPath
        
        //self.updateShadowPath()
    }
    
    private func updateShadowPath() {
        self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
    }

}
