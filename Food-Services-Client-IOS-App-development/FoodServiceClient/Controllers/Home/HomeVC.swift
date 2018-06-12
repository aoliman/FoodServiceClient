//
//  HomeVC.swift
//  FoodServiceClient
//
//  Created by Index on 5/20/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import Segmentio
import GoogleMaps
import GooglePlaces
import Localize_Swift
class HomeVC: UIViewController  {

    @IBOutlet weak var ViewBtnAndImg: UIView!
    
    @IBOutlet weak var MapBtn: UIButton!
    @IBOutlet weak var segmentioView: Segmentio!
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var TableProducte: UICollectionView!
    
    var isNewDataLoading=false
    var listofcatogary : [DataCatogary] = []
    var loaddata=0
    var limit = 40
    var page = 1
    var pageCount = 2
    var totalCount = 0
    var ChooseItems :[Int]=[]
    var Getallproducterepo = GetallProdacteRepo()
    //location manger
    var mylocation = CLLocation()
    var locationmaanager = CLLocationManager()
    var type = "party-cookers"
    var raduis = 1000000000
    override func viewDidLoad() {
        super.viewDidLoad()
       
     print("loaction \(locationmaanager.location)")
         mylocation = locationmaanager.location!
        
        
        SetupViews()
        
        // set language
        //firsed load
        if Localize.currentLanguage() == "en" {
            self.Getallproducterepo.SendLanguage(Language: "en", completionSuccess: { (resulte) in
               
                
            })
        }
        else {
            self.Getallproducterepo.SendLanguage(Language: "ar", completionSuccess: { (resulte) in
                
                
            })
        }
        //get dta
        
        
      //when click in tab
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            print(segmentIndex)
            switch segmentIndex {
            case 0:
                self.type = "party-cookers"
                 self.DidtapInCatogary(type:self.type)
                break
            case 1:
                self.type = "home-cookers"
                self.DidtapInCatogary(type:self.type)
                break
            case 2:
                self.type = "food-cars"
                self.DidtapInCatogary(type:self.type)
                break
            case 3:
                self.type = "restaurant-owners"
                self.DidtapInCatogary(type:self.type)
                break
            default:
                break
            }
            
        }

        
    }
   
    func SetupViews(){
        
        //table setup
        TableProducte.delegate = self
        TableProducte.dataSource = self
        //segmentio setup
        SegmentioBuilderHome.buildSegmentioView(segmentioView:segmentioView, segmentioStyle: .imageOverLabel)
        //////
        
        segmentioView.selectedSegmentioIndex = 0
        segmentioView.reloadSegmentio()
        print("count \(segmentioView.segmentioItems.count)")
        
        
        
        
        //collection view bounds
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - (UIScreen.main.bounds.width*5/100), height: UIScreen.main.bounds.height*22/100)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.headerReferenceSize = CGSize(width: 0, height: 5)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        TableProducte.collectionViewLayout = layout
       
        
        //configurelocation manger
        locationmaanager = CLLocationManager()
        locationmaanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmaanager.requestAlwaysAuthorization()
        locationmaanager.distanceFilter = 50
        locationmaanager.startUpdatingLocation()
        locationmaanager.delegate = self
        
        MapBtn.layer.cornerRadius = MapBtn.layer.frame.width/2
        ViewBtnAndImg.layer.cornerRadius = MapBtn.layer.frame.width/2
        self.ContentView.bringSubview(toFront: MapBtn)
    }
   
    
    
    
    
    
    //map btn action to apper map contrroller
    
    
    
    
    
    
    
    @IBAction func MapBtnAction(_ sender: Any) {
        print("btn")
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mapcontroller : MapController = storyboard.instantiateViewController(withIdentifier: "MapController") as! MapController
          self.navigationController?.pushViewController(mapcontroller, animated: false)
        
    }
    
    
  
    override func viewDidLayoutSubviews() {
         super.viewWillLayoutSubviews()
       
       
         self.GetCatoGary(page: self.page, limit: self.limit, type: self.type, lat: self.mylocation.coordinate.latitude, long: self.mylocation.coordinate.longitude, radius: self.raduis)
        MapBtn.layer.cornerRadius = MapBtn.layer.frame.width/2
        ViewBtnAndImg.layer.cornerRadius = MapBtn.layer.frame.width/2
    }
    
    



}


extension HomeVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listofcatogary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HomeCollectionViewCell = TableProducte.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
       
      
        
        if let url = self.listofcatogary[indexPath.row].profileImg{
            cell.Eateimage.af_setImage(withURL: URL(string: url )! )
            
        }
        if let name = self.listofcatogary[indexPath.row].name{
           cell.NameOrderTxt.text=name
        }
        if let rate = self.listofcatogary[indexPath.row].rating{
              // Show only fully filled stars
            cell.RateView.rating = Double(rate)
                cell.RateView.settings.fillMode = .precise
            cell.RateView.text=String(rate)
        }
      
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //push here
        UserDefaults.standard.set( listofcatogary[indexPath.row].id , forKey: Profileid)
        UserDefaults.standard.set( type, forKey: Profiletype)
        UserDefaults.standard.set(  listofcatogary[indexPath.row].id, forKey: PartyCookerId)
        UserDefaults.standard.set( 2 , forKey: Type)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GetAllProducteAndFilter")
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}



extension HomeVC {
func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    
    if scrollView == TableProducte {
        
        if ((scrollView.contentOffset.y + scrollView.frame.size.height)-10 >= scrollView.contentSize.height)
        {
            if !isNewDataLoading{
                
              
                self.GetCatoGary(page: self.page, limit: self.limit, type: self.type, lat: self.mylocation.coordinate.latitude, long: self.mylocation.coordinate.longitude, radius: self.raduis)
                
                
                isNewDataLoading = true
                
                
            }
            isNewDataLoading=false
        }
    }}

    
    //get catogary
    func GetCatoGary(page :Int ,limit :Int ,type :String,lat :Double , long :Double ,radius :Int){
        
        if(page>pageCount){
            print("here \(self.page)  > \(self.pageCount)")
            return
        }else{
            CancelAllrequsst()
        myLoader.showCustomLoaderview(uiview: ContentView)
        
         myLoader.activityindecator.bringSubview(toFront: MapBtn)
      
        Getallproducterepo.GetCatogary(page: page, limit: limit, type: type, lat: lat, long: long, radius: radius) { (catogary) in
            for onedata in catogary.data  {
              self.listofcatogary.append(onedata)
            }
            print("resulte in func  \(self.listofcatogary)")
            print("resulte in catogary \(catogary)")
            self.TableProducte.reloadData()
            myLoader.hideCustomLoader()
            if(self.type == "food-cars"){
                self.page=page+1
            }else{
                self.page=page+1
                self.pageCount = catogary.pageCount
                print("page counte \(self.pageCount)  page \(self.page)"  )
            }
            
            myLoader.hideCustomLoader()
            
        }
        
        }
        
    }

    
    func DidtapInCatogary(type:String){
        loaddata=0
        isNewDataLoading=false
        listofcatogary  = []
        limit = 10
        page = 1
        pageCount = 2
        self.GetCatoGary(page: self.page, limit: self.limit, type: self.type, lat: self.mylocation.coordinate.latitude, long: self.mylocation.coordinate.longitude, radius: self.raduis)
        self.TableProducte.reloadData()
        print(listofcatogary)
    }
    
    
    
    
}


extension HomeVC: CLLocationManagerDelegate {
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        mylocation=locations[0]
        
        
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            
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
    
  }


