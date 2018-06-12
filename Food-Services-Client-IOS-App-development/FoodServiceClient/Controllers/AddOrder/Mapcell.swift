//
//  Mapcell.swift
//  FoodService
//
//  Created by index-ios on 3/26/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON
import Material
class Mapcell: UITableViewCell {
    var homecookerlocation :CLLocationCoordinate2D!
    var mylocation = CLLocation()
    var locationmaanager = CLLocationManager()

    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var id:Int!
    var profiletype:String!
    var Btnlocation :CLLocationCoordinate2D!
     //mapview apper
    var myview :UIView!
    var btn : RaisedButton!
    
    // The currently selected place.
    var myidlocation:Int!
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
    
        //create google map
        let camera = GMSCameraPosition.camera(withLatitude: mylocation.coordinate.latitude,
                                              longitude:mylocation.coordinate.longitude ,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: viewcellmap.bounds , camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        // Add the map to the view, hide it until we've got a location update.
        viewcellmap.addSubview(mapView)
        mapView.isHidden = true
        mapView.delegate=self
      //defined mapview apper
        myview=UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        btn = RaisedButton(frame: CGRect.init(x: 20, y: 10, width: 160, height: 50))
        
        
    }

    func setorderdata(neworderdata:Int ,profiletype :String ,homecookerlocation:CLLocationCoordinate2D,locationid:Int){
        self.myidlocation = locationid
        self.id=neworderdata
        self.profiletype=profiletype
        self.homecookerlocation = homecookerlocation
        GetAllPlacesOfHmeCoker(id: id, type: profiletype)
        self.AddAllMarker(allmarks: [self.homecookerlocation], locationid: locationid)
        
    }

}






extension Mapcell: CLLocationManagerDelegate {
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
    func AddAllMarker( allmarks : [CLLocationCoordinate2D] , locationid :Int){
        for markcoordinate in  allmarks {
            let marker = GMSMarker(position: markcoordinate )
            marker.userData=locationid
            if(retetrivecard().cookerDeliveryType == "FOOD_CAR"){
                marker.icon = resizeImage(image: #imageLiteral(resourceName: "map_marker_food_car"), targetSize: CGSize(width:50, height: 50))

            }else{
                if(myidlocation == locationid){
                    marker.icon = resizeImage(image: #imageLiteral(resourceName: "map_marker_home_cooker"), targetSize: CGSize(width:50, height: 50))
                }else{
                    marker.icon = resizeImage(image: #imageLiteral(resourceName: "receiving_place_green"), targetSize: CGSize(width:50, height: 50))
                }
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




extension Mapcell :  GMSMapViewDelegate
{
    // when click in  maker
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
      EditdeliveryPlace(locationid:marker.userData as! Int )
        
    }
    
    ///to apper custom view when clicked in marker
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        if (myidlocation! == Int(marker.userData as! Int)  ){
           return nil
        }else{
            myview.backgroundColor = UIColor.white
            myview.layer.cornerRadius = 6
            myview.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3033243815)
            
            btn.title="Choose location".localize()
            btn.titleColor=#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            btn.backgroundColor=#colorLiteral(red: 0.3453582227, green: 0.7255285978, blue: 0.8235332966, alpha: 1)
            btn.shadowColor=#colorLiteral(red: 0.3453582227, green: 0.7255285978, blue: 0.8235332966, alpha: 0.6221313477)
            btn.layer.cornerRadius=6
            Btnlocation=marker.position
            btn.titleLabel?.font=UIFont(name: "system", size: 8)
            self.myview.addSubview(btn)
            return myview
        }
        
       
        return myview
        
    }
    //action whenclick button choose location
//    @objc func ChooseLocation(){
//        print("enter3")
//        print(Btnlocation)
//      }
   
    
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
    
    //get informatio homecooker request
    func GetAllPlacesOfHmeCoker(id : Int, type:String) {
        var   profiletype = ""
        switch type {
        case "HOME_COOKER":profiletype="home-cookers"
        case "PARTY_COOKER":profiletype="party-cookers"
        case "FOOD_CAR":profiletype="food-cars"
        default : break
            
        }
        GetallHomeCookerplaces.GetHomeCookerPlace(ownedid: id, type: profiletype) { (SuccessResponse) in
            if(SuccessResponse != nil){
                //Success Get All HomeCooker
                let deliveryPlaces=SuccessResponse
                for deliveryPlace in deliveryPlaces {
                    if (deliveryPlace != nil && deliveryPlace.deliveryPlace.HomecokerLocation != nil ) {
                        self.AddAllMarker(allmarks: [CLLocationCoordinate2D(latitude: Double(deliveryPlace.deliveryPlace.HomecokerLocation.lat) , longitude:  Double(deliveryPlace.deliveryPlace.HomecokerLocation.lng)) ], locationid: deliveryPlace.deliveryPlace.id )
                        
                        print(deliveryPlace)
                       } }}}
        
        
        
        
        
    }
    
    func EditdeliveryPlace(locationid :Int){
        var card = retetrivecard()
        UserDefaults.standard.removeSuite(named: Card)
        card.deliveryPlace = locationid
        
        var addcarddata = [String : Any ]()
        var  dictionarydata:[[String:Any]]=[]
        for dic in card.productOrders {
            dictionarydata.append(dic.toDictionary())
        }
        
        
        
        
        addcarddata=["ownedid" : card.ownedid ,
                     "client": card.client ,
                     "deliveryDate" : card.deliveryDate ,
                     "clientDeliveryType": card.clientDeliveryType ,
                     "cookerDeliveryType": card.cookerDeliveryType,
                     "deliveryPlace":card.deliveryPlace,
                     "productOrders" : dictionarydata]
        
        let carddata=Cardorder.init(fromDictionary: addcarddata)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: carddata)
        UserDefaults.standard.set(encodedData, forKey: Card)
        UserDefaults.standard.synchronize()
        print(retetrivecard().toDictionary())
    }

    
  
    
    
}








