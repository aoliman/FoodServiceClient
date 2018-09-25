//
//  ProfileMap.swift
//  FoodService
//
//  Created by index-ios on 4/1/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON
import Material
class ProfileMap: UITableViewCell {
    var lat:Double!
    var long:Double!
    var mylocation = CLLocation()
    var locationmaanager = CLLocationManager()
    
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var id:Int!
    var Btnlocation :CLLocationCoordinate2D!
    //mapview apper
    var myview :UIView!
    var btn : RaisedButton!
    // The currently selected place.
    var Ispartycooker=false
    var IsFoodCar=false
    var GetallHomeCookerplaces = GetallProdacteRepo()
    
    @IBOutlet weak var viewcellmap: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //configurelocation manger
        locationmaanager = CLLocationManager()
        locationmaanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmaanager.requestAlwaysAuthorization()
        locationmaanager.distanceFilter = 50
        locationmaanager.startUpdatingLocation()
        locationmaanager.delegate = self
        //mapView.settings.zoomGestures = true
        //create google map
        let camera = GMSCameraPosition.camera(withLatitude: mylocation.coordinate.latitude,
                                              longitude:mylocation.coordinate.longitude ,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: viewcellmap.bounds , camera: camera)
        mapView.settings.myLocationButton = false
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = false
        
        // Add the map to the view, hide it until we've got a location update.
        viewcellmap.addSubview(mapView)
        mapView.isHidden = true
        mapView.delegate=self
        //defined mapview apper
        myview=UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
       // btn = RaisedButton(frame: CGRect.init(x: 20, y: 10, width: 160, height: 50))
        
        
    }
    
    func SetLoactionofowner(lat:Double , long:Double,type:String){
      self.lat=lat
      self.long=long
        if(type == "party-cookers"){
            Ispartycooker=true
        }
      AddAllMarker(allmarks:[CLLocationCoordinate2D(latitude:lat , longitude: long) ])
       
    }
    
}






extension ProfileMap: CLLocationManagerDelegate {
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        mylocation=locations[0]
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            // mapView.animate(to: camera)
        }
        
        // listLikelyPlaces()
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
            print(Ispartycooker)
            
            if (UserDefaults.standard.string(forKey: Profiletype)=="party-cookers") {
              marker.icon = resizeImage(image: #imageLiteral(resourceName: "map_marker_party_cooker"), targetSize: CGSize(width:50, height: 50))
            }else if(UserDefaults.standard.string(forKey: Profiletype)=="food-cars") {
             marker.icon = resizeImage(image: #imageLiteral(resourceName: "map_marker_food_car"), targetSize: CGSize(width:50, height: 50))
            }else if(UserDefaults.standard.string(forKey: Profiletype)=="home-cookers"){
                 marker.icon = resizeImage(image: #imageLiteral(resourceName: "map_marker_home_cooker"), targetSize: CGSize(width:50, height: 50))
            }
            
            marker.tracksViewChanges = true
            marker.map = mapView
        }
        var showmark = allmarks
        showmark.append(mylocation.coordinate)
        showAllMarkers(marke: showmark )
        
    }
    
    
    //resize image
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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
        
        
    }
    
    
}




extension ProfileMap :  GMSMapViewDelegate
{
    // when click in  maker
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("marker.userData")
        //self.btn.addTarget(self, action: #selector(p), for: .allEvents)
        
    }
    

    
}



