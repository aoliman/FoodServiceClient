//
//  MapController.swift
//  FoodService
//
//  Created by index-ios on 3/17/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON
import Material
import Firebase
import GeoFire
class MapController: UIViewController  {

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
    var myview :UIView!
    var btn : RaisedButton!
    var showmark :[CLLocationCoordinate2D]=[]
    // The currently selected place.
    var myidlocation:Int!
    var Getallproducterepo = GetallProdacteRepo()
    var  ResFoodCar: [DataCatogary] = []
    var NewResResturant:[DataCatogary] = []
    var  NewResFoodCar: [DataCatogary] = []
    var ResResturant:[DataCatogary] = []
    
    let foodcarmapmarker = 1
    let resturantmapmarker = 2
    
    var counter = 0
    @IBOutlet weak var viewcellmap: UIView!
    //firebase refrence
    private var FoodCar_Ref = Database.database().reference().child("geofire/FOOD_CAR")
    var mygeoFire : GeoFire!
    var timer = Timer()
    var timer1 = Timer()
    var customView:HomeMap!
    
    var type = "food-cars"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       
        self.navigationController?.navigationBar.tintColor = .white
        setupNavigationBar()
//        self.navigationItem.backBarButtonItem?.title = "Back".localized()
        self.title = "Map".localize()
       //firebase ref
        mygeoFire = GeoFire(firebaseRef: self.FoodCar_Ref)
        
        //configurelocation manger
        locationmaanager = CLLocationManager()
        locationmaanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmaanager.requestAlwaysAuthorization()
        locationmaanager.distanceFilter = 50
        locationmaanager.startUpdatingLocation()
        //locationmaanager.requestLocation()
        locationmaanager.delegate = self
        
        //create google map
        let camera = GMSCameraPosition.camera(withLatitude: mylocation.coordinate.latitude,
                                              longitude:mylocation.coordinate.longitude ,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: viewcellmap.bounds , camera: camera)
        mapView.settings.myLocationButton = true
        mapView.settings.zoomGestures = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        // Add the map to the view, hide it until we've got a location update.
        viewcellmap.addSubview(mapView)
        mapView.isHidden = true
        mapView.delegate=self
        //defined mapview apper
        myview=UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        btn = RaisedButton(frame: CGRect.init(x: 20, y: 10, width: 160, height: 50))
    
        
         GetAllFoodCar()
       
        
        
        
        self.customView = Bundle.main.loadNibNamed("HomeMapView", owner: self, options: nil)![0] as! HomeMap
        self.customView.frame = CGRect(x: 0, y: self.view.layer.frame.height, width: self.view.layer.frame.width, height: self.view.layer.frame.height*25/100)
        self.view.addSubview(self.customView)
        
        
       
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.customView.ImageProfile.layer.cornerRadius = self.customView.ImageProfile.layer.frame.height/2
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      timer.invalidate()
    }
    @objc func AppearMapView(urlimage:String , name:String , rate:Double , type :String){
        UIView.animate(withDuration: 1, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            
            if  urlimage != nil {
                self.customView.ImageProfile.af_setImage(withURL: URL(string:urlimage)!)
                self.customView.ImageProfile.layer.cornerRadius = self.customView.ImageProfile.layer.frame.height/2
                
            }else{
               self.customView.ImageProfile.image = #imageLiteral(resourceName: "profile-1")
            }
            
            self.customView.Name.text = name
            self.customView.RateView.rating = rate
            self.customView.TyptLabel.text = type
            self.customView.RateView.text = String(rate)
             self.customView.RateView.settings.updateOnTouch = false
            self.customView.BtnREquest.setTitle("Next".localize(), for: .normal)
            self.customView.BtnREquest.layer.cornerRadius = 6
            if(type == "Food Car".localize()){
                 self.customView.BtnREquest.removeTarget(nil, action: nil, for: .allEvents)
                self.customView.BtnREquest.addTarget(self, action: #selector(self.BtnNextActionFoodCar(sender:)), for: .touchUpInside)
            }else{
                self.customView.BtnREquest.removeTarget(nil, action: nil, for: .allEvents)
                self.customView.BtnREquest.addTarget(self, action: #selector(self.BtnNextActionResturante(sender:) ), for: .touchUpInside)
            }
            
                  self.customView.frame = CGRect(x: 0, y: self.view.layer.frame.height*75/100, width: self.view.layer.frame.width, height: self.view.layer.frame.height*25/100)
                   self.view.layoutIfNeeded()
           
            
            
            
        }, completion: { (istrue) in
           
            }
       )
    }
    
    
    @objc func DissAppearMapView(){
        UIView.animate(withDuration: 1, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            
            
            self.customView.frame = CGRect(x: 0, y: self.view.layer.frame.height, width: self.view.layer.frame.width, height: self.view.layer.frame.height*25/100)
            self.view.layoutIfNeeded()
            
            
        }, completion: nil)
    }
    
    
    
    
    @objc func BtnNextActionFoodCar(sender:UIButton){
        //push here
        UserDefaults.standard.set(ResFoodCar[sender.tag].id  , forKey: Profileid)
        UserDefaults.standard.set( "food-cars", forKey: Profiletype)
        UserDefaults.standard.set(  ResFoodCar[sender.tag].id , forKey: PartyCookerId)
        UserDefaults.standard.set( 2 , forKey: Type)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GetAllProducteAndFilter")
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func BtnNextActionResturante(sender:UIButton){
        //push here
        UserDefaults.standard.set(ResResturant[sender.tag].id, forKey: Profileid)
        UserDefaults.standard.set( "restaurant-owners", forKey: Profiletype)
        UserDefaults.standard.set( ResResturant[sender.tag].id, forKey: PartyCookerId)
        UserDefaults.standard.set( 2 , forKey: Type)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GetAllProducteAndFilter")
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
 
    
}






extension MapController: CLLocationManagerDelegate {
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
        AddAllResturanteMarker(allmarks: [CLLocationCoordinate2D(latitude:32.283475 , longitude: 30.616554)], locationid: 1)
        
        
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
        
        DissAppearMapView()
        
    }
    
    
    //add marker with userdata
    func AddAllResturanteMarker( allmarks : [CLLocationCoordinate2D] , locationid :Int){
        for markcoordinate in  allmarks {
            let marker = GMSMarker(position: markcoordinate )
            marker.userData=["index": locationid , "type":resturantmapmarker]
            marker.icon = resizeImage(image: #imageLiteral(resourceName: "Image-2").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
            marker.tracksViewChanges = true
            marker.map = mapView
        }
        
        
    }
    
    func AddAllFoodCarMarker( allmarks : [CLLocationCoordinate2D] , locationid :Int){
        for markcoordinate in  allmarks {
            let marker = GMSMarker(position: markcoordinate )
            marker.userData=["index": locationid , "type":foodcarmapmarker]
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
        var bounds = GMSCoordinateBounds(coordinate: firstLocation!, coordinate: firstLocation!)
        for marker: GMSMarker in markers {
            bounds = bounds.includingCoordinate(marker.position)
        }
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 110.0))

        
    }
    
    
}




extension MapController :  GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        DissAppearMapView()
    }
    
    //action when click marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let dict = marker.userData as! [String:Int]
        
                if let  myid = dict["index"] {
                    let  mytype = dict["type"]
                    if(mytype == foodcarmapmarker){
                        if  ResFoodCar[myid].profileImg !=  nil && ResFoodCar[myid].rating !=  nil && ResFoodCar[myid].name !=  nil  {
                            AppearMapView(urlimage:ResFoodCar[myid].profileImg , name:ResFoodCar[myid].name , rate: ResFoodCar[myid].rating, type: "Food Car".localize())
                        }
                      
                    }else{
                        if(ResResturant[myid].profileImg !=  nil && ResResturant[myid].rating !=  nil && ResResturant[myid].name !=  nil){
                     AppearMapView(urlimage:ResResturant[myid].profileImg , name:ResResturant[myid].name , rate: ResResturant[myid].rating, type: "Resturante".localize())
                    }
                    }
        
                }
        
        
        
        
        
        
//        myLoader.showCustomLoaderview(uiview: myview)
//
//        let dict = marker.userData as! [String:Int]
//
//        if let  myid = dict["index"] {
//            let  mytype = dict["type"]
//            if(mytype == foodcarmapmarker){
//               self.LoadOwnerProfileInfo(id :ResFoodCar[myid].id ,type :"food-cars" )
//            }else{
//              self.LoadOwnerProfileInfo(id :ResResturant[myid].id ,type :"restaurant-owners" )
//            }
//
//
//        }
        return true
    }
   
   
    
//     func SendtoFoodcar(id :Int){
//        UserDefaults.standard.set(  Ids[id], forKey: Profileid)
//        UserDefaults.standard.set( "food-cars" , forKey: Profiletype)
//        UserDefaults.standard.set( 1 , forKey: Type)
//        UserDefaults.standard.set( Ids[id] , forKey: HomeCookerId)
//        print("-----type = \(UserDefaults.standard.integer(forKey: HomeCookerId))--------")
//        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc : GetAllProducteAndFilter = storyboard.instantiateViewController(withIdentifier: "GetAllProducteAndFilter") as! GetAllProducteAndFilter
//        self.navigationController?.pushViewController(vc, animated: false)
//
//
//    }
  
   
    
    

    @objc func GetAllFoodCar(){
        
        mapView.clear()
        myLoader.showCustomLoaderview(uiview: self.view)
       Getallproducterepo.GetCatogary(page: 1, limit: 40, type: "food-cars", lat: mylocation.coordinate.latitude, long: mylocation.coordinate.longitude, radius: raduis){ (response) in
        print("food car \(response)")
            self.NewResFoodCar = []
            for onefoodcar in response.data {
                self.NewResFoodCar.append(onefoodcar)
            }
        
            self.GetAllRestutante()
            }
        }
    
    
    
    @objc func GetAllRestutante(){
        
        Getallproducterepo.GetCatogary(page: 1, limit: 10, type: "restaurant-owners", lat: mylocation.coordinate.latitude, long: mylocation.coordinate.longitude, radius: raduis) { (catogary) in
            self.NewResResturant = []
            for onedata in catogary.data  {
                self.NewResResturant.append(onedata)
            }
            
            myLoader.showCustomLoaderview(uiview: self.myview)
            self.ResResturant = self.NewResResturant
            self.ResFoodCar = self.NewResFoodCar
            print("count = \(self.ResResturant.count)")
            if(self.ResResturant.count != 0){
                for index in 0...(self.ResResturant.count-1) {
                    
                    self.AddAllResturanteMarker(allmarks: [CLLocationCoordinate2D(latitude: Double(self.ResResturant[index].location.lat), longitude: Double(self.ResResturant[index].location.lng))], locationid: index)
                    self.showmark.append(CLLocationCoordinate2D(latitude: Double(self.ResResturant[index].location.lat), longitude: Double(self.ResResturant[index].location.lng)))
                }
             }
            
            
            if(self.ResFoodCar.count != 0){
                
                for index in 0...(self.ResFoodCar.count-1) {
                    self.AddAllFoodCarMarker(allmarks: [CLLocationCoordinate2D(latitude: Double(self.ResFoodCar[index].location.lat), longitude: Double(self.ResFoodCar[index].location.lng))], locationid: index)
                    self.showmark.append(CLLocationCoordinate2D(latitude: Double(self.ResFoodCar[index].location.lat), longitude: Double(self.ResFoodCar[index].location.lng)))
                }
                
            }
            self.showmark.append(self.mylocation.coordinate)
            self.showAllMarkers(marke: self.showmark )
            myLoader.hideCustomLoader()
            self.timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.GetAllFoodCar), userInfo: nil, repeats: false)
            
         }
       }
    
    
  
    
   
    
    
    
    
    
    //load OwnerProfile
    func LoadOwnerProfileInfo(id :Int ,type :String )  {
        Getallproducterepo.GetProfileInfo(id: id, type: type) { (SuccessResponse) in
            if(SuccessResponse != nil){
               
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let Controller : PopupDeliveryInfo = storyboard.instantiateViewController(withIdentifier: "PopupDeliveryInfo") as! PopupDeliveryInfo
                
                myLoader.showCustomLoaderview(uiview: Controller.Popview)
                Controller.modalPresentationStyle = .custom
                Controller.modalTransitionStyle = .crossDissolve
               
                // passController.Name.text =
                if let  name =   SuccessResponse.name{
                    Controller.Myname = name
                }
                if let  url =    SuccessResponse.profileImg{
                    Controller.Myimage = url
                }
                if let  rate =    SuccessResponse.rating{
                    Controller.Myrate = Float(rate)
                }
                if let  adress =    SuccessResponse.address{
                    Controller.myAdress = adress
                    
                }
                
                
               self.navigationController?.pushViewController(Controller, animated: true)
                
                
                myLoader.hideCustomLoader()
                
                
            }
        }
        
    }
    
    
 
    
    
    
    
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

