//
//  MapCell.swift
//  FoodServiceClient
//
//  Created by index-ios on 4/25/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import  Material
import GoogleMaps
import GooglePlaces
import  Toast_Swift
import Localize_Swift
class ProfileMapCell: UITableViewCell {

    @IBOutlet weak var Deliveryplace: UILabel!
    @IBOutlet weak var Longpresslabel: UILabel!
    @IBOutlet weak var BtnSure: UIButton!
    @IBOutlet weak var mymapview: UIView!
    @IBOutlet weak var creditcard: ErrorTextField!
    
    @IBOutlet weak var BtnCreditcard: UIButton!
    
    //map confic
    var lat:Double!
    var long:Double!
    var mylocation = CLLocation()
    var locationmaanager = CLLocationManager()
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var id:Int!
    var Btnlocation :CLLocationCoordinate2D!
    var longPressRecognizer = UILongPressGestureRecognizer()
    var arrayCoordinates : [CLLocationCoordinate2D] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Deliveryplace.text = "DELIVERY_PLACE".localized()
        Longpresslabel.text = "Long Press To Determine Location".localized()
        BtnSure.setTitle("Ensure".localized(), for: .normal)
        BtnSure.layer.cornerRadius = 10
        //configer map
        configGooglemap()
        setuprecognizer()
        
        AddAllMarker(allmarks: [CLLocationCoordinate2D(latitude:Double((Singeleton.userInfo?.location.lat)!) , longitude: Double((Singeleton.userInfo?.location.lng)!))])
        let camera = GMSCameraPosition.camera(withLatitude:CLLocationDegrees((Singeleton.userInfo?.location.lat)!) ,
                                              longitude: CLLocationDegrees((Singeleton.userInfo?.location.lng)!),
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        SetupTextField(fieldtext: creditcard, placeholder: "".localize(), errortext: "".localize())
        creditcard.text = "Credit Card".localize()
    }

   
    func SetupTextField(fieldtext : ErrorTextField ,placeholder :String , errortext :String){
        fieldtext.placeholder = placeholder.localize()
        fieldtext.detail = errortext.localize()
        fieldtext.placeholderActiveColor=#colorLiteral(red: 0, green: 0.5928431153, blue: 0.6563891768, alpha: 0.8477172852)
        fieldtext.placeholderNormalColor=#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        fieldtext.dividerColor=#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        fieldtext.dividerActiveColor=#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        fieldtext.dividerColor=#colorLiteral(red: 0, green: 0.5928431153, blue: 0.6563891768, alpha: 0.8477172852)
        fieldtext.dividerNormalHeight=2
        fieldtext.dividerActiveHeight=3
        fieldtext.placeholderVerticalOffset = 35
        
        fieldtext.placeholderActiveScale = 1
        fieldtext.detailVerticalOffset = -2
        
        fieldtext.dividerNormalColor=#colorLiteral(red: 0, green: 0.5928431153, blue: 0.6563891768, alpha: 0.8477172852)
        
        
    }
    
}






///map view operation and delegate

extension ProfileMapCell :GMSMapViewDelegate ,CLLocationManagerDelegate
{
    
    
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        mylocation=locations[0]
//        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
//                                              longitude: location.coordinate.longitude,
//                                              zoom: zoomLevel)
//
//        if mapView.isHidden {
//            mapView.isHidden = false
//            mapView.camera = camera
//        } else {
//             mapView.animate(to: camera)
//        }
        
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationmaanager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
    
    
    //add marker with userdata
    func AddAllMarker( allmarks : [CLLocationCoordinate2D] ){
        for markcoordinate in  allmarks {
            let marker = GMSMarker(position: markcoordinate )
            marker.userData=markcoordinate
            marker.tracksViewChanges = true
            marker.map = mapView
        }
        var showmark = allmarks
       // showmark.append(mylocation.coordinate)
        
        showAllMarkers(marke: showmark )
        
    }
    
    
    
    
    
    ///zoom to see all marker
    func showAllMarkers(marke :[CLLocationCoordinate2D]) {
        var   markers = [GMSMarker]()
        for marks in marke {
            markers.append(GMSMarker(position: marks))
        }
        let firstLocation: CLLocationCoordinate2D? = (markers.first as? GMSMarker)?.position
        var bounds = GMSCoordinateBounds(coordinate: firstLocation!, coordinate: firstLocation!)
        for marker: GMSMarker in markers {
            bounds = bounds.includingCoordinate(marker.position)
        }
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
        let camera = GMSCameraPosition.camera(withLatitude: marke[0].latitude,
                                              longitude: marke[0].longitude,
                                              zoom: 1000)
       mapView.camera = camera
        mapView.animate(to: camera)
        
    }
    
    func configGooglemap(){
        //configurelocation manger
        locationmaanager = CLLocationManager()
        locationmaanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmaanager.requestAlwaysAuthorization()
        locationmaanager.distanceFilter = 50
        locationmaanager.startUpdatingLocation()
        locationmaanager.delegate = self
        
        //create google map
        let camera = GMSCameraPosition.camera(withLatitude: mylocation.coordinate.latitude,
                                              longitude:mylocation.coordinate.longitude ,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: mymapview.bounds , camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = false
        
        // Add the map to the view, hide it until we've got a location update.
        mymapview.addSubview(mapView)
        mapView.isHidden = true
        mapView.delegate=self
        //            //defined mapview apper
        //            myview=UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        //            // btn = RaisedButton(frame: CGRect.init(x: 20, y: 10, width: 160, height: 50))
    }
    
    
    
    
}
//to add marker when long press
extension ProfileMapCell {
    
    
    public override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
    
    func setuprecognizer(){
        longPressRecognizer = UILongPressGestureRecognizer(target: self,
                                                           action: #selector(self.longPress))
        longPressRecognizer.minimumPressDuration = 0.5
        longPressRecognizer.delegate = self
        mapView.addGestureRecognizer(longPressRecognizer)
        
        mapView.isMyLocationEnabled = false
        mapView.settings.compassButton = true
        
    }
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        mapView.clear()
        let newMarker = GMSMarker(position: mapView.projection.coordinate(for: sender.location(in: mapView)))
        self.arrayCoordinates.append(newMarker.position)
        newMarker.map = mapView
        print(" \(arrayCoordinates[0].latitude)  \(arrayCoordinates[0].longitude) ")
    }
    
    
    
}


