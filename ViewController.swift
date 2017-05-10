//
//  ViewController.swift
//  fannyEyes
//
//  Created by Anthony Da Cruz on 08/04/2017.
//  Copyright © 2017 Anthony. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, WeatherDelegate {
    
    @IBOutlet weak var stepDescriptor: UILabel!
    
    @IBOutlet weak var flowStepDescription: UILabel!
    
    @IBOutlet weak var sliderFlowStep: UISlider!

    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var buttonSave: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var mapViewContainer: UIView!
    
    @IBOutlet weak var labWeatherStatus: UILabel!
    
    var yahooWeather:YWeather = YWeather()
    var locationManager = CLLocationManager()
    var currentPosition:FPosition?
    var currentWeather:YWeather.weatherData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stepDescriptor.text = String(self.slider.value)
        self.flowStepDescription.text = String(self.sliderFlowStep.value)
        
        //Setting up location manager
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLLocationAccuracyKilometer
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapViewContainer.configureDropShadow()
        mapView.roundBorder(roundValue: 15)
        
        self.yahooWeather.delegate = self
        
        //Getting weather from Yahoo
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.locationAuthorisationStatus()
    }
    
    func weatherUpdated(weatherData: YWeather.weatherData) {
        self.labWeatherStatus.text = weatherData.weatherDescription
        self.labWeatherStatus.tintColor = UIColor.green
        self.currentWeather = weatherData
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.first {
            let lastPosition = FPosition(coordinates: currentLocation.coordinate, altitude: currentLocation.altitude)
            self.currentPosition = lastPosition
            self.yahooWeather.apiCall(forPosition: lastPosition)
        }
    }
    
    
    func locationAuthorisationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .denied:
            print("sorry")
            break
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            break
        default:
            print("default triggered")
            break
        }
    }

    @IBAction func saveAction(_ sender: UIButton) {
        // Creating new FEntry and save it in context
        let entry = NSEntityDescription.insertNewObject(forEntityName: "FEntry", into: (UIApplication.shared.delegate as! AppDelegate).getContext()) as! FEntry
        entry.flowLevel = self.sliderFlowStep.value
        entry.painLevel = self.slider.value
        entry.date = Date() as NSDate?
        
        if let currentLocation = self.currentPosition {
            entry.location = currentLocation.getCoordinates()
        }
        
        if let weather = self.currentWeather {
            entry.weather = weather.description()
        }
        
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

