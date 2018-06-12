//
//  GetAllProducte.swift
//  FoodService
//
//  Created by index-ios on 3/17/18.
//  Copyright © 2018 index-ios. All rights reserved.


import UIKit
import DropDown
import FontAwesome_swift
import Material
import Localize_Swift
import Moya
import Alamofire
import AlamofireImage
import BEMCheckBox
import GoogleMaps
import GooglePlaces
class GetAllProducteController: UIViewController {
    @IBOutlet weak var dropdownview: UIView!
    let dropDown = DropDown()
    var ispartycooker=false
     var loaddata=0
    var isNewDataLoading=false
    var type = 0
    var userId = 3
    var pofiletype:String!
    var listofproducte : [getproductdata] = []
    var listofpartycookercatogary:[PartyCookerData] = []
     var limit = 10
     var page = 1
     var pageCount = 2
     var totalCount = 0
    var nameofitem="HOME_COOKER,FOOD_CAR"
     var dataSource = ["All Producte".localize(), "Home Cooker".localize() ,"Food Car".localize()]
    var Getallproducterepo = GetallProdacteRepo()
    var ShowMora = true
    
    
    
    var mylocation = CLLocation()
    var locationmaanager = CLLocationManager()
    
    
    @IBOutlet weak var ProductCollectioView: UICollectionView!
    @IBOutlet weak var Arrowofdeowpdown: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var TableviewTopconstrain: NSLayoutConstraint!
    @IBOutlet weak var AllProducteLable: UILabel!
    
   
    @IBOutlet weak var PartyCookerLable: UILabel!
    @IBOutlet weak var selecttypeproducte: UIStackView!
    @IBOutlet weak var checkbox2: BEMCheckBox!
    @IBOutlet weak var ceckbox1: BEMCheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = "Back".localized()
       self.navigationController?.navigationBar.tintColor = .white
        AllProducteLable.text="All Productel".localized()
        PartyCookerLable.text="Party Cookerl".localized()
         self .view.backgroundColor=#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        type = UserDefaults.standard.integer(forKey: Type)
        pofiletype = UserDefaults.standard.string(forKey: Profiletype)
        TableviewTopconstrain.constant=(UIScreen.main.bounds.height*10/100)+12
        print(" type == \(type)")
        if ispartycooker {
            
           
            
            LoadPartyCookerCatogary(page: page, limit: limit)
        }else{
            if(type == 1) {
                dropdownview.frame =  CGRect(x: 0, y: 0, width: 0, height: 0)
                dropdownview.isHidden=true
                userId = UserDefaults.standard.integer(forKey: HomeCookerId)
                self.navigationItem.setHidesBackButton(true, animated: false)
                textLabel.layer.height=1
                dropDown.layer.height=1
                TableviewTopconstrain.constant=2
                
            }else{
                setupcheckbox()
            }
            setupDropdown(uiview: dropdownview)
            Arrowofdeowpdown.font = UIFont.fontAwesome(ofSize: 24)
            Arrowofdeowpdown.text=String.fontAwesomeIcon(name: .caretDown)
            ProductCollectioView.delegate=self
            ProductCollectioView.dataSource=self
            textLabel.text="All Producte".localize()
            if(type == 1){
                if(pofiletype == "home-cookers" || pofiletype == "HOME_COOKER"){
                    self.title = "Home Cooker".localize()
                }else if(pofiletype == "FOOD_CAR" || pofiletype == "food-cars"){
                      self.title = "Food Car".localize()
                }
                LoadSpecificHomeCookerProduct(page: page, limit: limit, userId: userId , type: pofiletype)
            }else {
                LoadAllproducte(page: page, limit: limit, status:nameofitem, lat: mylocation.coordinate.latitude, long:  mylocation.coordinate.longitude, raduis: 1)
            }
        }
    
       
        ProductCollectioView.delegate=self
        ProductCollectioView.dataSource=self
       print("load done")
       
        
        //collection view bounds
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/2 - (UIScreen.main.bounds.width*5/100), height: UIScreen.main.bounds.height*22/100)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.headerReferenceSize = CGSize(width: 0, height: 5)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        ProductCollectioView.collectionViewLayout = layout
      //  print(listofproducte)
        ProductCollectioView.reloadData()
        

        
    }

   
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    
    
    
    
    
    override func viewDidLayoutSubviews() {
      setupDropdown(uiview: dropdownview)
        //to tell dropmenu apper in right
        // Flip the drop down menu (To make it appear on the other side)
        if(Localize.currentLanguage()=="ar"){
            self.dropDown.layer.setAffineTransform(CGAffineTransform(scaleX: -1, y: 1))

            // Flip the subviews of the subviews
            for view in self.dropDown.subviews {

                for view in view.subviews {
                    view.layer.setAffineTransform(CGAffineTransform(scaleX: -1, y: 1))
                }
            }
        }
        Arrowofdeowpdown.font = UIFont.fontAwesome(ofSize: 24)
        Arrowofdeowpdown.text=String.fontAwesomeIcon(name: .caretDown)

    }
    
    //add segneture to view
    func addGestureRecogniser(_ touchView: UIView?) {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.changecolor))
        touchView?.addGestureRecognizer(singleTap)
        print("Add action done")
    }
    
    @objc func changecolor() {
        dropDown.show()
    }
    //setup droad down
    func setupDropdown(uiview :UIView){
    // The view to which the drop down will appear on
    dropDown.anchorView = uiview // UIView or UIBarButtonItem
    addGestureRecogniser(uiview)
    // The list of items to display. Can be changed dynamically
   
    dropDown.direction = .bottom
    dropDown.bottomOffset = CGPoint(x: (dropDown.anchorView?.plainView.bounds.minX)!+2, y: (dropDown.anchorView?.plainView.bounds.height)! + 10)
       
        
        if(Localize.currentLanguage()=="ar"){

        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            // Setup your custom UI components
            cell.optionLabel.textAlignment = .right
        }
        }
     
    dropDown.width = UIScreen.main.bounds.width/2 - (UIScreen.main.bounds.width/2)*10/100
    dropDown.dataSource=dataSource
    
    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        self.textLabel.text=item
        self.nameofitem=item
        switch self.nameofitem {
        case "منتجات الجميع" : self.nameofitem = "HOME_COOKER,FOOD_CAR"
       // case "طباخ الحفلات" :self.nameofitem = "PARTY_COOKER"
        case "طباخ المنزل" :self.nameofitem = "HOME_COOKER"
        case "سيارات الطعام" :  self.nameofitem = "FOOD_CAR"
        case "All Product" : self.nameofitem = "HOME_COOKER,FOOD_CAR"
        case "Home Cooker" : self.nameofitem = "HOME_COOKER"
       // case "Party Cooker" : self.nameofitem = "PARTY_COOKER"
        case "Food Car" : self.nameofitem = "FOOD_CAR"
        default: self.nameofitem = item
        }
        self.listofproducte.removeAll()
        self.pageCount = 2
        self.page=1
        if(self.type == 1){
            self.LoadSpecificHomeCookerProduct(page: self.page, limit: self.limit, userId: self.userId , type: self.pofiletype)
        }else {
            self.LoadAllproducte(page: self.page, limit: self.limit, status:self.nameofitem, lat: self.mylocation.coordinate.latitude, long:  self.mylocation.coordinate.longitude, raduis: 100)
           
        }
        //print(self.listofproducte)
        self.ProductCollectioView.reloadData()
       // print( self.nameofitem)
    }
    }

 

}
extension GetAllProducteController : UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ispartycooker{
            return listofpartycookercatogary.count
        }else{
             return listofproducte.count
            }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(ispartycooker == true){
            let cell : ProducteCell = ProductCollectioView.dequeueReusableCell(withReuseIdentifier: "ProducteCell", for: indexPath) as! ProducteCell
            cell.layer.cornerRadius=10
            cell.NameOrderTxt.text=String(indexPath.row)
            cell.NameOrderTxt.textAlignment = .center
            cell.Iconratewidthconstrain.constant=0
            cell.Price.textAlignment = .center
             cell.Price.isHidden = true

            cell.Eateimage.af_setImage(withURL: URL(string: listofpartycookercatogary[indexPath.row].profileImg)!)
           
            cell.NameOrderTxt.text=listofpartycookercatogary[indexPath.row].name
            return cell
            
        }else{
            let cell : ProducteCell = ProductCollectioView.dequeueReusableCell(withReuseIdentifier: "ProducteCell", for: indexPath) as! ProducteCell
            cell.layer.cornerRadius=10
           cell.Iconratewidthconstrain.constant = 59
            cell.NameOrderTxt.text=String(indexPath.row)
            cell.Price.text="\(listofproducte[indexPath.row].price!) \("Riyal".localize())"
          cell.Price.isHidden = false
            cell.Eateimage.af_setImage(withURL: URL(string: listofproducte[indexPath.row].imgs[0])!)
            cell.IconRate.isHidden = false
             cell.Price.textAlignment = .natural
            cell.NameOrderTxt.textAlignment = .natural
            print(listofproducte[indexPath.row].rating)
            switch listofproducte[indexPath.row].rating {
           
            case 0.5 ... 1 :
            cell.IconRate.image = #imageLiteral(resourceName: "very_angry_face-2")
//                resizeImage(image: #imageLiteral(resourceName: "very_angry_face") , targetSize: CGSize(width:50, height: 50))
            case 1.1 ... 2.0 :
                cell.IconRate.image = #imageLiteral(resourceName: "angry_face")
//                    resizeImage(image: #imageLiteral(resourceName: "angry_face") , targetSize: CGSize(width:50, height: 50))
            case 2.1 ... 3.0:
                cell.IconRate.image = #imageLiteral(resourceName: "notbad_face")
//                    resizeImage(image: #imageLiteral(resourceName: "notbad_face") , targetSize: CGSize(width:50, height: 50))
            case 3.1 ... 4.0 :
                cell.IconRate.image = #imageLiteral(resourceName: "happy_face")
//                    resizeImage(image: #imageLiteral(resourceName: "Emoji (1)") , targetSize: CGSize(width:20, height: 20))
            case 4.1 ... 5.0:
                cell.IconRate.image = #imageLiteral(resourceName: "hungry_face")
//                    resizeImage(image: #imageLiteral(resourceName: "happy_face") , targetSize: CGSize(width:50, height: 50))

            default : break
            }
            
        
            cell.NameOrderTxt.text=listofproducte[indexPath.row].name
            return cell
        }
        
    }
    
    
    

   //load getallproducte
    func LoadAllproducte(page :Int ,limit :Int ,status :String,lat :Double , long: Double , raduis:Int)  {
        
        if(page>pageCount){
            
          return
        }else{
            //Load View Show
            
            myLoader.showCustomLoaderview(uiview: self.view)
            
            print(" page :\(page) ,limit :\(limit) ,status :\(status)")
            Getallproducterepo.GetAllProducte(page:page , limit: limit, status: status, lat: lat, long: long, radius: raduis) { (SuccessResponse) in
                if(SuccessResponse != nil){
                    
                    //Success Get All producte
                    let data=SuccessResponse.data
                    if data != nil {
                        for onedata in data!  {
                            self.listofproducte.append(onedata)
                           // print(onedata)
                           // print("------------------------\(onedata.id)")
                        }
                       // print(self.listofproducte)
                        self.ProductCollectioView.reloadData()
                    }
                    self.page=page+1
                    self.pageCount = SuccessResponse.pageCount
                    print("page counte \(self.pageCount)  page \(self.page)"  )
                    print(self.listofproducte.count)
                    //Load View Hide
                }
            }
        }
       
    }
    
    
    
    //load Partycooker catogary
    func LoadPartyCookerCatogary(page :Int ,limit :Int )  {
        
        if(page>pageCount){
            print("here \(self.page)  > \(self.pageCount)")
            return
        }else{
          //Load View Show
            
            
            print(" page :\(page) ,limit :\(limit) ")
            Getallproducterepo.GetPartyCookerCatogary(page:page , limit: limit) { (SuccessResponse) in
                if(SuccessResponse != nil){
                    //Success Get All producte
                    let data=SuccessResponse.data
                    if data != nil {
                        for onedata in data!  {
                            
                            self.listofpartycookercatogary.append(onedata)
                            // print(onedata)
                            // print("------------------------\(onedata.id)")
                        }
                        // print(self.listofproducte)
                        self.ProductCollectioView.reloadData()
                    }
                    self.page=page+1
                    self.pageCount = SuccessResponse.pageCount
                    print("page counte \(self.pageCount)  page \(self.page)"  )
                    print(self.listofpartycookercatogary.count)
                    self.ProductCollectioView.reloadData()
                }
            }
        }
        
    }

    
   ///////////////send data
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(ispartycooker == true){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GetAllProducteAndFilter")
             self.navigationController?.pushViewController(vc, animated: true)
             UserDefaults.standard.set( listofpartycookercatogary[indexPath.row].id , forKey: Profileid)
             UserDefaults.standard.set( "party-cookers" , forKey: Profiletype)
            UserDefaults.standard.set(  listofpartycookercatogary[indexPath.row].id, forKey: PartyCookerId)
             UserDefaults.standard.set( 2 , forKey: Type)
        }else{
////            performSegue(withIdentifier: "ProducteDetailes", sender: listofproducte[indexPath.row])
//            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc : ProducteDetails = storyboard.instantiateViewController(withIdentifier: "ProducteDetails") as! ProducteDetails
//            if(ispartycooker == true){
//            vc.partycooker=listofproducte[indexPath.row] as! PartyCookerData
//            }else{
//            vc.datadetailes=listofproducte[indexPath.row] as! getproductdata
//            }
//           // vc.partycooker=listofproducte[indexPath.row] as! PartyCookerData
//            vc.datadetailes=listofproducte[indexPath.row]
//            if ShowMora {
//               vc.ShowMora=true
//            }else{
//              vc.ShowMora=false
//            }
            
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc : Detailesproducte = storyboard.instantiateViewController(withIdentifier: "Detailesproducte") as! Detailesproducte
            vc.updatedata(datadetailes:listofproducte[indexPath.row] as! getproductdata )
            vc.datadetailes=listofproducte[indexPath.row] as! getproductdata
            
            
            self.navigationController!.pushViewController(vc, animated: true)

        }
        
    }

   
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == ProductCollectioView{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height)-10 >= scrollView.contentSize.height)
            {
                if !isNewDataLoading{
                    
       
                    
                    
                    if(type == 1){
                  self.LoadSpecificHomeCookerProduct(page: self.page, limit: self.limit, userId: self.userId , type: self.pofiletype)
                    }else {
                        
                    
                    self.LoadAllproducte(page: self.page, limit: self.limit, status:self.nameofitem, lat: self.mylocation.coordinate.latitude, long:  self.mylocation.coordinate.longitude, raduis: 100)
                        
                    }

                    isNewDataLoading = true
                    
                    
                }
                isNewDataLoading=false
            }
        }
    }
  
  
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(ispartycooker == true){
//            if (segue.identifier == "ProducteDetailes") {
//                let destination = segue.destination as! ProducteDetails
//                if(sender != nil){
//                    destination.partycooker=sender as! PartyCookerData}
//
//            }
//
//        }else{
//            if (segue.identifier == "ProducteDetailes") {
//                let destination = segue.destination as! ProducteDetails
//                if(sender != nil){
//                    destination.datadetailes=sender as! getproductdata}
//
//            }
//        }
//
//
//    }
    
    
    
    //load getspecifichomecooker
    func LoadSpecificHomeCookerProduct(page :Int ,limit :Int ,userId :Int ,type:String)  {
        if(page>pageCount){
            return
        }else{
            //Load View Show
            Getallproducterepo.GetSpecificHomeCookerProduct(page:page , limit: limit, userId: userId, type:type ) { (SuccessResponse) in
                if(SuccessResponse != nil){
                    //Success Get All producte
                    let data=SuccessResponse.data
                    if data != nil {
                        for onedata in data!  {
                            self.listofproducte.append(onedata)
                           // print(onedata)
                          //  print("------------------------\(onedata.id)")
                        }
                        print(self.listofpartycookercatogary)
                        self.ProductCollectioView.reloadData()
                    }
                    self.page=page+1
                    self.pageCount = SuccessResponse.pageCount
                    print("page counte \(self.pageCount)  page \(self.page)"  )
                    print(self.listofproducte.count)
                }
            }
        }
        
    }
    
    
    
    
    
    //set user id
    func setuserId(userid :Int){
        self.userId=userid
        
    } }
    extension GetAllProducteController : BEMCheckBoxDelegate {
        func setupcheckbox()  {
            ceckbox1.delegate=self
            checkbox2.delegate=self
            var  group = BEMCheckBoxGroup(checkBoxes: [ceckbox1, checkbox2])
            
            // Optionally set which checkbox is pre-selected
            checkbox2.onAnimationType = .fill
            ceckbox1.onAnimationType = .fill
            checkbox2.offAnimationType = .fill
            ceckbox1.offAnimationType = .fill
            ceckbox1.onCheckColor=#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            ceckbox1.onFillColor=#colorLiteral(red: 0.3409686387, green: 0.721593976, blue: 0.8196011186, alpha: 1)
            ceckbox1.onTintColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
            checkbox2.onCheckColor=#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            checkbox2.onFillColor=#colorLiteral(red: 0.3409686387, green: 0.721593976, blue: 0.8196011186, alpha: 1)
            checkbox2.onTintColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
            checkbox2.minimumTouchSize=CGSize(width: 20, height: 20)
            group.selectedCheckBox = self.ceckbox1
            
        }
        
        func didTap(_ checkBox: BEMCheckBox) {
            
            if (checkBox.tag == 0) {
             //select all producte
                dropdownview.isHidden=false
                type = 0
                firstenter()
                
            } else if (checkBox.tag == 1) {
                //select partycooker
                ispartycooker=true
                loaddata=0
                isNewDataLoading=false
                type = 0
                userId = 3
                listofpartycookercatogary = []
                listofproducte  = []
                limit = 10
                page = 1
                pageCount = 2
                totalCount = 0
                nameofitem="PARTY_COOKER"
                
               self.title = "Party Cooker".localize()
                dropdownview.frame =  CGRect(x: 0, y: 0, width: 0, height: 0)
                dropdownview.isHidden=true
                self.navigationItem.setHidesBackButton(true, animated: false)
                textLabel.layer.height=1
                dropDown.layer.height=1
                TableviewTopconstrain.constant=(UIScreen.main.bounds.height*5/100)+4
                
                self.LoadPartyCookerCatogary(page: page, limit: self.limit)
                ProductCollectioView.reloadData()
                
                
            }
        }
       
        
        
        func firstenter(){
             nameofitem="HOME_COOKER,FOOD_CAR"
             ispartycooker=false
             loaddata=0
             isNewDataLoading=false
             type = 0
             userId = 3
             listofproducte  = []
             limit = 10
             page = 1
             pageCount = 2
             totalCount = 0
             ProductCollectioView.reloadData()
            selecttypeproducte.isHidden=false
            type = UserDefaults.standard.integer(forKey: Type)
            pofiletype = UserDefaults.standard.string(forKey: Profiletype)
            TableviewTopconstrain.constant=(UIScreen.main.bounds.height*10/100)+9
            print(" type == \(type)")
          
                setupcheckbox()
          
            setupDropdown(uiview: dropdownview)
            Arrowofdeowpdown.font = UIFont.fontAwesome(ofSize: 24)
            Arrowofdeowpdown.text=String.fontAwesomeIcon(name: .caretDown)
            ProductCollectioView.delegate=self
            ProductCollectioView.dataSource=self
            textLabel.text="All Producte".localize()
           
                LoadAllproducte(page: page, limit: limit, status:nameofitem, lat: mylocation.coordinate.latitude, long:  mylocation.coordinate.longitude, raduis: 100)
            
            
            print("load done")
            
            

            ProductCollectioView.reloadData()
        }
        
        
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
        
        
     
        
        
    }


extension GetAllProducteController: CLLocationManagerDelegate {
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
    
    
    

