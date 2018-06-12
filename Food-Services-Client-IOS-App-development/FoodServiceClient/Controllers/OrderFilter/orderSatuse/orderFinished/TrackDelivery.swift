//
//  TrackDelivery.swift
//  FoodServiceClient
//
//  Created by Index on 6/11/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON
import AlamofireImage
import SocketIO
class TrackDelivery: UIViewController {
    @IBOutlet weak var myview: UIView!
    
    var  orderItem : OrderData!
    var limit = 100
    var page = 1
    var pageCount = 2
    
    var homecookerlocation :CLLocationCoordinate2D!
    var mylocation = CLLocation()
    var locationmaanager = CLLocationManager()
    
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 10
    var id:Int!
    var profiletype:String!
    var Btnlocation :CLLocationCoordinate2D!
    //mapview apper
    
    var showmark :[CLLocationCoordinate2D]=[]
    // The currently selected place.
    var myidlocation:Int!
    var Getallproducterepo = GetallProdacteRepo()
    
    
    var  raduis=10000
    let foodcarmapmarker = 1
    let resturantmapmarker = 2
    var getallproducterepo = GetallProdacteRepo()
    var counter = 0
    
    var customViewDelivery:DeliveryTarckpopup!
    
   
    var timer:Timer = Timer()
    var deliveryMarkers:[GMSMarker]=[]
    
    var polylines:[GMSPolyline]=[]
    var mymarker:GMSMarker!
    var DeliveryGuyLocation:DeliveryGuy!
    
    
    
    var  socket:SocketIOClient!

   
    let socketmanger = SocketManager(socketURL: URL(string: "http://165.227.96.25/locations")!, config: [.log(true), .compress])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupNavigationBar()
        self.navigationController?.navigationBar.tintColor = .white
        
        self.navigationItem.backBarButtonItem?.title = "Back".localized()
        
        
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
        mapView.settings.zoomGestures = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // mapView.isMyLocationEnabled = true
        mylocation = locationmaanager.location!
        // Add the map to the view, hide it until we've got a location update.
        myview.addSubview(mapView)
        mapView.isHidden = true
        mapView.delegate=self
        mylocation = locationmaanager.location!
       

        
            
        DeliveryGuyLocation = orderItem.deliveryGuy
            // is  get delivery  guy
            self.title = "Order Location".localize()
            self.navigationController?.navigationBar.tintColor = .white
//            AddHomeorDeliveryplaceMarker(allmarks: [CLLocationCoordinate2D(latitude:Double(orderItem.cooker.location.lat) , longitude: Double(orderItem.cooker.location.lng))], locationid: -1)
        
            AddHomeorDeliveryplaceMarker(allmarks: [CLLocationCoordinate2D(latitude:Double(mylocation.coordinate.latitude) , longitude: Double(mylocation.coordinate.longitude))], locationid: -2)
            
        AddAllDeliveryGuyMarker(allmarks:[CLLocationCoordinate2D(latitude:Double(DeliveryGuyLocation.location.lat ) , longitude: Double(DeliveryGuyLocation.location.lng))] , locationid: 0)
        
        
        
        
        drawPath(startLocation:CLLocation(latitude: Double(DeliveryGuyLocation.location.lat ), longitude: Double(DeliveryGuyLocation.location.lng)) , endLocation: mylocation)
        
            
            self.customViewDelivery = Bundle.main.loadNibNamed("DeliveryTrackPopupview", owner: self, options: nil)![0] as! DeliveryTarckpopup

            self.customViewDelivery.frame = CGRect(x: 0, y: self.view.layer.frame.height, width: self.view.layer.frame.width, height: self.view.layer.frame.height*50/100)

            self.view.addSubview(self.customViewDelivery)
        
            
            
     print("socker")
    configsocketio(id: String(orderItem.deliveryGuy.id))
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    
    func configsocketio(id:String){
        socket  = socketmanger.defaultSocket
        socket.on(clientEvent: .connect) { (data, ack) in
            print(ack.expected)
            print(data)
            self.TrackId(id: id)
            
        }
        socket.on(clientEvent: .reconnect) { (data, ack) in
            print(ack.expected)
             print(data)
            self.TrackId(id: id)
            
        }
        socket.on("locationUpdate") { (data, Ack) in
            print(Ack)
            print(data)
        }
        
        
     socket.connect()
    }
    func DisconnectSocket(){
    socket.emit("untrack");
    socket.disconnect()
    }
    func TrackId(id:String){
        let JsonTrack = ["id",id]
      socket.emit("track", with: JsonTrack)
    }
  
    
  
    
    @objc func AppearMapView(myindex:Int){
        
        UIView.animate(withDuration: 3) {
        self.customViewDelivery.OrderNumberLabel.text = "Order Number".localize()
        self.customViewDelivery.OrderNumberValue.text = ": # \(self.orderItem.id!)"
        self.customViewDelivery.OrderStatusLabel.text = "Order Status".localize()
        self.customViewDelivery.OrderStatusValue.text = ": \(self.orderItem.status!)"
            self.customViewDelivery.OrderDetailes.text = "\("Order Details".localize()) :"
         
       // self.customViewDelivery.NameValue.text = ": \(self.orderItem.deliveryGuy.name)"
        self.customViewDelivery.RateView.settings.updateOnTouch = false
         // self.customViewDelivery.RateView.rating = self.orderItem.deliveryGuy.rating
         self.customViewDelivery.Totaldistanselabel.text = "Total Distance".localize()
            self.customViewDelivery.TotaldistanseValue.text = "\(self.orderItem.km!) \("Km".localize())"
         self.customViewDelivery.AddressLabel.text = "Address".localize()
          //  self.customViewDelivery.AdressValue.text = "\(self.orderItem.deliveryGuy.address) "
            
            
            
            self.customViewDelivery.Totalchargelabel.text = "Total Charge".localize()
            self.customViewDelivery.AdressValue.text = "\(self.orderItem.price!) \("Riyal".localize()) "
            
            
            
       self.customViewDelivery.frame = CGRect(x: 0, y: self.view.layer.frame.height*50/100 , width: self.view.layer.frame.width, height: self.view.layer.frame.height*50/100)
                 self.view.layoutIfNeeded()
            
            
            
        }
         
          
            
            
        }
        
        
    
    

    
    
    @objc func DissAppearMapView(){
        UIView.animate(withDuration: 0.7, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
          
                
                self.customViewDelivery.frame = CGRect(x: 0, y: self.view.layer.frame.height, width: self.view.layer.frame.width, height: self.view.layer.frame.height*50/100)
                
          
            
            
        }, completion: nil)
    }
    
    
    

    
    
    
    
}






extension TrackDelivery: CLLocationManagerDelegate {
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
        //        AddAllResturanteMarker(allmarks: [CLLocationCoordinate2D(latitude:32.283475 , longitude: 30.616554)], locationid: 1)
        
        
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
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        Onclickout()
        DissAppearMapView()
        
    }
    
    
 
    
    func AddHomeorDeliveryplaceMarker( allmarks : [CLLocationCoordinate2D] , locationid :Int){
        for markcoordinate in  allmarks {
            let marker = GMSMarker(position: markcoordinate )
            //            marker.userData=["index": locationid , "type":foodcarmapmarker]
            if locationid == -2 {
                marker.icon = resizeImage(image: #imageLiteral(resourceName: "location").tint(with: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
            }else{
                switch orderItem.cooker.type {
                    
                case "HOME_COOKER":
                    marker.icon = resizeImage(image: #imageLiteral(resourceName: "map_marker_home_cooker").tint(with: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
                    break
                case "PARTY_COOKER":
                    marker.icon = resizeImage(image: #imageLiteral(resourceName: "map_marker_party_cooker").tint(with: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
                    break
                case "FOOD_CAR":
                    marker.icon = resizeImage(image: #imageLiteral(resourceName: "map_marker_food_car").tint(with: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
                    break
                    
                case "RESTURANTE":
                    marker.icon = resizeImage(image: #imageLiteral(resourceName: "tray (1)").tint(with: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
                    break
                case "DELIVERY_GUY":
                    marker.icon = resizeImage(image: #imageLiteral(resourceName: "receiving_place_green-3").tint(with: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
                    break
                    
                default : break
                    
                }
                
            }
            
            
            
            marker.tracksViewChanges = true
            marker.map = mapView
        }
    }
    
    
    
    
    func AddAllDeliveryGuyMarker( allmarks : [CLLocationCoordinate2D] , locationid :Int){
        for markcoordinate in  allmarks {
            let marker = GMSMarker(position: markcoordinate )
            marker.userData=["index": locationid , "type":foodcarmapmarker]
            marker.icon = resizeImage(image: #imageLiteral(resourceName: "delivery_green_partner").tint(with: #colorLiteral(red: 0.1180874184, green: 0.1529679894, blue: 0.2294566929, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
            marker.tracksViewChanges = true
            marker.map = mapView
            deliveryMarkers.append(marker)
            
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
        var bounds = GMSCoordinateBounds(coordinate: firstLocation!, coordinate: firstLocation!)
        for marker: GMSMarker in markers {
            bounds = bounds.includingCoordinate(marker.position)
        }
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 110.0))
        
        
    }
    
    
}




extension TrackDelivery :  GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        DissAppearMapView()
    }
    
    
    
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
                    self.polylines.append(polyline)
                }
            }
            catch let error as NSError {
                
            }
            
        }
    }
    
    
    
    //    //action when click marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        
            AppearMapView(myindex: 0)
            
      
        return true
    }
    
    
    
    
    
    
    
    
   
    
//
//    //
//    //    //load OwnerProfile
//    func LoadOwnerProfileInfo(id :Int ,type :String )  {
//        myLoader.showCustomLoaderview(uiview: self.view)
//        Getallproducterepo.GetProfileInfo(id: id, type: "delivery-guys") { (SuccessResponse) in
//            if(SuccessResponse != nil){
//
//
//                var  cookerlocation = CLLocationCoordinate2D(latitude:Double(self.orderItem.cooker.location.lat) , longitude: Double(self.orderItem.cooker.location.lng))
//
//
//                var  deliverylocation = CLLocationCoordinate2D(latitude: Double(SuccessResponse.location.lat), longitude:Double(SuccessResponse.location.lng) )
//
//                self.getallproducterepo.GetOrderPriceDeliveryGuy(DeliveryId: SuccessResponse.id, cookerlocation: cookerlocation, deliverylocation: deliverylocation, Orderlaction: self.mylocation.coordinate, orderid: self.orderItem.id) { (resulte) in
//
//                    self.customViewDelivery.id = id
//                    self.customViewDelivery.Image.layer.cornerRadius =  self.customViewDelivery.Image.layer.height/2
//                    self.customViewDelivery.Image.af_setImage(withURL: URL(string: SuccessResponse.profileImg)!)
//                    self.customViewDelivery.Name.text = SuccessResponse.name
//                    self.customViewDelivery.RAteView.rating = SuccessResponse.rating
//                    self.customViewDelivery.RAteView.settings.updateOnTouch = false
//                    self.customViewDelivery.RAteView.settings.fillMode = .precise
//
//
//
//                    self.customViewDelivery.Distance.text = "\(resulte.km!) \("Km".localize())"
//                    self.customViewDelivery.AddressLabel.text = "Address".localize()
//                    self.customViewDelivery.AdressValue.text = SuccessResponse.address
//                    self.customViewDelivery.TotalCharge.text = "Total Charge".localize()
//                    self.customViewDelivery.TotlChargevalue.text = "\(resulte.price!) \("Riyal".localize())"
//
//                    self.customViewDelivery.ConfiremOrder.setTitle("Confirm Order".localize(), for: .normal)
//                    self.customViewDelivery.ConfiremOrder.layer.cornerRadius = 3
//
//
//
//                    self.customViewDelivery.ConfiremOrder.tag = id
//
//
//
//
//
//
//
//
//
//
//                    UIView.animate(withDuration: 1, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
//
//                        self.customViewDelivery.frame = CGRect(x: 0, y: self.view.layer.frame.height*65/100 , width: self.view.layer.frame.width, height: self.view.layer.frame.height*35/100)
//                        self.view.layoutIfNeeded()
//                    }, completion: { (istrue) in
//
//                    }
//                    )
//
//
//
//
//
//
//
//
//                    myLoader.hideCustomLoader()
//                }
//
//
//
//
//
//
//
//
//
//
//
//
//
//            }
//        }
//
//    }
//
//
//
//    func Checkclickmarker(id:Int){
//        var found = false
//        for marker in deliveryMarkers{
//            let dict = marker.userData as! [String:Int]
//            if let  myid = dict["index"] {
//                if Int( DeliVeryGuys[myid].id) == id {
//                    found = true
//
//                }}}
//        if found == false {
//            DissAppearMapView()
//        }
//
//    }
//
//
//
//
//    func OnclickMarker(deliverymarker:GMSMarker){
//
//        Onclickout()
//        mymarker.icon = resizeImage(image: #imageLiteral(resourceName: "location").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
//        deliverymarker.icon = resizeImage(image: #imageLiteral(resourceName: "delivery_green_partner").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
//
//        drawPath(startLocation:CLLocation(latitude: deliverymarker.position.latitude, longitude:deliverymarker.position.longitude ) , endLocation: mylocation)
//        drawPath(startLocation:CLLocation(latitude: deliverymarker.position.latitude, longitude:deliverymarker.position.longitude ) , endLocation:CLLocation(latitude:Double(orderItem.cooker.location.lat) , longitude: Double(orderItem.cooker.location.lng)) )
//
//
//    }
//
//    func Onclickout(){
//        for marker in deliveryMarkers {
//            marker.icon = resizeImage(image: #imageLiteral(resourceName: "xxxhdpi").tint(with: #colorLiteral(red: 0.1180874184, green: 0.1529679894, blue: 0.2294566929, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
//            marker.map = mapView
//        }
//        for polyen in polylines {
//            polyen.map = nil
//        }
//        mymarker.icon = resizeImage(image: #imageLiteral(resourceName: "location").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
//
//    }
//
//
//
//
//
    
    
    
    
}
