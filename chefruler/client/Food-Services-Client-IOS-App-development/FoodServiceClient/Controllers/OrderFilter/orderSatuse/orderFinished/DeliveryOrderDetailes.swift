//
//  DeliveryOrderDetailes.swift
//  FoodServiceClient
//
//  Created by Index on 5/17/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON
import Material
class DeliveryOrderDetailes: UIViewController {
    
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var myview: UIView!
    @IBOutlet weak var Labellongpress: UILabel!
    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var Distanse: UILabel!
    @IBOutlet weak var DeliveryCoastLabel: UILabel!
    @IBOutlet weak var Deliverycoast: UILabel!
    
    
    var  Orderdetailes:OrderData!
    var deliveryguy:DeliveryGuyInfoRes!
    
    var homecookerlocation :CLLocationCoordinate2D!
    var mylocation = CLLocation()
    var sendlocation = CLLocation()
    var locationmaanager = CLLocationManager()
    
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 10.0
    var id:Int!
    var profiletype:String!
    var Btnlocation :CLLocationCoordinate2D!
    //mapview apper
   
    // The currently selected place.
    var myidlocation:Int!
    var getallproducterepo = GetallProdacteRepo()
    var ChooseItem:[Int]=[]
    var name:String!
    //map confic
    var lat:Double!
    var long:Double!
    var longPressRecognizer = UILongPressGestureRecognizer()
    var arrayCoordinates : [CLLocationCoordinate2D] = []
    var cookerlocation:CLLocationCoordinate2D!
    var deliverylocation:CLLocationCoordinate2D!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setuprecognizer()
        // Do any additional setup after loading the view.
    }
    func setup(){
        setupNavigationBar()
//        self.navigationItem.backBarButtonItem?.title = "Back".localized()
        
        Labellongpress.text =  "Long Press To Determine Location".localized()
        DistanceLabel.text = "Distance".localize()
        DeliveryCoastLabel.text = "Delivery Cost".localize()
        btnSend.setTitle("Confirm Order".localize(), for: .normal)
        btnSend.layer.cornerRadius = 10
        //draw for path and marker
        cookerlocation = CLLocationCoordinate2D(latitude:Double(Orderdetailes.cooker.location.lat) , longitude: Double(Orderdetailes.cooker.location.lng))
        deliverylocation = CLLocationCoordinate2D(latitude: Double(deliveryguy.location.lat), longitude:Double(deliveryguy.location.lng) )

        Configaremap()
      
         self.btnSend.isHidden = self.getallproducterepo.IsSend.value
        
        //two api to get data
        
        
        
        
    }
    
    
    @IBAction func BtnSendAction(_ sender: Any) {
                if (arrayCoordinates.count == 0) {
                    UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please Choose Location ".localize())
                }else{
                    myLoader.showCustomLoaderview(uiview: self.view)
                    myLoader.showCustomLoaderview(uiview: self.view)
                    if sendlocation == nil {
                        getallproducterepo.SendOrderDeliveryGuy(DeliveryId: deliveryguy.id, cookerlocation: cookerlocation, deliverylocation: deliverylocation, Orderlaction: mylocation.coordinate, orderid: Orderdetailes.id) { (resulte) in
                            print(resulte)
                            self.Distanse.text = "\(resulte.km!) \("Km".localize())"
                            self.Deliverycoast.text = "\(resulte.price!) \("Riyal".localize())"
                            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Order Send".localize())
                            self.btnSend.isHidden = self.getallproducterepo.IsSend.value
                            myLoader.hideCustomLoader()
                        }
                    }else{
                        getallproducterepo.SendOrderDeliveryGuy(DeliveryId: deliveryguy.id, cookerlocation: cookerlocation, deliverylocation: deliverylocation, Orderlaction: sendlocation.coordinate, orderid: Orderdetailes.id) { (resulte) in
                            print(resulte)
                            self.Distanse.text = "\(resulte.km!) \("Km".localize())"
                            self.Deliverycoast.text = "\(resulte.price!) \("Riyal".localize())"
                            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Order Send".localize())
                            self.btnSend.isHidden = self.getallproducterepo.IsSend.value
                            myLoader.hideCustomLoader()
                        }
                    }
                    
                   
                    
        }
        
        
    }
    

  

}

extension DeliveryOrderDetailes :  GMSMapViewDelegate
{
    
  
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
                    polyline.strokeWidth = 2.5
                    polyline.strokeColor = #colorLiteral(red: 0.3475901783, green: 0.7251545787, blue: 0.8235487342, alpha: 1)
                    polyline.map = self.mapView
                }
            }
            catch let error as NSError {
                
            }
            
        }
    }
    
    
}



extension DeliveryOrderDetailes: CLLocationManagerDelegate {
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
        arrayCoordinates.append(mylocation.coordinate)
        Drawsetup(cooker: cookerlocation, delivery: deliverylocation, location:mylocation.coordinate )
        locationmaanager.stopUpdatingLocation()

      
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
    
  
    
    
    //add !marker with userdata
    func AddAllMarker( allmarks : [CLLocationCoordinate2D] , locationid :Int){
        for markcoordinate in  allmarks {
            let marker = GMSMarker(position: markcoordinate )
            marker.userData=["index": locationid]
            marker.icon = resizeImage(image: #imageLiteral(resourceName: "xxxhdpi"), targetSize: CGSize(width:50, height: 50))
            marker.tracksViewChanges = true
            marker.map = mapView
        }
    }
    func addcookermarker( allmarks : [CLLocationCoordinate2D] , locationid :Int){
        for markcoordinate in  allmarks {
            let marker = GMSMarker(position: markcoordinate )
            marker.userData=["index": -1]
            
            marker.icon = resizeImage(image: #imageLiteral(resourceName: "map_marker_home_cooker"), targetSize: CGSize(width:50, height: 50))
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
    func Drawsetup(cooker :CLLocationCoordinate2D ,delivery :CLLocationCoordinate2D , location:CLLocationCoordinate2D){
        addcookermarker(allmarks: [cooker], locationid: -1)
        AddAllMarker(allmarks: [delivery], locationid: 0)
        showAllMarkers(marke: [ cooker,delivery,location ])
        
        drawPath(startLocation: CLLocation(latitude: cookerlocation.latitude, longitude: cookerlocation.longitude), endLocation: CLLocation(latitude: deliverylocation.latitude, longitude: deliverylocation.longitude))
        drawPath(startLocation: CLLocation(latitude: cookerlocation.latitude, longitude: cookerlocation.longitude), endLocation: CLLocation(latitude: location.latitude, longitude: location.longitude))
        getallproducterepo.GetOrderPriceDeliveryGuy(DeliveryId: deliveryguy.id, cookerlocation: cookerlocation, deliverylocation: deliverylocation, Orderlaction: mylocation.coordinate, orderid: Orderdetailes.id) { (resulte) in
            self.Deliverycoast.text = "\(resulte.price!) \("Riyal".localize())"
            self.Distanse.text = "\(resulte.km!) \("Km".localize())"
        }
        
    }
    
    
    
    
    
}


extension DeliveryOrderDetailes : UIGestureRecognizerDelegate{
    
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
    
    func setuprecognizer(){
        longPressRecognizer = UILongPressGestureRecognizer(target: self,
                                                           action: #selector(self.longPress))
        longPressRecognizer.minimumPressDuration = 0.5
        longPressRecognizer.delegate = self
        mapView.addGestureRecognizer(longPressRecognizer)
        
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        
    }
    
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        mapView.clear()
        arrayCoordinates = []
        let newMarker = GMSMarker(position: mapView.projection.coordinate(for: sender.location(in: mapView)))
        self.arrayCoordinates.append(newMarker.position)
        newMarker.layer.backgroundColor = #colorLiteral(red: 0, green: 0.5886496902, blue: 0.6524611712, alpha: 1)
        newMarker.map = mapView
        Drawsetup(cooker: cookerlocation, delivery: deliverylocation, location:newMarker.position )
        mylocation = CLLocation(latitude:newMarker.position.latitude , longitude: newMarker.position.longitude)
        sendlocation = CLLocation(latitude:newMarker.position.latitude , longitude: newMarker.position.longitude)
    }
    
    
    
}

