//
//  MapCell.swift
//  FoodServiceClient
//
//  Created by Index on 5/16/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON
import AlamofireImage
class DetailesMapCell: UICollectionViewCell {
   var  orderdetailes : OrderData!
    
    //map configration
    var homecookerlocation :CLLocationCoordinate2D!
    var mylocation = CLLocation()
    var locationmaanager = CLLocationManager()
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 12
    var id:Int!
    var profiletype:String!
    var Btnlocation :CLLocationCoordinate2D!
    var Getallproducterepo = GetallProdacteRepo()
    //mapview apper
    var FoodCararry:[AllFoodCArData]=[]
    var Ids:[Int]=[]
    var Name:[String]=[]
    var Phone:[String]=[]
    var image:[String]=[]
    var LocationFoodcar:[NSArray]=[]
    var AllFoodcar:[DeliveryGuyInfoRes]=[]
    var Foodcarid:[FoodCarMapRes]=[]
    var counter = 0
    var showmark :[CLLocationCoordinate2D]=[]
    var parentviewcontroller:UIViewController!
  //  var  Orderdetailes:OrderData!
    
    var myview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints  = false
        
        return view
    }()
    
//    var Btnview: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints  = false
//        view.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
//        return view
//    }()
    
    var Deliverd : UIButton = {
        let button =  UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        button.setTitleColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), for: .normal)
        button.setTitle("Delivered".localize(), for: .normal )
        button.backgroundColor = #colorLiteral(red: 0.009331892245, green: 0.7435878515, blue: 0.8486500382, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addViews()
        Configaremap()
        addcookermarker(allmarks: [CLLocationCoordinate2D(latitude:Double(orderdetailes.cooker.location.lat) , longitude: Double(orderdetailes.cooker.location.lng))], locationid: -1)
        showAllMarkers(marke: [mylocation.coordinate , CLLocationCoordinate2D(latitude:Double(orderdetailes.cooker.location.lat) , longitude: Double(orderdetailes.cooker.location.lng)) ])
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        addViews()
        Configaremap()
        addcookermarker(allmarks: [CLLocationCoordinate2D(latitude:Double(orderdetailes.cooker.location.lat) , longitude: Double(orderdetailes.cooker.location.lng))], locationid: -1)
        showAllMarkers(marke: [mylocation.coordinate , CLLocationCoordinate2D(latitude:Double(orderdetailes.cooker.location.lat) , longitude: Double(orderdetailes.cooker.location.lng)) ])
        
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addViews()
        Configaremap()
        addcookermarker(allmarks: [CLLocationCoordinate2D(latitude:Double(orderdetailes.cooker.location.lat) , longitude: Double(orderdetailes.cooker.location.lng))], locationid: -1)
        showAllMarkers(marke: [mylocation.coordinate , CLLocationCoordinate2D(latitude:Double(orderdetailes.cooker.location.lat) , longitude: Double(orderdetailes.cooker.location.lng)) ])
    }
    
    func addViews() {
        

        self.addSubview(Deliverd)
        self.addSubview(myview)
        Deliverd.addTarget(self, action: #selector(DeliverdAction), for: .touchUpInside)
        myview.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0).offset(-self.contentView.layer.frame.height*20/100)
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(0)
        }
        

        Deliverd.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(self.contentView.layer.frame.height*20/100-8)
            make.top.equalTo(myview.snp.bottom).offset(5)

            
            
        }
        
        
        
    }
    
    @objc func DeliverdAction(){
        var type:String!
        switch orderdetailes.cooker.type {
        case "HOME_COOKER" :
            type = "home-cookers"
        case "FOOD_CAR" :
            type = "food-cars"
        case "PARTY_COOKER" :
            type = "party-cookers"
        
        case "RESTAURANT_OWNER":
            type="restaurant-owners"
        
        case .none:
            break
        case .some(_):
            break
           
        }
        print(orderdetailes.cooker.type)
        Getallproducterepo.SendOrderStatus(Orderid: orderdetailes.id , clientid: orderdetailes.cooker.id, Status: "DELIVERED", type:type) { (successresponse) in
            print("Send Success \(successresponse)")
        }
    }

    
    
    
    
    
}



extension DetailesMapCell :  GMSMapViewDelegate
{
    
    
    //to apper custom view when clicked in marker
//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        if(marker.userData as! Int == -1){
//            return nil
//        }else{
//            let customInfoWindow = Bundle.main.loadNibNamed("HomeMapView", owner: self, options: nil)![0] as! HomeMap
//            customInfoWindow.Name.text =  Name[marker.userData as! Int]
//            customInfoWindow.BtnREquest.tag = Ids[marker.userData as! Int]
//            customInfoWindow.PhoneNumber.text = Phone[marker.userData as! Int]
//            customInfoWindow.BtnREquest.layer.cornerRadius=10
//            customInfoWindow.BtnREquest.setTitle("Ensure Request".localized() , for:.normal)
//
//            customInfoWindow.ParentView.layer.cornerRadius=10
//            return customInfoWindow
//        }
//
//
//
//
//
//    }
    
    
    //MARK: - this is function for create direction path, from start location to desination location
    
    
    
}



extension DetailesMapCell: CLLocationManagerDelegate {
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
         showAllMarkers(marke: [mylocation.coordinate , CLLocationCoordinate2D(latitude:Double(orderdetailes.cooker.location.lat) , longitude: Double(orderdetailes.cooker.location.lng)) ])
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
    //action when click marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        myLoader.showCustomLoaderview(uiview: myview)
        
        let dict = marker.userData as! [String:Int]
        if let  myid = dict["index"] {
        if(myid == -1 ){
            
        }else{
            self.LoadOwnerProfileInfo(id:Int(self.Foodcarid[myid].id)!, index: myid)
         
        }
        }
        return true
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func GetAllDeliveryGuy(){
        FoodCararry=[]
        Ids=[]
        Name=[]
        Phone=[]
        LocationFoodcar=[]
        AllFoodcar=[]
        Foodcarid=[]
        counter = 0
        image = []
        
//        Getallproducterepo.GetDeliveryGuy(page: 1, limit: 100, status: "", lat: mylocation.coordinate.latitude, long: mylocation.coordinate.longitude, radius: 1000) { (response) in
//            self.Foodcarid = response
//            if(response.count != 0){
//                for index in 0...response.count-1 {
//
//                    self.showmark.append(CLLocationCoordinate2D(latitude: Double(response[index].location[0])!, longitude:Double(response[index].location[0])! ))
//                    self.AddAllMarker(allmarks: [CLLocationCoordinate2D(latitude: Double(response[index].location[0])!, longitude:Double(response[index].location[0])! ) ], locationid:index )
//
//
//                    //self.LoadOwnerProfileInfo(id:Int(self.Foodcarid[index].id)!, index: index)
//                }
//                self.showmark.append(self.mylocation.coordinate)
//               self.showAllMarkers(marke: self.showmark )
//
//            }
//
//             print(response)
//
//        }
//
        
        
        
        
        
        
        
    }
    
    //load OwnerProfile
    func LoadOwnerProfileInfo(id :Int ,index:Int )  {
        Getallproducterepo.GetDeliveryguyInfo(id:id) { (SuccessResponse) in
            if(SuccessResponse != nil){
                
                //Success Get ownerInfo
                let data=SuccessResponse
                print(data)
                if data != nil {
                    
                    
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let passController : PopupDeliveryInfo = storyboard.instantiateViewController(withIdentifier: "PopupDeliveryInfo") as! PopupDeliveryInfo
                    
                    
                    passController.modalPresentationStyle = .custom
                    passController.modalTransitionStyle = .crossDissolve
                    passController.Orderdetailes = self.orderdetailes
                    // passController.Name.text =
                    if let  name =   data .name{
                        passController.Myname = name
                    }
                    if let  url =    data .profileImg{
                        passController.Myimage = url
                    }
                    if let  rate =    data .rating{
                        passController.Myrate = rate
                    }
                    if let  adress =    data .address{
                        passController.myAdress = adress
                        passController.deliveryguy = data
                    }
                    
                    
                    
                    
                    
                    passController.delegate = self.parentviewcontroller as! DeliveryGuychoose
                    
                    self.window?.rootViewController?.present(passController, animated: true, completion: nil)
                    
                    
                    myLoader.hideCustomLoader()
                    
                    
//                    self.AllFoodcar.append(SuccessResponse)
//                    //                    if(self.Foodcarid.count-1 > self.counter ){
//                    self.AddFoodcarMarker(id:index)
//                    self.showAllMarkers(marke: self.showmark )
                   
                    
                }
                
            }
        }
        
    }
    
    
    
    //add marker
    func AddFoodcarMarker(id:Int){
        
        for  foodcar in AllFoodcar{
            let name = foodcar.name!
            let myid = foodcar.id!
            let phone = foodcar.phone!
            
            
            
            self.Ids.append(myid)
            self.Name.append(name)
            self.Phone.append(phone)
            
            // print(location)
            let lat = Double(foodcar.location.lat)
            let lng = Double(foodcar.location.lng)
            
            
            self.showmark.append(CLLocationCoordinate2D(latitude: lat , longitude:  lng))
            self.AddAllMarker(allmarks: [CLLocationCoordinate2D(latitude: lat  , longitude:  lng ) ], locationid:id )
            
            
            print("------------------")
            print(self.Ids)
            print(self.Name)
            
            print(self.Phone)
            
            
        }
        
        
        
        
        
        self.showmark.append(self.mylocation.coordinate)
        //  self.showAllMarkers(marke: self.showmark )
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

