//
//  ProducteDetails.swift
//  FoodService
//
//  Created by index-ios on 3/19/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import Localize_Swift
class ProducteDetails: UIViewController , UIGestureRecognizerDelegate{
    var datadetailes : getproductdata!
    var carddictionary:[String:[Int]]!
    var gestureRecognizer :UITapGestureRecognizer!
    var GetallHomeCookerplaces = GetallProdacteRepo()
    var countitytext:String!
    var partycooker:PartyCookerData!
    var ShowMora = false
    
    @IBOutlet weak var tableViewproductedetailes: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     self.navigationController?.navigationBar.tintColor = .white
        setupNavigationBar()
//        self.navigationItem.backBarButtonItem?.title = "Back".localized()
       
        if let name = datadetailes.name {
             self.title = name
        }
        tableViewproductedetailes.delegate=self
        tableViewproductedetailes.dataSource=self
        tableViewproductedetailes.separatorInset=UIEdgeInsetsMake(0, 0, 0,80);
        gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        gestureRecognizer.delegate = self
        
       var type = UserDefaults.standard.integer(forKey: Type)
        
        print(" type == \(type)")
        if(type == 1) {
           
         
            
        }
       
        
        
        print("type of  \(datadetailes.kind)")
        if(UserDefaults.standard.integer(forKey: ShowMore) == 0){
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: ShowMore) + 1, forKey: ShowMore)
            ShowMora = true
        }else{
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: ShowMore) + 1, forKey: ShowMore)
        }
        
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       // print(" show btn == \(UserDefaults.standard.integer(forKey: ShowMore))")
        if(self.isMovingFromParentViewController){
        
          UserDefaults.standard.set(UserDefaults.standard.integer(forKey: ShowMore) - 1, forKey: ShowMore)
           
        }
        
    }




}
extension ProducteDetails :UITableViewDelegate ,UITableViewDataSource {
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(partycooker != nil){
           return 7
        }else if (datadetailes.kind=="party-cooker-product"){
            return 9
        }
        else{
            return 9
            }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row==0){
            let cell : ProducteimageCell = tableViewproductedetailes.dequeueReusableCell(withIdentifier: "ProducteimageCell", for: indexPath) as! ProducteimageCell
            if(datadetailes.imgs != nil){
                cell.updatedata(newimagesstringe: datadetailes.imgs  , price: String (datadetailes.price) )
                cell.PagerViewImages.reloadData()
                print("cell.imagesString \(cell.imagesString)")
            }
            return cell
        }
        if(indexPath.row==1){
            let cell : namecell = tableViewproductedetailes.dequeueReusableCell(withIdentifier: "namecell", for: indexPath) as! namecell
            if let name = datadetailes.name {
             cell.name.text=name
            }
            
            return cell
        }
        if(indexPath.row==2){
            let cell : gradientscell = tableViewproductedetailes.dequeueReusableCell(withIdentifier: "gradientscell", for: indexPath) as! gradientscell
            if let ingredients = datadetailes.ingredients {
                cell.gradient.text=ingredients
            }
          
            return cell
        }
        if(indexPath.row==3){
            let cell : preandrescell = tableViewproductedetailes.dequeueReusableCell(withIdentifier: "preandrescell", for: indexPath) as! preandrescell
            if let cookingDuration = datadetailes.cookingDuration {
                cell.pre.text=String(cookingDuration)
            }
            
            if let minPeriodToOrder = datadetailes.minPeriodToOrder {
               cell.res.text=String(minPeriodToOrder)
            }
            
            
            
            return cell
        }
        if(indexPath.row <= 6){
            if(indexPath.row >= 4){
                let cell : MuliteCell = tableViewproductedetailes.dequeueReusableCell(withIdentifier: "MuliteCell", for: indexPath) as! MuliteCell
                switch  indexPath.row {
                case 4 :
                    cell.nameoflabel.text="Minimum order Request".localize()
                   
                    if let maxAmountToOrder = datadetailes.minAmountToOrder {
                        cell.valueoflabel.text=String(maxAmountToOrder)
                    }
                    
                    
                    
                    return cell
                case 5 :
                    cell.nameoflabel.text="Maxmum order Request".localize()
                    if let minAmountToOrder = datadetailes.maxAmountToOrder {
                        cell.valueoflabel.text=String(minAmountToOrder)
                    }
                    
                    return cell
                    
                case 6 :
                    cell.nameoflabel.text="Minimum Reservation".localize()
                    
                    if let minAmountToOrder = datadetailes.maxOrdersInDay {
                        cell.valueoflabel.text=String(minAmountToOrder)
                    }
                    
                    return cell
                   
                default:
                    return cell
                }
                
            }else {
                return UITableViewCell()
            }
           
            
        }
            
        if(indexPath.row==7){
            let cell : Cookernamecell = tableViewproductedetailes.dequeueReusableCell(withIdentifier: "Cookernamecell", for: indexPath) as! Cookernamecell
           
            if (datadetailes.kind=="party-cooker-product"){
                cell.Addmoreproduct.layer.width=0
                cell.Addmoreproduct.isHidden=true
            }else{
                if(UserDefaults.standard.integer(forKey: ShowMore) != 1){
                  cell.Addmoreproduct.isHidden = true
                }
                else{
                    cell.Addmoreproduct.isHidden = false
                   cell.Addmoreproduct.addTarget(self, action: #selector(AddMoreHomeCookerProducte), for: .touchUpInside)
                }
              
            }
            if let name = datadetailes.owner.name {
                cell.name.text=name
                
            }
            
            
            return cell
        }
            
        if(indexPath.row==8){
           
            if (datadetailes.kind=="party-cooker-product"){
                let cell : Priceforperson = tableViewproductedetailes.dequeueReusableCell(withIdentifier: "Priceforperson", for: indexPath) as! Priceforperson
                cell.PriceforPerson.text=String(datadetailes.serviceFees)
                return cell
            }else{
                 let cell : Addtocardcell = tableViewproductedetailes.dequeueReusableCell(withIdentifier: "Addtocardcell", for: indexPath) as! Addtocardcell
                cell.senddata(orderdata: datadetailes)
                
                if let maxAmountToOrder = datadetailes.minAmountToOrder {
                    cell.max=maxAmountToOrder
                }
                
                if let minAmountToOrder = datadetailes.maxAmountToOrder {
                    cell.min=minAmountToOrder
                }
                cell.textproducte.addTarget(self, action: #selector(SetQuantity), for: .allEditingEvents)
                cell.Btnaddcard.addGestureRecognizer(gestureRecognizer)
                return cell
            }
            
            
           
            
        }
            
            
       else {
            return UITableViewCell()
        }
       
      
        
      
    }
    
   
    
    @objc func SetQuantity(){
         let cell = (tableViewproductedetailes.cellForRow(at: IndexPath(row: 8 , section: 0)) as? Addtocardcell)
        countitytext=cell?.textproducte.text
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if(indexPath.row==0){
          return UIScreen.main.bounds.height*35/100
        }
        if(indexPath.row==1){
         return 0
        }
        if(indexPath.row==2){
          return (UIScreen.main.bounds.height*35/100)/2.5
        }
        if(indexPath.row==3){
           return (UIScreen.main.bounds.height*35/100)/3.5
        }
        if(indexPath.row<=6){
            if(indexPath.row>=4){
             return (UIScreen.main.bounds.height*35/100)/3.5
            }else{
             return (UIScreen.main.bounds.height*35/100)/3.5
            }
            
        }
        if(indexPath.row==7){
            return (UIScreen.main.bounds.height*35/100)/3.5
        }
        if(indexPath.row==8){
            if (datadetailes.kind=="party-cooker-product"){
                return (UIScreen.main.bounds.height*35/100)/4
            }else{return (UIScreen.main.bounds.height*35/100)/2}
            
            
        }
            
            
          
        else {
            return UIScreen.main.bounds.height*35/100
        }
        
        
    }
    
    //////////////////////////////////////////////make it user defulte /////////////////////////////

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "ShowHomeCookerProduct") {
//            let destination = segue.destination as! GetAllProducteAndFilter
//            if(sender != nil){
//             destination.ShowMora = false
//
//
//
//
//            }
//
//        }
//
//
//
//
//    }
    
    
    
 //////////////////////////////////////////////make it user defulte /////////////////////////////
    func showalertdialog(count : Int){
    
      print(retetrivecard().toDictionary())
        print(retetrivecard().toDictionary())
        print("datadetailes.owner.id! \(datadetailes.owner.id!)")
        print("MyCard.ownedid \(retetrivecard().ownedid)")
       if   retetrivecard().ownedid != 0 {
         var MyCard = retetrivecard()
       
        if ( MyCard.ownedid == datadetailes.owner.id! ){
            
            
            
            var   profiletype = ""
            switch self.datadetailes.owner.type {
            case "HOME_COOKER":profiletype="home-cookers"
            case "PARTY_COOKER":profiletype="party-cookers"
            case "FOOD_CAR":profiletype="food-cars"
                case "RESTAURANT_OWNER":profiletype="restaurant-owners"
            default : break
                
            }
            UserDefaults.standard.set( self.datadetailes.owner.id , forKey: Profileid)
            UserDefaults.standard.set( profiletype , forKey: Profiletype)
           print("in  3")
           AddToCardSecondTime(count: count)

            }else{
                let dialogMessage = UIAlertController(title: "Choose Answer".localized(), message: "You Want To Delete Old Card And Create New Card".localize(), preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK".localized(), style: .default, handler: { (action) -> Void in
                    print("ok")
                    // back to home cooker producte
                    var   profiletype = ""
                    switch self.datadetailes.owner.type {
                    case "HOME_COOKER":profiletype="home-cookers"
                    case "PARTY_COOKER":profiletype="party-cookers"
                    case "FOOD_CAR":profiletype="food-cars"
                    default : break
                        
                    }
                     print("in  2")
                    UserDefaults.standard.set( self.datadetailes.owner.id , forKey: Profileid)
                    UserDefaults.standard.set( profiletype , forKey: Profiletype)
                    self.AddToCardFisrtTime(count :count)
                    print("-------------------------------------")
                    print(retetrivecard().toDictionary())
                    print("-------------------------------------")
                    
                })
                
                
                let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel) { (action) -> Void in
                    print("cancel")
                }
                
                //Add OK and Cancel button to dialog message
                dialogMessage.addAction(ok)
                dialogMessage.addAction(cancel)
            
            
                self.present(dialogMessage, animated: true, completion: nil)
          
            }
            
       }else {
        AddToCardFisrtTime(count :count)
        print(retetrivecard().toDictionary())
        print("datadetailes.owner.id! \(datadetailes.owner.id!)")
        print("MyCard.ownedid \(retetrivecard().ownedid)")
        
        }
        
      
        
        

    }
        
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
     let addtocard = tableViewproductedetailes.cellForRow(at: IndexPath(row: 8 , section: 0)) as! Addtocardcell
        if(addtocard.textproducte.text == ""){
           addtocard.errottext.text="Enter Number Between \(datadetailes.maxAmountToOrder!) And \(datadetailes.minAmountToOrder!)"
            
        }
        if (addtocard.cansend == true){
            print("in button")
            showalertdialog(count: Int(countitytext)! )
            
        }
      
        
        
    }
    
    func AddToCardFisrtTime(count :Int){
         myLoader.showCustomLoaderview(uiview: self.view)
        print("Add first time")
        var   profiletype = ""
        switch datadetailes.owner.type {
        case "HOME_COOKER":profiletype="home-cookers"
        case "PARTY_COOKER":profiletype="party-cookers"
        case "FOOD_CAR":profiletype="food-cars"
        default : break
            
        }
        print(profiletype)
        if(datadetailes.owner.type == "FOOD_CAR"){
         savecard(ownerid: self.datadetailes.owner.id, clien: getUserId(), deliveryDate:  Int(NSDate().timeIntervalSince1970 * 1000), cookerDeliveryType: "FOOD_CAR", clientDeliveryType: "DIRECT", deliveryPlace:self.datadetailes.owner.id, count:count ,  product: self.datadetailes.id )
            
             UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Order Add To Card".localized())

            
            
        }else{
            GetallHomeCookerplaces.GetHomeCookerPlace(ownedid: datadetailes.owner.id ,type: profiletype) { (SuccessResponse) in
                print("SuccessResponse=   \(SuccessResponse)")
                if(SuccessResponse != nil ){
                    print("AddToCardFisrtTime 1")
                    if(SuccessResponse.isEmpty ==  true){
                        savecard(ownerid: self.datadetailes.owner.id, clien: getUserId(), deliveryDate:  Int(NSDate().timeIntervalSince1970 * 1000), cookerDeliveryType: "COOKER_PLACE", clientDeliveryType: "DIRECT", deliveryPlace:self.datadetailes.owner.id, count:count ,  product: self.datadetailes.id )
                        print("---------------\(SuccessResponse)----------------")
                        
                    } else {
                        print("AddToCardFisrtTime 2")
                        //Success Get All HomeCooker and have delivery place
                        
                        let deliveryPlace = SuccessResponse[0]
                        savecard(ownerid: self.datadetailes.owner.id, clien: getUserId(), deliveryDate:  Int(NSDate().timeIntervalSince1970 * 1000), cookerDeliveryType: "DELIVERY_PLACE", clientDeliveryType: "DIRECT", deliveryPlace:deliveryPlace.deliveryPlace.id
                            , count:count ,  product: self.datadetailes.id )
                    }
                }
                else {
                    print("AddToCardFisrtTime 3")
                    //Success Get All HomeCooker and have delivery place
                    savecard(ownerid: self.datadetailes.owner.id, clien: getUserId(), deliveryDate:  Int(NSDate().timeIntervalSince1970 * 1000), cookerDeliveryType: "COOKER_PLACE", clientDeliveryType: "DIRECT", deliveryPlace:self.datadetailes.owner.id, count:count ,  product: self.datadetailes.id )
                }
                UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Order Add To Card".localized())

            }
        }
       
       
          }
    
    func AddToCardSecondTime(count :Int){
         print("Add second time")
         saveorderincard(product: self.datadetailes.id, count: count)
         UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Order Add To Card".localized())

    }
  
    

    ////////////Add more product
    @objc func AddMoreHomeCookerProducte()  {
     var   profiletype = ""
        switch datadetailes.owner.type {
        case "HOME_COOKER":profiletype="home-cookers"
        case "PARTY_COOKER":profiletype="party-cookers"
        case "FOOD_CAR":profiletype="food-cars"
        default : break
            
      }
        
        UserDefaults.standard.set( datadetailes.owner.id , forKey: Profileid)
        UserDefaults.standard.set( profiletype , forKey: Profiletype)
        UserDefaults.standard.set( 1 , forKey: Type)
        UserDefaults.standard.set( datadetailes.owner.id , forKey: HomeCookerId)
        print("-----type = \(UserDefaults.standard.integer(forKey: HomeCookerId))--------")
        performSegue(withIdentifier: "ShowHomeCookerProduct", sender: datadetailes.owner.id)

    }
    
    
    
   
    
    
    
    
}
