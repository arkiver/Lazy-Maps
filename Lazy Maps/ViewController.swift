//
//  ViewController.swift
//  Lazy Maps
//
//  Created by Akshay Khole on 7/1/15.
//  Copyright (c) 2015 Awesome Apps. All rights reserved.
//

import UIKit
import MapKit

// 37.312926, -121.975142

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var latitude:CLLocationDegrees = 37.312926
        var longtidue:CLLocationDegrees = -121.975142
        
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location:CLLocationCoordinate2D =
        CLLocationCoordinate2DMake(latitude, longtidue)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: true)
        
        // add annotation
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "You are here"
        map.addAnnotation(annotation)
        map.selectAnnotation(annotation, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

