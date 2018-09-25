//
//  FinishedAndGetDirection.swift
//  FoodServiceClient
//
//  Created by Index on 6/5/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON
import AlamofireImage

class FinishedAndGetDirection: UIViewController {

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
    
    
    
    let foodcarmapmarker = 1
    let resturantmapmarker = 2
    var getallproducterepo = GetallProdacteRepo()
    var counter = 0
    var customView:HomeDeliveryplaceAdress!
    var customViewDelivery:OrderFinishGetDeliveryGuy!
    var isGetdirection = false
    var DeliVeryGuys:[DeliveryData]=[]
    var timer:Timer = Timer()
    var deliveryMarkers:[GMSMarker]=[]
    
    var polylines:[GMSPolyline]=[]
    var mymarker:GMSMarker!
    var mydeliverynow :DeliveryGuyInfoRes!
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
    if isGetdirection == true {
        //is get direction btn
        self.title = "Diraction".localize()
        self.navigationController?.navigationBar.tintColor = .white
        if orderItem.deliveryPlace != nil {
            AddDeliveryMarker(allmarks: [CLLocationCoordinate2D(latitude:Double(orderItem.deliveryPlace.location.lat) , longitude: Double(orderItem.deliveryPlace.location.lng))], locationid: 0)
            self.showmark.append(CLLocationCoordinate2D(latitude:Double(orderItem.deliveryPlace.location.lat) , longitude: Double(orderItem.deliveryPlace.location.lng)))
            showAllMarkers(marke: self.showmark)
        }else{
           AddHomeorDeliveryplaceMarker(allmarks: [CLLocationCoordinate2D(latitude:Double(orderItem.cooker.location.lat) , longitude: Double(orderItem.cooker.location.lng))], locationid: -1)
            self.showmark.append(CLLocationCoordinate2D(latitude:Double(orderItem.cooker.location.lat) , longitude: Double(orderItem.cooker.location.lng)))
            showAllMarkers(marke: [mylocation.coordinate , CLLocationCoordinate2D(latitude:Double(orderItem.cooker.location.lat) , longitude: Double(orderItem.cooker.location.lng)) ])
        }
//        AddHomeorDeliveryplaceMarker(allmarks: [CLLocationCoordinate2D(latitude:Double(orderItem.cooker.location.lat) , longitude: Double(orderItem.cooker.location.lng))], locationid: -1)
          AddHomeorDeliveryplaceMarker(allmarks: [CLLocationCoordinate2D(latitude:Double(mylocation.coordinate.latitude) , longitude: Double(mylocation.coordinate.longitude))], locationid: -2)
        
        
        DrawPathHomeCoker()
        
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.DrawPathHomeCoker), userInfo: nil, repeats: false)
        
        
        
        
        self.customView = Bundle.main.loadNibNamed("HomeDeliveryplaceviewAdressView", owner: self, options: nil)![0] as! HomeDeliveryplaceAdress
        self.customView.frame = CGRect(x: self.view.layer.frame.width*5/100, y: self.view.layer.frame.height, width: self.view.layer.frame.width-self.view.layer.frame.width*10/100, height: self.view.layer.frame.height*20/100)
        self.view.layoutIfNeeded()
        AppearMapView(myindex: 0)
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.AppearMapView(myindex:)), userInfo: nil, repeats: false)

        self.view.addSubview(self.customView)
        
        
    }else{
    // is  get delivery  guy
        self.title = "Get Delivery Guy".localize()
        self.navigationController?.navigationBar.tintColor = .white
         AddHomeorDeliveryplaceMarker(allmarks: [CLLocationCoordinate2D(latitude:Double(orderItem.cooker.location.lat) , longitude: Double(orderItem.cooker.location.lng))], locationid: -1)
        
        AddHomeorDeliveryplaceMarker(allmarks: [CLLocationCoordinate2D(latitude:Double(mylocation.coordinate.latitude) , longitude: Double(mylocation.coordinate.longitude))], locationid: -2)
        
         GetAllDeliveryGuy()
         self.timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.GetAllDeliveryGuy), userInfo: nil, repeats: true)
        
        self.customViewDelivery = Bundle.main.loadNibNamed("OrderFinishGetDeliveryGuyView", owner: self, options: nil)![0] as! OrderFinishGetDeliveryGuy
        
        self.customViewDelivery.frame = CGRect(x: 0, y: self.view.layer.frame.height, width: self.view.layer.frame.width, height: self.view.layer.frame.height*35/100)
        
        self.view.addSubview(self.customViewDelivery)
        
        
    
    }
    
    
    
    
   
    
    
    
    

  mymarker = GMSMarker(position: CLLocationCoordinate2D(latitude:Double(mylocation.coordinate.latitude) , longitude: Double(mylocation.coordinate.longitude)))
    
    
    
    
}


    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    @objc func DrawPathHomeCoker(){
        print(orderItem.deliveryPlace)
        if orderItem.deliveryPlace != nil {
            drawPath(startLocation: CLLocation(latitude: Double(orderItem.deliveryPlace.location.lat) , longitude: Double(orderItem.deliveryPlace.location.lng) ), endLocation: mylocation)
            
        }else{
            
            drawPath(startLocation: CLLocation(latitude: Double(orderItem.cooker.location.lat) , longitude: Double(orderItem.cooker.location.lng) ), endLocation: mylocation)
            showAllMarkers(marke: [mylocation.coordinate , CLLocationCoordinate2D(latitude:Double(orderItem.cooker.location.lat) , longitude: Double(orderItem.cooker.location.lng)) ])
            
        }
       
        
        
    }
    
    @objc func Gotoprofile(){
        if isGetdirection == true {
            var   profiletype = ""
            switch orderItem.cooker.type {
            case "HOME_COOKER":profiletype="home-cookers"
            case "PARTY_COOKER":profiletype="party-cookers"
            case "FOOD_CAR":profiletype="food-cars"
            case "RESTAURANT_OWNER":profiletype="restaurant-owners"
            default : break
                
            }
            Getallproducterepo.SendOrderStatus(Orderid: orderItem.id , clientid: orderItem.cooker.id , Status: "DELIVERED", type:profiletype) { (successresponse) in
                print("Send Success \(successresponse)")
            }
            
            
        }else{
            
            
            
            ///chosse llocation
            
            
            
            
            
//            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc : Profile = storyboard.instantiateViewController(withIdentifier: "ProfileHomeCookerMap") as! Profile
//
//
//            var   profiletype = ""
//            switch orderItem.cooker.type {
//            case "HOME_COOKER":profiletype="home-cookers"
//            case "PARTY_COOKER":profiletype="party-cookers"
//            case "FOOD_CAR":profiletype="food-cars"
//            case "RESTAURANT_OWNER":profiletype="restaurant-owners"
//            default : break
//
//            }
//
//
//            UserDefaults.standard.set( orderItem.cooker.id , forKey: Profileid)
//            UserDefaults.standard.set( profiletype , forKey: Profiletype)
//            UserDefaults.standard.set( 1 , forKey: Type)
//            UserDefaults.standard.set( orderItem.cooker.id , forKey: HomeCookerId)
//
//            vc.navigationController?.navigationBar.tintColor = .white
//            setupNavigationBar()
//            //        vc.navigationItem.backBarButtonItem?.title = "Back".localized()
//
//            self.navigationController!.pushViewController(vc, animated: true)
        }
        
        
    }

    @objc func AppearMapView(myindex:Int){
        
        
        if self.isGetdirection {
            
            
            UIView.animate(withDuration: 1, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
                
                self.customView.Adresslabel.text = "Address".localize()
                
                self.customView.AdressValue.text = self.orderItem.cooker.address
                
                self.customView.BtnDone.layer.cornerRadius = 3
                self.customView.layer.cornerRadius = 3
                 self.customView.BtnDone.sizeToFit()
                self.customView.BtnDone.setTitle("Delivered".localize() , for: .normal )
                self.customView.BtnDone.removeTarget(nil, action: nil, for: .allEvents)
                self.customView.BtnDone.addTarget(self, action: #selector(self.Gotoprofile), for: .touchUpInside)
                self.customView.frame = CGRect(x: self.view.layer.frame.width*5/100, y: self.view.layer.frame.height*80/100, width: self.view.layer.frame.width-self.view.layer.frame.width*10/100, height: self.view.layer.frame.height*20/100)
                self.view.layoutIfNeeded()
                
                
                
                
                
            }, completion: { (istrue) in
                
            }
            )
            
            
           
            
        }else{
            self.LoadOwnerProfileInfo(id:Int(self.DeliVeryGuys[myindex].id )!, type: "")
            
            
            
        }
        
    
}


    @objc func DissAppearMapView(){
        if isGetdirection == true {
            
             }
        else{
            UIView.animate(withDuration: 0.7, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
                if self.isGetdirection {
                    self.customView.frame = CGRect(x: self.view.layer.frame.width*5/100, y: self.view.layer.frame.height, width: self.view.layer.frame.width-self.view.layer.frame.width*10/100, height: self.view.layer.frame.height*20/100)
                    self.view.layoutIfNeeded()
                    
                }else{
                    
                    self.customViewDelivery.frame = CGRect(x: 0, y: self.view.layer.frame.height, width: self.view.layer.frame.width, height: self.view.layer.frame.height*35/100)
                    
                    
                    
                }
                
                
                
                
            }, completion: nil)
        }
        
    }




//@objc func BtnNextActionFoodCar(sender:UIButton){
//    //push here
//    UserDefaults.standard.set(ResFoodCar[sender.tag].id  , forKey: Profileid)
//    UserDefaults.standard.set( "food-cars", forKey: Profiletype)
//    UserDefaults.standard.set(  ResFoodCar[sender.tag].id , forKey: PartyCookerId)
//    UserDefaults.standard.set( 2 , forKey: Type)
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    let vc = storyboard.instantiateViewController(withIdentifier: "GetAllProducteAndFilter")
//
//    self.navigationController?.pushViewController(vc, animated: true)
//
//}




}






extension FinishedAndGetDirection: CLLocationManagerDelegate {
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        mylocation=locations[0]
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        self.showmark.append(CLLocationCoordinate2D(latitude:Double(mylocation.coordinate.latitude) , longitude: Double(mylocation.coordinate.longitude)))
        
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
         Onclickout()
        DissAppearMapView()

    }

    
    //add marker with userdata
    func AddDeliveryMarker( allmarks : [CLLocationCoordinate2D] , locationid :Int){
        for markcoordinate in  allmarks {
            let marker = GMSMarker(position: markcoordinate )
            marker.userData=["index": locationid , "type":resturantmapmarker]
            marker.icon = resizeImage(image: #imageLiteral(resourceName: "receiving_place_green-2").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
            marker.tracksViewChanges = true
            marker.map = mapView
        }
        
        
    }
    
    func AddHomeorDeliveryplaceMarker( allmarks : [CLLocationCoordinate2D] , locationid :Int){
        for markcoordinate in  allmarks {
            let marker = GMSMarker(position: markcoordinate )
//            marker.userData=["index": locationid , "type":foodcarmapmarker]
            if locationid == -2 {
                marker.icon = resizeImage(image: #imageLiteral(resourceName: "location").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
            }else{
                switch orderItem.cooker.type {
                    
                case "HOME_COOKER":
                    marker.icon = resizeImage(image: #imageLiteral(resourceName: "map_marker_home_cooker").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
                    break
                case "PARTY_COOKER":
                    marker.icon = resizeImage(image: #imageLiteral(resourceName: "map_marker_party_cooker").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
                    break
                case "FOOD_CAR":
                    marker.icon = resizeImage(image: #imageLiteral(resourceName: "map_marker_food_car").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
                    break
                    
                case "RESTURANTE":
                    marker.icon = resizeImage(image: #imageLiteral(resourceName: "tray (1)").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
                    break
                case "DELIVERY_GUY":
                    marker.icon = resizeImage(image: #imageLiteral(resourceName: "receiving_place_green-3").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
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




extension FinishedAndGetDirection :  GMSMapViewDelegate
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
                self.showAllMarkers(marke: self.showmark)
            }
            catch let error as NSError {
                
            }
            
        }
    }
    
    
    
//    //action when click marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
       
        if isGetdirection {
          //  AppearMapView(myindex: 0)
            
        }else{
            
            
            if  marker.userData != nil {
            let dict = marker.userData as! [String:Int]
            if let  myid = dict["index"] {
               
               AppearMapView(myindex:myid)
                
            }
            for marker in deliveryMarkers {
                marker.icon = resizeImage(image: #imageLiteral(resourceName: "delivery_green_partner").tint(with: #colorLiteral(red: 0.1180874184, green: 0.1529679894, blue: 0.2294566929, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
                marker.map = mapView
            }
            
            
         OnclickMarker(deliverymarker: marker)
         
            }
        }
   return true
    }
    
    

    
    
    

    
    @objc func GetAllDeliveryGuy(){
        
       
        
        Getallproducterepo.GetDeliveryGuy(page: 1, limit: 100, status: "", lat: mylocation.coordinate.latitude, long: mylocation.coordinate.longitude, radius: 1000) { (response) in
           
            for marker in self.deliveryMarkers {
                marker.map = nil
            }

            
            self.deliveryMarkers = []
            self.DeliVeryGuys = response.data
            if(response.data.count != 0){
                for index in 0...response.data.count-1 {
                   
                    
                    self.showmark.append(CLLocationCoordinate2D(latitude: Double(self.self.DeliVeryGuys[index].location.lat)!, longitude:Double(self.DeliVeryGuys[index].location.lng)!))
                    
                    self.AddAllDeliveryGuyMarker(allmarks: [CLLocationCoordinate2D(latitude: Double(self.DeliVeryGuys[index].location.lat)!, longitude:Double(self.DeliVeryGuys[index].location.lng)! ) ], locationid:index )
                    
                  
                }
                
            self.showmark.append(CLLocationCoordinate2D(latitude:Double(self.orderItem.cooker.location.lat) , longitude: Double(self.orderItem.cooker.location.lng)))
                self.showmark.append(self.mylocation.coordinate)
                self.showAllMarkers(marke: self.showmark )
                
                if self.customViewDelivery.id != nil {
                self.Checkclickmarker(id:self.customViewDelivery.id)
                }
            }else{
                self.showmark.append(CLLocationCoordinate2D(latitude:Double(self.orderItem.cooker.location.lat) , longitude: Double(self.orderItem.cooker.location.lng)))
                self.AddHomeorDeliveryplaceMarker(allmarks: [CLLocationCoordinate2D(latitude:Double(self.mylocation.coordinate.latitude) , longitude: Double(self.mylocation.coordinate.longitude))], locationid: -2)
                
                self.showmark.append(self.mylocation.coordinate)
                self.showAllMarkers(marke: self.showmark )
                
                self.DissAppearMapView()
            }
            
            
            print(response)
            
        }
        
        }
    

    
    
    
    
    
    
    
//
//    //load OwnerProfile
    func LoadOwnerProfileInfo(id :Int ,type :String )  {
        myLoader.showCustomLoaderview(uiview: self.view)
        Getallproducterepo.GetDeliveryguyInfo(id:id){ (SuccessResponse) in
            if(SuccessResponse != nil){

                
                var  cookerlocation = CLLocationCoordinate2D(latitude:Double(self.orderItem.cooker.location.lat) , longitude: Double(self.orderItem.cooker.location.lng))
                
                
                var  deliverylocation = CLLocationCoordinate2D(latitude: Double(SuccessResponse.location.lat), longitude:Double(SuccessResponse.location.lng) )
                
                self.getallproducterepo.GetOrderPriceDeliveryGuy(DeliveryId: SuccessResponse.id, cookerlocation: cookerlocation, deliverylocation: deliverylocation, Orderlaction: self.mylocation.coordinate, orderid: self.orderItem.id) { (resulte) in
                    
                   
                     self.customViewDelivery.id = id
                    self.customViewDelivery.Image.layer.cornerRadius =  self.customViewDelivery.Image.layer.height/2
                    self.customViewDelivery.Image.af_setImage(withURL: URL(string: SuccessResponse.profileImg)!)
                    self.customViewDelivery.Name.text = SuccessResponse.name
                    self.customViewDelivery.RAteView.rating = Double(SuccessResponse.rating)
                    self.customViewDelivery.RAteView.settings.updateOnTouch = false
                    self.customViewDelivery.RAteView.settings.fillMode = .precise
                    
                    
                    
                    self.customViewDelivery.Distance.text = "\(resulte.km!) \("Km".localize())"
                    self.customViewDelivery.AddressLabel.text = "Distance".localize()
                    
                    self.customViewDelivery.TotalCharge.text = "Total Charge".localize()
                    self.customViewDelivery.TotlChargevalue.text = "\(resulte.price!) \("Riyal".localize())"
                    
                     self.customViewDelivery.ConfiremOrder.setTitle("Confirm Order".localize(), for: .normal)
                    self.customViewDelivery.ConfiremOrder.layer.cornerRadius = 3
                    
                   
                    
                    self.customViewDelivery.ConfiremOrder.tag = id
                    self.customViewDelivery.ConfiremOrder.addTarget(self, action: #selector(self.SendOrder(sender:)), for: .touchUpInside)
                    
                    
                    self.mydeliverynow = SuccessResponse
                    
                    
                    
                    
                   
                    
                    UIView.animate(withDuration: 1, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
                        
                       self.customViewDelivery.frame = CGRect(x: 0, y: self.view.layer.frame.height*65/100 , width: self.view.layer.frame.width, height: self.view.layer.frame.height*35/100)
                        self.view.layoutIfNeeded()
                        }, completion: { (istrue) in
                        
                    }
                    )
                    
                    
                    
                    
                    
                    
                    
                    
               myLoader.hideCustomLoader()
                }
                
                
                
                
               
                
                
           


                


            }
        }

    }
    
    
    
    func Checkclickmarker(id:Int){
        var found = false
                   for marker in deliveryMarkers{
                    let dict = marker.userData as! [String:Int]
                    if let  myid = dict["index"] {
                       if Int( DeliVeryGuys[myid].id) == id {
                        found = true
                        
                          }}}
        if found == false {
            DissAppearMapView()
        }
        
    }
    
    

    
    func OnclickMarker(deliverymarker:GMSMarker){
        
       Onclickout()
       mymarker.icon = resizeImage(image: #imageLiteral(resourceName: "location").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
       deliverymarker.icon = resizeImage(image: #imageLiteral(resourceName: "delivery_green_partner").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
       
        drawPath(startLocation:CLLocation(latitude: deliverymarker.position.latitude, longitude:deliverymarker.position.longitude ) , endLocation: mylocation)
        drawPath(startLocation:CLLocation(latitude: deliverymarker.position.latitude, longitude:deliverymarker.position.longitude ) , endLocation:CLLocation(latitude:Double(orderItem.cooker.location.lat) , longitude: Double(orderItem.cooker.location.lng)) )
        
        
    }
    
    func Onclickout(){
        for marker in deliveryMarkers {
            marker.icon = resizeImage(image: #imageLiteral(resourceName: "xxxhdpi").tint(with: #colorLiteral(red: 0.1180874184, green: 0.1529679894, blue: 0.2294566929, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
            marker.map = mapView
        }
        for polyen in polylines {
            polyen.map = nil
        }
        mymarker.icon = resizeImage(image: #imageLiteral(resourceName: "location").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
        
    }
    
    @objc func SendOrder(sender:UIButton){
//       var cookerlocation = CLLocationCoordinate2D(latitude:Double(orderItem.cooker.location.lat) , longitude: Double(orderItem.cooker.location.lng))
//        for delivery in DeliVeryGuys{
//            if Int(delivery.id) == sender.tag {
//
//                getallproducterepo.SendOrderDeliveryGuy(DeliveryId: sender.tag, cookerlocation: cookerlocation, deliverylocation:  CLLocationCoordinate2D(latitude: Double(delivery.location.lat)!, longitude:Double(delivery.location.lng)! ), Orderlaction: mylocation.coordinate, orderid: orderItem.id) { (resulte) in
//                    print(resulte)
//
//                    UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Order Send".localize())
//                    self.dismiss(animated: true, completion: nil)
//                }
//
//
//
//            }
//        }
        
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let passController : DeliveryOrderDetailes = storyboard.instantiateViewController(withIdentifier: "DeliveryOrderDetailes") as! DeliveryOrderDetailes
        passController.Orderdetailes = orderItem
        passController.deliveryguy = mydeliverynow
        self.navigationController?.pushViewController(passController, animated: false)
        
        
       
    }
    
    
    
    
}

//extension FinishedAndGetDirection:DeliveryGuychoose {
//
//
//
//    func PushDeliveryOrderDetailes(Orderdetailes: OrderData, deliveryguy: DeliveryGuyInfoRes) {
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let passController : DeliveryOrderDetailes = storyboard.instantiateViewController(withIdentifier: "DeliveryOrderDetailes") as! DeliveryOrderDetailes
//        passController.Orderdetailes = Orderdetailes
//        passController.deliveryguy = deliveryguy
//        self.navigationController?.pushViewController(passController, animated: false)
//    }
//
//
//
//
//
//}


//extension FinishedAndGetDirection {
//
//    @objc func updateOrderStatus(_ sender: UIButton?) {
//        switch orderDetails?.status {
//        case OrderStatus.accepted.rawValue?:
//            self.status = OrderStatus.finished.rawValue
//        case OrderStatus.pending.rawValue?:
//            if sender?.tag == 0 {
//                self.status = OrderStatus.accepted.rawValue
//
//            } else if sender?.tag == 1 {
//                self.status = OrderStatus.refused.rawValue
//            }
//        case OrderStatus.arrived.rawValue?:
//            self.status = OrderStatus.finished.rawValue
//
//        default:
//            print("undefined status")
//        }
//        updateOrder()
//
//    }
//
//    func updateOrder() {
//
//        var cookerType:String = ""
//        print("cooker is \(self.orderDetails?.kind!)")
//
//        // order is cooker
//        if orderDetails?.cooker != nil {
//            // get cooker type :- home  cooker , party cooker , food car
//            if orderDetails?.cooker.type != nil {
//                cookerType = CookerType.checkType(userType: (orderDetails?.cooker.type)!)
//            }
//            myLoader.showCustomLoaderview(uiview: self.view)
//            orderRepo.updateOrderStatus(cookerType: cookerType, orderId: (self.orderDetails?.id)!, stauts: self.status , userId:(self.orderDetails?.cooker.id)!, onSuccess: { (statusCode) in
//                switch statusCode {
//                case StatusCode.undocumented.rawValue:
//                    Loader.hideLoader()
//                    DataUtlis.data.SuccessDialog(Title: "Success".localized(), Body: "Order Status Changed".localized())
//                    self.orderDetails?.status = self.status
//                    self.collectionView.reloadData()
//
//
//                default:
//                    myLoader.hideCustomLoader()
//
//                }
//            }) { (errorResponse, statusCode) in
//                Loader.hideLoader()
//                if let errorMessage = errorResponse?.error[0].msg {
//                    DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage)
//                }
//            }
//
//        } else if orderDetails?.deliveryGuy != nil{
//
//            // order is delivery guy
//
//            myLoader.showCustomLoaderview(uiview: self.view)
//            orderRepo.updateOrderStatus(cookerType: "delivery-guys", orderId: (self.orderDetails?.id)!, stauts: self.status , userId:(self.orderDetails?.cooker.id)!, onSuccess: { (statusCode) in
//                switch statusCode {
//                case StatusCode.undocumented.rawValue:
//                    Loader.hideLoader()
//                    DataUtlis.data.SuccessDialog(Title: "Success".localized(), Body: "Order Status Changed".localized())
//                    self.orderDetails?.status = self.status
//                    self.collectionView.reloadData()
//
//
//                default:
//                    myLoader.hideCustomLoader()
//
//                }
//            }) { (errorResponse, statusCode) in
//                Loader.hideLoader()
//                if let errorMessage = errorResponse?.error[0].msg {
//                    DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage)
//                }
//            }
//        }
//
//
//
//
//    }
//
//
//
//}








