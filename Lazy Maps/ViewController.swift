//
//  ViewController.swift
//  Lazy Maps
//
//  Created by Akshay Khole on 7/1/15.
//  Copyright (c) 2015 Awesome Apps. All rights reserved.
//

import UIKit
import MapKit
import AudioToolbox
import CoreLocation

// 37.312926, -121.975142

class ViewController: UIViewController, MKMapViewDelegate,
CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        var latitude:CLLocationDegrees = 37.312926
        var longitude:CLLocationDegrees = -121.975142
        
        var latDelta:CLLocationDegrees = 0.05
        var lonDelta:CLLocationDegrees = 0.05
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location:CLLocationCoordinate2D =
        CLLocationCoordinate2DMake(latitude, longitude)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: true)
        
        // add annotation
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "lat: \(latitude)," +
        "lon: \(longitude)"
        map.addAnnotation(annotation)
        // map.selectAnnotation(annotation, animated: true)
        
        // recognize long press
        
        var uilpgr = UILongPressGestureRecognizer(target: self,
            action: "action:")
        uilpgr.minimumPressDuration = 1.5
        map.addGestureRecognizer(uilpgr)
    }
    
    func action(gestureRecognizer:UIGestureRecognizer){

        // vibrate device when long pressed
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        var touchPoint = gestureRecognizer.locationInView(self.map)
        
        var newCoordinate:CLLocationCoordinate2D = map.convertPoint(touchPoint,
            toCoordinateFromView: self.map)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinate
        
        annotation.title = "latitude: /(newCoordinate.latitude)," +
        "longitude: \(newCoordinate.longitude)"

        map.addAnnotation(annotation)
        
    }
    
    func locationManager(manager: CLLocationManager!,
        didUpdateLocations locations: [AnyObject]!) {

            println(locations)
            var userLocation:CLLocation = locations[0] as! CLLocation
            var latitude = userLocation.coordinate.latitude
            var longitude = userLocation.coordinate.longitude
            
            
            var latDelta:CLLocationDegrees = 0.05
            var lonDelta:CLLocationDegrees = 0.05
            
            var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)

            var location:CLLocationCoordinate2D =
            CLLocationCoordinate2DMake(latitude, longitude)
            
            var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            self.map.setRegion(region, animated: true)

            // annotate new found location
            var annotation = MKPointAnnotation()
            annotation.coordinate = location
            
            annotation.title = "latitude: /(latitude)," +
            "longitude: \(longitude)"
            map.addAnnotation(annotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

