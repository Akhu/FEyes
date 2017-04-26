//
//  ViewController.swift
//  fannyEyes
//
//  Created by Anthony Da Cruz on 08/04/2017.
//  Copyright © 2017 Anthony. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var stepDescriptor: UILabel!
    
    @IBOutlet weak var flowStepDescription: UILabel!
    
    @IBOutlet weak var sliderFlowStep: UISlider!

    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var buttonSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stepDescriptor.text = String(self.slider.value)
        self.flowStepDescription.text = String(self.sliderFlowStep.value)
        
        //Getting weather from Yahoo
        
    }

    @IBAction func saveAction(_ sender: UIButton) {
        // Creating new FEntry and save it in context
        let entry = NSEntityDescription.insertNewObject(forEntityName: "FEntry", into: (UIApplication.shared.delegate as! AppDelegate).getContext()) as! FEntry
        entry.flowLevel = self.sliderFlowStep.value
        entry.painLevel = self.slider.value
        entry.date = Date() as NSDate?
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sliderFlowChanged(_ sender: UISlider) {
        sender.value = sender.value.rounded()
        self.flowStepDescription.text = String(sender.value)
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        //Steper
        sender.value = sender.value.rounded()
        self.stepDescriptor.text = String(sender.value)
    }

}

