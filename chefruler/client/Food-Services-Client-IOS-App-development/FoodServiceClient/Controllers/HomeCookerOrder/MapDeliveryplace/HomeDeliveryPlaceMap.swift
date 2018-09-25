//
//  HomeDeliveryPlaceMap.swift
//  FoodServiceClient
//
//  Created by Index on 5/28/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON
import Material
class HomeDeliveryPlaceMap: UIViewController {
    
    
    @IBOutlet weak var deliveryplaceLabel: UILabel!
    
    
    
    
    @IBOutlet weak var Myviewmap: UIView!
    
    var mylocation = CLLocation()
    var locationmaanager = CLLocationManager()
    
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 12
    var id:Int!
    
    var Btnlocation :CLLocationCoordinate2D!
    //mapview apper
    var myview :UIView!
    var btn : RaisedButton!
    var showmark :[CLLocationCoordinate2D]=[]
    // The currently selected place.
    var GetallHomeCookerplaces = GetallProdacteRepo()
    
   
   var customView:HomeDeliveryplaceAdress!

    
    var MyDeliveryPlace:[HomeCookerPlacemodel]=[]
    var CountofProducte:[Int]=[]
    var ChooseItemsids :[Int]=[]
    var Productesdata:[getproductdata] = []
    var markers:[GMSMarker] = []
    var senddate:Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // Do any additional setup after loading the view.
    }
    func setup(){
        
        
        
        Setupmap()
        
       
        
  
        
        
      
        
      
       
        
        
    
        
        
    }
    func Setupmap(){
        self.navigationController?.navigationBar.tintColor = .white
        setupNavigationBar()
        //        self.navigationItem.backBarButtonItem?.title = "Back".localized()
        self.title = "Choose Delivery Place".localized()
        deliveryplaceLabel.text = "".localized()
        deliveryplaceLabel.text = "Please choose new delivery place from the map".localize()
        
        
        self.navigationController?.navigationBar.tintColor = .white
        setupNavigationBar()
        //        self.navigationItem.backBarButtonItem?.title = "Back".localized()
        
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
        mapView = GMSMapView.map(withFrame: Myviewmap.bounds , camera: camera)
        mapView.settings.myLocationButton = true
        mapView.settings.zoomGestures = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        // Add the map to the view, hide it until we've got a location update.
        Myviewmap.addSubview(mapView)
        mapView.isHidden = false
        mapView.delegate=self
          mylocation = locationmaanager.location!
        
        self.customView = Bundle.main.loadNibNamed("HomeDeliveryplaceviewAdressView", owner: self, options: nil)![0] as! HomeDeliveryplaceAdress
        self.customView.frame = CGRect(x: self.view.layer.frame.width*5/100, y: self.view.layer.frame.height, width: self.view.layer.frame.width-self.view.layer.frame.width*10/100, height: self.view.layer.frame.height*20/100)
        self.view.addSubview(self.customView)
        
      
        //defined mapview apper
        myview=UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        btn = RaisedButton(frame: CGRect.init(x: 20, y: 10, width: 160, height: 50))
        
        
        self.showmark.append(CLLocationCoordinate2D(latitude: Double(self.mylocation.coordinate.latitude) , longitude:  Double(self.mylocation.coordinate.longitude)))
        GetAllPlacesOfHmeCoker(id: Productesdata[0].owner.id, type: "HOME_COOKER")
    }
    func updatedata(productesdata:[getproductdata] , ChooseItemsids :[Int] , countofProducte:[Int] ){
        self.ChooseItemsids = ChooseItemsids
        self.Productesdata = productesdata
        self.CountofProducte = countofProducte
        
    }
    

   
}

extension HomeDeliveryPlaceMap :  GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        DissAppearMapView()
    }
    
    //action when click marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let dict = marker.userData as! [String:Int]
       
        if let  myid = dict["index"]  {
            if(myid != -1){
                for delivery in MyDeliveryPlace {
                    if(myid == delivery.deliveryPlace.id){
                        AppearMapView(Adress: delivery.deliveryPlace.address, id:myid )
                    }
                }
            }else{
                ////home cooker place choose
                
            }
            for marker in markers {
                marker.icon = resizeImage(image: #imageLiteral(resourceName: "receiving_place_green-3").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
                marker.map = mapView
            }
             marker.icon = resizeImage(image: #imageLiteral(resourceName: "place marker clicked"), targetSize: CGSize(width:50, height: 50))
            marker.map = mapView
          
        }
        
        


       
        return true
}
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
         DissAppearMapView()
        for marker in markers {
            marker.icon = resizeImage(image: #imageLiteral(resourceName: "receiving_place_green-3").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
            marker.map = mapView
        }
        
    }

    
}

extension HomeDeliveryPlaceMap: CLLocationManagerDelegate {
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        locationmaanager.stopUpdatingLocation()
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
//        Setupmap()
//        setup()
        
        
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
        
        //        SendtoFoodcar(id: marker.userData as! Int)
        
    }
    
    
    
    
   //add marker with userdata
    func AddAllMarker( allmarks : [CLLocationCoordinate2D] , locationid :Int){
        for markcoordinate in  allmarks {
            let marker = GMSMarker(position: markcoordinate )
            marker.userData=["index": locationid ]
            marker.icon = resizeImage(image: #imageLiteral(resourceName: "receiving_place_green-3").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))!, targetSize: CGSize(width:50, height: 50))
            marker.tracksViewChanges = true
            marker.map = mapView
            markers.append(marker)
            
        }


    }

    func AddAllHomecookerMarker( allmarks : [CLLocationCoordinate2D] ){
        for markcoordinate in  allmarks {
            let marker = GMSMarker(position: markcoordinate )
            marker.userData=["index": -1 ]
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
        var bounds = GMSCoordinateBounds(coordinate: firstLocation!, coordinate: firstLocation!)
        for marker: GMSMarker in markers {
            bounds = bounds.includingCoordinate(marker.position)
        }
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 110.0))
        
        
}

    
    
    
    @objc func AppearMapView( Adress:String , id :Int){
        UIView.animate(withDuration: 0.6, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            
            
            self.customView.Adresslabel.text = "Address".localize()
            
            self.customView.AdressValue.text = Adress
            self.customView.BtnDone.tag = id
            self.customView.BtnDone.layer.cornerRadius = 3
            self.customView.layer.cornerRadius = 3
            self.customView.BtnDone.setTitle("Done".localize() , for: .normal )
            self.customView.BtnDone.removeTarget(nil, action: nil, for: .allEvents)
            self.customView.BtnDone.addTarget(self, action: #selector(self.SendOrderDone), for: .touchUpInside)
            self.customView.frame = CGRect(x: self.view.layer.frame.width*5/100, y: self.view.layer.frame.height*80/100, width: self.view.layer.frame.width-self.view.layer.frame.width*10/100, height: self.view.layer.frame.height*20/100)
            self.view.layoutIfNeeded()
            
            
        }, completion: { (istrue) in
            
        }
        )
    }
    
    
    @objc func DissAppearMapView(){
        UIView.animate(withDuration: 0.7, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            
            
            self.customView.frame = CGRect(x: self.view.layer.frame.width*5/100, y: self.view.layer.frame.height, width: self.view.layer.frame.width-self.view.layer.frame.width*10/100, height: self.view.layer.frame.height*20/100)
            self.view.layoutIfNeeded()
            
            
        }, completion: nil)
    }
    
    
    @objc func SendOrderDone(sender:UIButton){
        
        
        RequsestSendOrder(Type: "", deliveryplaceid: sender.tag)
        
        
    }
    
    
    
    //get informatio homecooker request
    func GetAllPlacesOfHmeCoker(id : Int, type:String) {
        myLoader.showCustomLoaderview(uiview: self.view)
        var   profiletype = ""
        switch type {
        case "HOME_COOKER":profiletype="home-cookers"
        case "PARTY_COOKER":profiletype="party-cookers"
        case "FOOD_CAR":profiletype="food-cars"
        case "RESTAURANT_OWNER":profiletype="restaurant-owners"
        default : break
            
        }
        GetallHomeCookerplaces.GetHomeCookerPlace(ownedid: id, type: profiletype) { (SuccessResponse) in
            if(SuccessResponse != nil){
                //Success Get All HomeCooker
                let deliveryPlaces=SuccessResponse
                 self.MyDeliveryPlace=deliveryPlaces
                for deliveryPlace in deliveryPlaces {
                    if (deliveryPlace != nil && deliveryPlace.deliveryPlace.HomecokerLocation != nil ) {
                        self.AddAllMarker(allmarks: [CLLocationCoordinate2D(latitude: Double(deliveryPlace.deliveryPlace.HomecokerLocation.lat) , longitude:  Double(deliveryPlace.deliveryPlace.HomecokerLocation.lng)) ], locationid: deliveryPlace.deliveryPlace.id )
                        self.showmark.append(CLLocationCoordinate2D(latitude: Double(deliveryPlace.deliveryPlace.HomecokerLocation.lat) , longitude:  Double(deliveryPlace.deliveryPlace.HomecokerLocation.lng)))
                            print(deliveryPlace)
                         self.showAllMarkers(marke: self.showmark)
                    } }
                myLoader.hideCustomLoader()
            }
            if(SuccessResponse.count == 0){
                
                self.AddAllHomecookerMarker(allmarks: [CLLocationCoordinate2D(latitude: Double(self.Productesdata[0].owner.location.lat) , longitude:  Double(self.Productesdata[0].owner.location.lng)) ])
                UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("No Delivery Place".localize())
                self.showmark.append(CLLocationCoordinate2D(latitude: Double(self.Productesdata[0].owner.location.lat) , longitude:  Double(self.Productesdata[0].owner.location.lng)))
                self.showAllMarkers(marke:self.showmark)
                
                myLoader.hideCustomLoader()
            }
            
            
        }
       }
    
    
    
    
    
    
    
    func RequsestSendOrder(Type:String,deliveryplaceid:Int){
        
        myLoader.showCustomLoaderview(uiview: self.view)
        
        let headers = ["Content-Type": "application/json","Authorization": "Bearer \(getUserAuthKey())"]
        var parameters: [String : Any]!
        
        
        var  dictionarydata:[[String:Any]]=[]
        
        
        
        for index in 0...(ChooseItemsids.count-1) {
            var producteorderdata = CardProductOrder.init(fromDictionary: ["product": ChooseItemsids[index] ,"count": CountofProducte[index] ])
            dictionarydata.append(producteorderdata.toDictionary())
        }
        
        
        parameters = [
            "client": (Singeleton.userInfo?.id!)! ,
            "cookerDeliveryType": "DELIVERY_PLACE",
            "deliveryPlace": deliveryplaceid,
            "productOrders":dictionarydata,
            "deliveryDate":Int( (senddate.timeIntervalSince1970)*1000 )
        ]
    
        Alamofire.request("http://67.205.139.227/api/v1/home-cookers/\((Productesdata[0].owner.id)!)/orders", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print("Request  \(response.request)")
            
            print(parameters)
            switch response.result {
            case .success:
                print(response.response?.statusCode)
                if(response.response?.statusCode == 201){
                    do {
                        let respnseapisucess = try
                            print("RESPONSE 1 \(response.result.value)")
                        myLoader.hideCustomLoader()
                        UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Order is send")
                        self.dismiss(animated: false, completion: nil)
                        PresentHomeViewController(myViewController:self)
                        
                    }
                        
                    catch {
                        print("An Error Done When Convert Data Success")
                        UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("\(response.result.value)")
                    }
                }
                else{
                    do{
                        if response.response?.statusCode == 422 {
                            let json = try  JSON(data: response.data!)
                            print(json)
                        }else{
                            let json = try  JSON(data: response.data!)
                            Alert.showAlert(title: "Error".localized(), message: json["error"].string!)
                        }
                    
                    }catch{}
                    myLoader.hideCustomLoader()
                }
                
                
            case .failure(let error):
                Loader.hideLoader()
                break
            }
        }
        
        
    }
    
    
    
    
    

    
    
    
    
    
    

}



