//
//  OrderDetailis+Extention.swift
//  FoodServiceClient
//
//  Created by index-ios on 5/8/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON
extension OrderDetailsVC :  GMSMapViewDelegate
{
    
    
    //to apper custom view when clicked in marker
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {

        let customInfoWindow = Bundle.main.loadNibNamed("HomeMapView", owner: self, options: nil)![0] as! HomeMap
//        customInfoWindow.Name.text =  Name[marker.userData as! Int]
//        customInfoWindow.BtnREquest.tag = Ids[marker.userData as! Int]
//        customInfoWindow.PhoneNumber.text = Phone[marker.userData as! Int]
//        customInfoWindow.BtnREquest.layer.cornerRadius=10
//        customInfoWindow.BtnREquest.setTitle("Ensure Request".localized() , for:.normal)

        customInfoWindow.ParentView.layer.cornerRadius=10

        return customInfoWindow


    }
    
    
    //MARK: - this is function for create direction path, from start location to desination location
    
    func drawPath(startLocation: CLLocation, endLocation: CLLocation)
    {
        
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            do {
                let json = try  JSON(data: response.data!)
                let routes = json["routes"].arrayValue
                self.mapView.clear()
                
                // print route using Polyline
                for route in routes
                {
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline?["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeWidth = 2
                    polyline.strokeColor = UIColor.red
                    polyline.map = self.mapView
                }
            }
            catch let error as NSError {
                
            }
            
        }
}


}



extension OrderDetailsVC: CLLocationManagerDelegate {
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
        
        // load food car
        GetAllDeliveryGuy()
//         LoadDeliveryGuy(page: 1, limit: 100, status: "", lat: mylocation.coordinate.latitude, long: mylocation.coordinate.longitude, raduis: 10)
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
    
    ///action in view
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
      
        
    }
    
    
    
    
    //add marker with userdata
    func AddAllMarker( allmarks : [CLLocationCoordinate2D] , locationid :Int){
        for markcoordinate in  allmarks {
            let marker = GMSMarker(position: markcoordinate )
            marker.userData=locationid
            marker.icon = resizeImage(image: #imageLiteral(resourceName: "map_marker_food_car"), targetSize: CGSize(width:50, height: 50))
            marker.tracksViewChanges = true
            marker.map = mapView
        }
        
        
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
        var bounds = GMSCoordinateBounds (coordinate: firstLocation!, coordinate: firstLocation!)
        for marker: GMSMarker in markers {
            bounds = bounds.includingCoordinate(marker.position)
        }
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 110))
   
        
        
    }
    
    
    func Configaremap(){
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
        mapView = GMSMapView.map(withFrame: myview.bounds , camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        mapView.settings.zoomGestures = true
        // Add the map to the view, hide it until we've got a location update.
        myview.addSubview(mapView)
        mapView.isHidden = true
        mapView.delegate=self
        //defined mapview apper
       
       
        
    }
    
//    //load Delivery Guy
//    func LoadDeliveryGuy(page :Int ,limit :Int ,status :String,lat :Double , long: Double , raduis:Int)  {
//        Getallproducterepo.GetDeliveryGuy(page:page , limit: limit, status: status, lat: lat, long: long, radius: raduis) { (SuccessResponse) in
//            if(SuccessResponse != nil){
//                self.id = 0
//                var lat :Float = 0
//                var lng :Float = 0
//                //Success Get ownerInfo
//                let data=SuccessResponse
//                print(data)
//                if data != nil {
//
//                    if(self.Foodcarid.count == 0){
//
//                    }else{
//                        self.LoadOwnerProfileInfo(id:Int(self.Foodcarid[self.counter].id)! )
//                    }
//
//
//
//
////                    print(data)
////                    for delivery in data {
////                        lat = delivery.location.lat
////                        lng = delivery.location.lng
////                        self.AddAllMarker(allmarks: [CLLocationCoordinate2D(latitude: CLLocationDegrees(lat)  , longitude:  CLLocationDegrees(lng) ) ], locationid:self.id )
////                        self.showmark.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude:  CLLocationDegrees(lng)))
////
////                        self.id = self.id+1
////
////                    }
////                    self.showmark.append(self.mylocation.coordinate)
////                    self.showAllMarkers(marke: self.showmark )
//
//
//
//                }
//
//            }
//        }
//
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func GetAllDeliveryGuy(){
         FoodCararry=[]
         Ids=[]
         Name=[]
         Phone=[]
         LocationFoodcar=[]
         AllFoodcar=[]
         Foodcarid=[]
         counter = 0
        
        
//        Getallproducterepo.GetDeliveryGuy(page: 1, limit: 100, status: "", lat: mylocation.coordinate.latitude, long: mylocation.coordinate.longitude, radius: 1000) { (response) in
//            self.Foodcarid = response
//            if(response.count != 0){
//                for index in 0...response.count-1 {
//                    self.LoadOwnerProfileInfo(id:Int(self.Foodcarid[index].id)!, index: index)
//                }
//            }
//
        
          
//            if(self.Foodcarid.count == 0){
//
//            }else{
//                self.LoadOwnerProfileInfo(id:Int(self.Foodcarid[self.counter].id)! )
//            }
//
//            print(response)
        
        }
        
        
        
        
        
        
        
        
    }
    
    //load OwnerProfile
    func LoadOwnerProfileInfo(id :Int ,index:Int )  {
//        Getallproducterepo.GetDeliveryguyInfo(id:id) { (SuccessResponse) in
//            if(SuccessResponse != nil){
//
//                //Success Get ownerInfo
//                let data=SuccessResponse
//                print(data)
//                if data != nil {
//
//
//                    self.AllFoodcar.append(SuccessResponse)
////                    if(self.Foodcarid.count-1 > self.counter ){
//                    self.AddFoodcarMarker(id:index)
//                    self.showAllMarkers(marke: self.showmark )
//                        //load data
////                        self.LoadOwnerProfileInfo(id:Int(self.Foodcarid[self.counter].id)! )
////                    }else{
//                        ///show marker in map
//
//
//
////                    }
//                  //  self.counter = self.counter+1
//
//                }
//
//            }
//        }
        
    }
    
    
    
    //add marker
    func AddFoodcarMarker(id:Int){
        
//        for  foodcar in AllFoodcar{
//            let name = foodcar.name!
//            let myid = foodcar.id!
//            let phone = foodcar.phone!
//
//
//
//            self.Ids.append(myid)
//            self.Name.append(name)
//            self.Phone.append(phone)
//
//            // print(location)
//            let lat = Double(foodcar.location.lat)
//            let lng = Double(foodcar.location.lng)
//
//            self.AddAllMarker(allmarks: [CLLocationCoordinate2D(latitude: lat  , longitude:  lng ) ], locationid:id )
//            self.showmark.append(CLLocationCoordinate2D(latitude: lat , longitude:  lng))
//
//
//
//            print("------------------")
//            print(self.Ids)
//            print(self.Name)
//
//            print(self.Phone)
//
//
//        }
        
        
        
        
//
//        self.showmark.append(self.mylocation.coordinate)
//        //  self.showAllMarkers(marke: self.showmark )
        
    }
    
    
    
    
    
    
    
    
    
    
    
    



