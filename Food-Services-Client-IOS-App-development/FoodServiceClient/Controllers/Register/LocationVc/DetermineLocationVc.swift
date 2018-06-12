//
//  DetermineWorkplaceViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 12/24/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Material
import GooglePlaces
import GoogleMaps

class DetermineLocationVc: UIViewController
{
    var didSetupConstraints = false
    var location:UserLocation?
    var currentLocation:CLLocation?
    var locationManager = CLLocationManager()
    lazy var repo = UserRepository()
    //    var userType: String?
    var Isedite = false
    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "food_service_logo")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var geocoder = CLGeocoder()
    // var location:UserLocation?
    var userLocation = CLLocationCoordinate2D()
    var selectedLat:Float?
    var selectedLong:Float?
    
    
    var mapView: GMSMapView = {
        let mapView = GMSMapView()
        return mapView
    }()
    
    var viewTitle: String?
    
    var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.init(hex: "4695a5")
        label.text = "press long to determine workplace site".localized()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var continueRegisterButton: UIButton = {
        
        let button = Button.appButton()
        button.setTitle("Continue register".localized(),  for: .normal)
        
        return button
    }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupView()
        setupNavigationBar()
        continueRegisterButton.addTarget(self, action: #selector(determineLocation), for: .touchUpInside)
        addSubviews()
        configerMap()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.currentLocation != nil {
            self.selectedLat     =  Float((self.currentLocation?.coordinate.latitude)!)
            self.selectedLong    =  Float((self.currentLocation?.coordinate.longitude)!)
            self.setMap(For: self.selectedLat!, long: self.selectedLong!)
            
        }
    }
    
    
    
    func configerMap() {
        mapView.delegate = self
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestLocation()
//        locationManager.startUpdatingLocation()
//        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // helper method
    func centerMapOnLocation(latitude:Float, longitude:Float) {
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude), zoom: 6.0)
        self.mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        marker.map = mapView
        
        
    }
    
    //MARK:- this function for setting google map info
    
    func setMap(For lat:Float ,long:Float) {
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long), zoom: 6.0)
        self.mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        marker.map = mapView
        
        
    }
    
}

extension DetermineLocationVc
{
    @objc func determineLocation()
    {
        if DataUtlis.data.isInternetAvailable() {
            Loader.showLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true

        if let selectLat = self.selectedLat , let selectLong = self.selectedLong {
            repo.determineLocation(id: Singeleton.userId!, lat: Double(selectLat), lan: Double(selectLong), onSuccess: { (response, statusCode) in
                
                Loader.hideLoader()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let vc = CreditCardVc ()
                self.navigationController?.pushViewController(vc, animated: true)

                
            }, onFailure: { (errorResponse, statusCode) in
                
                Loader.hideLoader()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let errorMessage = errorResponse?.error[0].msg
                DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage!)

            })
            
         } else {
            DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "firstSelectLocation".localized())
            Loader.hideLoader()
        }

        } else {
            
        }
    }
}

//MARK:- this delegate for google map

extension DetermineLocationVc : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        self.mapView.clear()
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0)
        self.mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude )
        marker.map = mapView
        self.selectedLat   = Float(coordinate.latitude)
        self.selectedLong  = Float(coordinate.longitude)
        
        
    }
}


//MARK:- this delegate for location manager

extension DetermineLocationVc: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
      
        }
        
    }
    
    
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let userLocation:CLLocation = locations[0] as CLLocation
        self.currentLocation = userLocation
        let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude, zoom: 13.0)
        self.mapView.animate(to: camera)
        
    }
    
    
    
    
}


struct UserLocation {
    
    var latitude:String?
    var longitude:String?
}

