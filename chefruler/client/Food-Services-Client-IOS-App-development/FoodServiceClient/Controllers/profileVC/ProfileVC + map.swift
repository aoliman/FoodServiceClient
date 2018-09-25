//
//  Profile + extension map.swift
//  FoodServiceProvider
//
//  Created by Index PC-2 on 1/16/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import MapKit
import GoogleMaps
import GooglePlaces
import CoreLocation


extension ProfileVC : GMSMapViewDelegate {
    // helper method
    func centerMapOnLocation(latitude:Float, longitude:Float) {
        
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude), zoom: 6.0)
        self.mapView.camera = camera
        let marker = GMSMarker()
       // marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = self.mapView
        
        // methods of map
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        }
        func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
            
            print("You long tapped at \(coordinate.latitude), \(coordinate.longitude)")
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
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        //present deliveryPlace profile
        
    }
    
//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        return setupMarkerView()
//    }
    
    func setupMarkerView() -> UIView {
        let container = UIView(frame: CGRect.init(x: 0, y: 0, width: 180, height: 110))
        
        let view: UIView = {
            let view =  UIView()
            view.backgroundColor = .appColor()
            view.layer.cornerRadius = 6
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "DELIVERY_PLACE".localized()
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont.appFontRegular(ofSize: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let icon: UILabel = {
            let label = UILabel()
            label.textColor = .appColor()
            label.font = UIFont.fontAwesome(ofSize: 30)
            label.textAlignment = .center
            label.text = String.fontAwesomeIcon(code: "fa-sort-down")
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
        }()
        
        let profieLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.backgroundColor = .white
            label.text = "Profile".localized()
            //label.cornerRadius = 10
            label.textColor = .darkGray
            label.font = UIFont.appFontRegular(ofSize: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        container.addSubview(icon)
        container.addSubview(view)
        view.addSubview(titleLabel)
        view.addSubview(profieLabel)
        
        
        view.snp.makeConstraints {
            make in
            make.width.equalTo(container.snp.width)
            make.height.equalTo(100)
            make.centerX.equalTo(container.snp.centerX)
            make.top.equalTo(container.snp.top)
            
        }
        
        icon.snp.makeConstraints {
            make in
            make.top.equalTo(view.snp.bottom).offset(-20)
            make.width.height.equalTo(30)
            make.centerX.equalTo(view.snp.centerX)
        }
        titleLabel.snp.makeConstraints {
            make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(40)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.top.equalTo(view.snp.top)
        }
        
        profieLabel.snp.makeConstraints {
            make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(view.snp.width).multipliedBy(0.8)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        return  container
    }
}


//MARK:- this delegate for location manager




class CustomPointAnnotation: MKPointAnnotation {
    var pinImageName:String!
    var userData:Int!
}


