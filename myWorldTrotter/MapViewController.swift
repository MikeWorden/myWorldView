//
//  MapViewController.swift
//  myWorldTrotter
//
//  Created by Michael Worden on 1/4/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController:   UIViewController, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    @objc func poiswitchValueDidChange(_ poiSwitch:  UISwitch){
        if (poiSwitch.isOn == true) {
            mapView.pointOfInterestFilter = MKPointOfInterestFilter.includingAll
        } else {
            mapView.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          let location = locations[0]
          
    
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
       
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        
        print("LocationManager fired")
        
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        locationManager.stopUpdatingLocation() // This is for toggling otherwise locationManager will keep tracking in focus
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = MKMapView ()
        view = mapView
        
        // load & enable location manager
        //let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // Add view Control
        let segmentedControl
                    = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        segmentedControl.addTarget(self,
                                   action: #selector(mapTypeChanged(_:)),
                                   for: .valueChanged)

        let topConstraint =
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                  constant: 8)
  
        let margins = view.layoutMarginsGuide
        let leadingConstraint =
            segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint =
            segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)

        
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        let poiSwitch = UISwitch()
        poiSwitch.backgroundColor=UIColor.clear
        poiSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(poiSwitch)
        poiSwitch.addTarget(self,
                            action: #selector(poiswitchValueDidChange(_:)),
                            for: .valueChanged)
        
        let poiSwitchtopConstraint = poiSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45)
    
        let poiSwitchleadingConstraint = poiSwitch.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 160)
        let poiSwitchtrailingConstraint = poiSwitch.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        poiSwitchtopConstraint.isActive = true
        poiSwitchleadingConstraint.isActive = true
        poiSwitchtrailingConstraint.isActive = true
       
        
        let poiLabel = UILabel()
        
        poiLabel.text = "Points of Interest:"
        
        poiLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(poiLabel)
        let poiLabeltopConstraint = poiLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
    
        let poiLabelleadingConstraint = poiLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let poiLabeltrailingConstraint = poiLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        poiLabelleadingConstraint.isActive=true
        poiLabeltopConstraint.isActive = true
        
        poiLabeltrailingConstraint.isActive = true
        
        
        

        
        
        
        
        
    }
    
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("MapViewController loaded its view")
    }
}


