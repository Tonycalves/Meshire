//
//  MapsViewController.swift
//  MessageApp
//
//  Created by Anthony Goncalves on 15/02/2017.
//  Copyright © 2017 Anthony Goncalves. All rights reserved.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var btnMenuButton: UIBarButtonItem!
    
    let locationManager = CLLocationManager()
    var vwGMap = GMSMapView()
    let marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnMenuButton.target = SWRevealViewController()
        btnMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        vwGMap.isMyLocationEnabled = true
        // A minimum distance a device must move before update event generated
        locationManager.distanceFilter = 500
        // Request permission to use location service
        locationManager.requestWhenInUseAuthorization()
        // Request permission to use location service when the app is run
        locationManager.requestAlwaysAuthorization()
        // Start the update of user's location
        locationManager.startUpdatingLocation()
        
        self.view = vwGMap
    }
    
    @nonobjc func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if (status == CLAuthorizationStatus.authorizedWhenInUse)
        {
            vwGMap.isMyLocationEnabled = true
        }
    }
    
    @nonobjc func locationManager(manager: CLLocationManager,_didUpdateLocations locations: [CLLocation])
    {
        self.showCurrentLocationOnMap()
        self.locationManager.stopUpdatingLocation()
    }
    
    func showCurrentLocationOnMap() {
        let camera = GMSCameraPosition.camera(withLatitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!, zoom: 17.5, bearing:30, viewingAngle:40)
        
        let vwGMap = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        vwGMap.isMyLocationEnabled = true
        marker.position = camera.target
        marker.snippet = "Current Location"
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = vwGMap
        self.view.addSubview(vwGMap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
