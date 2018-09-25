//
//  CompletePartyCoockerOrder.swift
//  FoodService
//
//  Created by index-ios on 4/10/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import  Material
import GoogleMaps
import GooglePlaces
import  Toast_Swift
import Localize_Swift
class CompletePartyCoockerOrder: UIViewController , UIAlertViewDelegate ,UITextFieldDelegate {
    
    @IBOutlet weak var StackviewNumberofpeople: UIStackView!
    @IBOutlet weak var NumberOfPeople: ErrorTextField!
    @IBOutlet weak var DeleveryDate: ErrorTextField!
    @IBOutlet weak var totalpricelabel: UILabel!
    @IBOutlet weak var CoastPerPersonlabel: UILabel!
    @IBOutlet weak var Totalprice: UILabel!
    @IBOutlet weak var CoastForPerson: UILabel!
    @IBOutlet weak var BtnNext: RaisedButton!
    @IBOutlet weak var mymapview: UIView!
    @IBOutlet weak var longprsslabel: UILabel!
    @IBOutlet weak var Delevrytime: ErrorTextField!
    
    
    var mydate=Date()
    var mytime=Date()
    var ChooseItem:[Int]=[]
    var price:Float=0.0
    var allprice:Float=0.0
    var name:String!
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
    var picker : UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        setupNavigationBar()
        //ErrorTextField config
        setup()
        //configer map
        configGooglemap()
        setuprecognizer()
        self.title = "Compelete Order".localized()
        print(ChooseItem)
         hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func Setupinfo(chooseitem:[Int], priceforperson :Float,Name:String){
        self.ChooseItem=chooseitem
        self.price=priceforperson
        self.name=Name
       
        
    }
    
    @IBAction func DateEdite(_ sender: Any) {
        DateTap()
        
    }
    
    @IBAction func TimeEdite(_ sender: Any) {
        TimeTap()
    }
    
    func setup(){
       
//        self.navigationController?.navigationBar.topItem?.backButton.setTitle("Back".localized(), for: .normal)
        
           
        if Localize.currentLanguage() == "en"{
            StackviewNumberofpeople.semanticContentAttribute = .forceLeftToRight
            NumberOfPeople.semanticContentAttribute = .forceLeftToRight
            DeleveryDate.semanticContentAttribute = .forceLeftToRight
             Delevrytime.semanticContentAttribute = .forceLeftToRight
            NumberOfPeople.textAlignment = .left
            DeleveryDate.textAlignment = .left
           Delevrytime.textAlignment = .left
           
           
        }else{
           StackviewNumberofpeople.semanticContentAttribute = .forceRightToLeft
            NumberOfPeople.semanticContentAttribute = .forceRightToLeft
             DeleveryDate.semanticContentAttribute = .forceRightToLeft
            Delevrytime.semanticContentAttribute = .forceRightToLeft
            NumberOfPeople.textAlignment = .right
            DeleveryDate.textAlignment = .right
            Delevrytime.textAlignment = .right
           
       
        }
        ErrortextConfig(QuantityEditTxt: NumberOfPeople)
        NumberOfPeople.placeholder="Number of individuals".localized()
        ErrortextConfig(QuantityEditTxt: DeleveryDate)
        ErrortextConfig(QuantityEditTxt: Delevrytime)
        DeleveryDate.text="Determinde Delivary Day".localized()
        Delevrytime.text="Determinde Delivary Time".localized()
        self.CoastForPerson.text="\(price) \("Riyal".localize())"
        self.Totalprice.text="\(price) \("Riyal".localize())"
        longprsslabel.text="Long Press To Determine Location".localized()
        totalpricelabel.text="TotalPrice".localized()
        CoastPerPersonlabel.text="Cost per person".localized()
        BtnNext.setTitle("Next".localized(), for: .normal)
        BtnNext.layer.cornerRadius=8
        
        
        
        
//
//        let tapdate = UITapGestureRecognizer(target: self, action: #selector(DateTap(_:)))
//        tapdate.numberOfTapsRequired = 1
//        DeleveryDate.isUserInteractionEnabled = true
//        DeleveryDate.addGestureRecognizer(tapdate)
//
//
//        let taptime = UITapGestureRecognizer(target: self, action: #selector(TimeTap(_:)))
//        taptime.numberOfTapsRequired = 1
//        Delevrytime.isUserInteractionEnabled = true
//        Delevrytime.addGestureRecognizer(taptime)
        
         DeleveryDate.addTarget(self, action: #selector(DateTap), for: .touchUpInside)
         Delevrytime.addTarget(self, action: #selector(TimeTap), for: .touchUpInside)
    
   
    
    
        
    
        
        
    }
    @objc func DateTap() {
        
        
        var alert = UIAlertView(title: "Select Date ".localize(), message: "", delegate: self, cancelButtonTitle: "Ok".localize())
        alert.tag = 1
        picker = UIDatePicker(frame: CGRect(x: 10, y: alert.bounds.size.height, width: 300, height: 200))
        picker.locale = Locale(identifier:Localize.currentLanguage()) as Locale!
        picker.datePickerMode = .date
        picker.minimumDate = Date()
        alert.addSubview(picker)
        alert.bounds = CGRect(x: 0, y: 0, width: 320 + 20, height: alert.bounds.size.height + 216 + 20)
        alert.setValue(picker, forKey: "accessoryView")
        alert.delegate = self
        alert.show()
        
    }
    @objc func TimeTap() {
        
        var alert = UIAlertView(title: "Select Time".localize(), message: "", delegate: self, cancelButtonTitle: "Ok".localize())
        alert.tag = 2
        picker = UIDatePicker(frame: CGRect(x: 10, y: alert.bounds.size.height, width: 300, height: 200))
        picker.locale = Locale(identifier:Localize.currentLanguage()) as Locale!
        picker.datePickerMode = .time
        picker.minimumDate = Date()
        alert.addSubview(picker)
        alert.bounds = CGRect(x: 0, y: 0, width: 320 + 20, height: alert.bounds.size.height + 216 + 20)
        alert.setValue(picker, forKey: "accessoryView")
        alert.delegate = self
        alert.show()
    }
    
   // errortextfielid configeure
    func ErrortextConfig(QuantityEditTxt:ErrorTextField){
        
        QuantityEditTxt.placeholderActiveColor=#colorLiteral(red: 0.3539252877, green: 0.8294976354, blue: 0.8924615979, alpha: 1)
        QuantityEditTxt.placeholderNormalColor=#colorLiteral(red: 0.3539252877, green: 0.8294976354, blue: 0.8924615979, alpha: 1)
        QuantityEditTxt.dividerColor=#colorLiteral(red: 0.3539252877, green: 0.8294976354, blue: 0.8924615979, alpha: 1)
        QuantityEditTxt.dividerActiveColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
        QuantityEditTxt.dividerNormalColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
        QuantityEditTxt.dividerNormalHeight=2
        QuantityEditTxt.dividerActiveHeight=3
        QuantityEditTxt.layer.cornerRadius=10
        if #available(iOS 10.0, *) {
            QuantityEditTxt.keyboardType = .asciiCapableNumberPad
        } else {
            // Fallback on earlier versions
        }
        QuantityEditTxt.textColor=#colorLiteral(red: 0.3539252877, green: 0.8294976354, blue: 0.8924615979, alpha: 1)
    }
    


    
    @IBAction func ErrrortextToutchinside(_ sender: ErrorTextField) {
       sender.placeholder=""
        
    }
    
    
    
    
    @IBAction func Getdate(_ sender: Any) {
        

        var alert = UIAlertView(title: "Select Date ".localize(), message: "", delegate: self, cancelButtonTitle: "Ok".localize())
        alert.tag = 1
        picker = UIDatePicker(frame: CGRect(x: 10, y: alert.bounds.size.height, width: 300, height: 200))
        picker.locale = Locale(identifier:Localize.currentLanguage()) as Locale!
        picker.datePickerMode = .date
        picker.minimumDate = Date()
        alert.addSubview(picker)
        alert.bounds = CGRect(x: 0, y: 0, width: 320 + 20, height: alert.bounds.size.height + 216 + 20)
        alert.setValue(picker, forKey: "accessoryView")
        alert.delegate = self
        alert.show()
     }
    
    @IBAction func Gettime(_ sender: Any) {
        var alert = UIAlertView(title: "Select Time".localize(), message: "", delegate: self, cancelButtonTitle: "Ok".localize())
        alert.tag = 2
        picker = UIDatePicker(frame: CGRect(x: 10, y: alert.bounds.size.height, width: 300, height: 200))
        picker.locale = Locale(identifier:Localize.currentLanguage()) as Locale!
        picker.datePickerMode = .time
        picker.minimumDate = Date()
        alert.addSubview(picker)
        alert.bounds = CGRect(x: 0, y: 0, width: 320 + 20, height: alert.bounds.size.height + 216 + 20)
        alert.setValue(picker, forKey: "accessoryView")
        alert.delegate = self
        alert.show()
        
        
        
    }
    func combineDateWithTime(date: Date, time: Date) -> Date? {
        let calendar = NSCalendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
        
        var mergedComponments = DateComponents()
        mergedComponments.year = dateComponents.year!
        mergedComponments.month = dateComponents.month!
        mergedComponments.day = dateComponents.day!
        mergedComponments.hour = timeComponents.hour!
        mergedComponments.minute = timeComponents.minute!
        mergedComponments.second = timeComponents.second!
        
        return calendar.date(from: mergedComponments)
    }
    
    
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if(alertView.tag == 1){
            
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = DateFormatter.Style.long
            dateformatter.timeStyle = DateFormatter.Style.none
            let now = dateformatter.string(from: picker.date)
            DeleveryDate.text=String( describing: now)
            mydate = picker.date
            
            print(mydate)
        }else{
           
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = DateFormatter.Style.none
            dateformatter.timeStyle = DateFormatter.Style.medium
            let now = dateformatter.string(from: picker.date)
            Delevrytime.text=String( describing: now)
            mytime = picker.date
             print(mytime)
    
            
        }
        
    }
    
  
    
    
    
    
    
    
    
    
    
    
    @IBAction func ErrrortextToutchoutside(_ sender: ErrorTextField) {
        if sender.text != nil && sender.text != ""{
            sender.placeholder="Number of individuals".localize()
        }
    }
    @IBAction func EditTotalpricecheck(_ sender: ErrorTextField) {
      EditTotalprice()
    }
     func EditTotalprice(){
      NumberOfPeople.placeholder=""
            if( NumberOfPeople.text != ""  && NumberOfPeople.text != nil && NumberOfPeople.text != "0"){
                if (NumberOfPeople.text?.isValidString())! == true {
                   //  NumberOfPeople.
                    NumberOfPeople.dividerActiveColor=#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                    NumberOfPeople.dividerNormalColor=#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                } else {
                    Totalprice.text="\(Float(NumberOfPeople.text!)!*price) \("Riyal".localize())"
                    allprice=Float(NumberOfPeople.text!)!*price
                    NumberOfPeople.dividerActiveColor=#colorLiteral(red: 0.3539252877, green: 0.8294976354, blue: 0.8924615979, alpha: 1)
                    NumberOfPeople.dividerNormalColor=#colorLiteral(red: 0.3539252877, green: 0.8294976354, blue: 0.8924615979, alpha: 1)
                }
                
                
                
               
            }else{
                NumberOfPeople.dividerActiveColor=#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                NumberOfPeople.dividerNormalColor=#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
      }
    
    
    // when click button next
    @IBAction func BtnNext(_ sender: Any) {
        if ( NumberOfPeople.text == ""  || NumberOfPeople.text == nil || NumberOfPeople.text == "0"){
            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please Enter People Count")
        } else if(DeleveryDate.text == "Determinde Delivary Day".localize()){
             UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please Choose Day")
        }else if(Delevrytime.text == "Determinde Delivary Time".localize()){
            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please Choose Time")
        }else if (arrayCoordinates.count == 0) {
             UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please Choose Location ")
        } else  if (NumberOfPeople.text?.isValidString())! == true {
            //  NumberOfPeople.
            NumberOfPeople.dividerActiveColor=#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            NumberOfPeople.dividerNormalColor=#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please Enter People Count")
        } else {
            ///send to info view controller
           performSegue(withIdentifier: "sureorderpartycooker", sender: nil)
        }
        
        
    }
    
    
}
    




extension CompletePartyCoockerOrder :Mydatedelgate {
    func MyselecteDate(date: Date) {
        
     let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: Date())
      
        DeleveryDate.text=String(describing: dateFormatter.string(from: date))
          print("minute = \(minutes)    date back \(date.timeIntervalSince1970*1000)")
        print(Date().timeIntervalSince1970*1000)
        //Int( date.timeIntervalSince1970*1000)
        mydate = date
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calenderPartycooker" {
            let vc : MyCalander = segue.destination as! MyCalander
            vc.delegate = self
        }
        if segue.identifier == "sureorderpartycooker" {
            let vc : SureOrder = segue.destination as! SureOrder
            vc.Setupinfo(cookerName:name , peopleNumber: Int(NumberOfPeople.text!)! , deliverydate: combineDateWithTime(date: mydate, time: mytime)!, totalPrice: Double(allprice), items: ChooseItem, location: arrayCoordinates[0])
        }
    }
    
    
}




    ///map view operation and delegate
    
    extension CompletePartyCoockerOrder :GMSMapViewDelegate ,CLLocationManagerDelegate
    {
       
        
        
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
            showmark.append(mylocation.coordinate)
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
            mapView.isMyLocationEnabled = true
            
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
extension CompletePartyCoockerOrder : UIGestureRecognizerDelegate{
    
    
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
        let newMarker = GMSMarker(position: mapView.projection.coordinate(for: sender.location(in: mapView)))
        self.arrayCoordinates.append(newMarker.position)
        newMarker.map = mapView
    }
   
    
    
}
