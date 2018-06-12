//
//  AddorderHomeCooker.swift
//  FoodServiceClient
//
//  Created by Index on 5/27/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import FSPagerView
import  AlamofireImage
import  Alamofire
import  Localize_Swift

class AddorderHomeCooker: UIViewController , UITableViewDelegate,UITableViewDataSource{
 
 
    @IBOutlet weak var Totalpricelabel: UILabel!
    @IBOutlet weak var totalPriceValue: UILabel!
    @IBOutlet weak var brnSendorder: UIButton!
    @IBOutlet weak var TableViewOrder: UITableView!
   
    
    
    var CountofProducte:[Int]=[]
    var ChooseItemsids :[Int]=[]
    var Productesdata:[getproductdata] = []
    var imagesString:[String]=[]
    var images:[UIImage]=[]
    var gradientView  = CAGradientLayer()
    var  vrate:Float = 0.0
    var type:String!
   
    var GetallHomeCookerplaces = GetallProdacteRepo()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    func setup(){
        self.navigationController?.navigationBar.tintColor = .white
        setupNavigationBar()
        self.navigationItem.backBarButtonItem?.title = "Back".localized()
        
        self.title = "Cart".localized()
        
        for index in 0...(ChooseItemsids.count-1) {
            if Productesdata[index].minAmountToOrder != nil {
                CountofProducte.append(Productesdata[index].minAmountToOrder)
            }
            
        }
        TableViewOrder.dataSource = self
        TableViewOrder.delegate = self
        
         Totalpricelabel.text = "Total Charge".localize()
        brnSendorder.setTitle("Next".localize(), for: .normal)
        brnSendorder.layer.cornerRadius = 4
        brnSendorder.addTarget(self, action: #selector(Sendtonext), for: .touchUpInside)
        myLoader.showCustomLoaderview(uiview: self.view)
        
        Alamofire.request("http://165.227.96.25/api/v1/vat-rate").responseJSON { (data) in
            switch data.result {
            case .success:
                print(data.response?.statusCode)
                do{
                  let res =  data.result.value
                    let response = res as! NSDictionary
                    
                    //example if there is an id
                     let Vra = response.object(forKey: "vatRateOnOrder")!
                    self.vrate = Vra  as! Float
                    self.Updatetototalprice()
                   
                }
                catch{
                    
                }
                
                myLoader.hideCustomLoader()
            case .failure(let error):
                break
            }
        }
        
        
        
        
  
    }
    
    
    
    @objc func Sendtonext(){
        if (type == "food-cars" || type == "restaurant-owners" ){
            RequsestSendOrder(Type:type)
        }else{
         GetAllPlacesOfHmeCoker(id: Productesdata[0].owner.id, type: type)
        }
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Productesdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell:InfoHomeCookerCell = TableViewOrder.dequeueReusableCell(withIdentifier: "InfoHomeCookerCell") as! InfoHomeCookerCell
            cell.NameValue.text = Productesdata[indexPath.row].name
             cell.priceValue.text = "\(Productesdata[indexPath.row].price!) \("Riyal".localize())"
        cell.MinuseBtn.tag = indexPath.row
        cell.PlusBtn.tag = indexPath.row
        cell.CountValue.text=String(CountofProducte[indexPath.row])
        cell.MinuseBtn.addTarget(self, action: #selector(MinusCount(sender:)), for: .touchUpInside)
        cell.PlusBtn.addTarget(self, action: #selector(PlusCount(sender:)), for: .touchUpInside)
        
            return cell
            
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
          return   UIScreen.main.bounds.height*21/100
        
    }
    
    @objc func PlusCount(sender : UIButton) {
        var cell:InfoHomeCookerCell = TableViewOrder.cellForRow(at: IndexPath(row:sender.tag , section: 0)) as! InfoHomeCookerCell
        
        if((Productesdata[sender.tag].maxAmountToOrder)! > Int(cell.CountValue.text!)!  ){
            cell.CountValue.text = String( Int(cell.CountValue.text!)!+1 )
                CountofProducte[sender.tag] = Int(cell.CountValue.text!)!
                self.Updatetototalprice()
        }else{
            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("\("Maxmum order Request".localize()) \((Productesdata[sender.tag].maxAmountToOrder)!)")
            
        }
        
      }
    
    
  @objc  func MinusCount(sender : UIButton) {
        var cell:InfoHomeCookerCell = TableViewOrder.cellForRow(at: IndexPath(row:sender.tag , section: 0)) as! InfoHomeCookerCell
    
    
    
    
//    if(Int(cell.CountValue.text!)! > 1){
//        cell.CountValue.text = String( Int(cell.CountValue.text!)!-1 )
//        CountofProducte[sender.tag] = Int(cell.CountValue.text!)!
//        self.Updatetototalprice()
//    }
    
    
    
    
    
    
    if((Productesdata[sender.tag].minAmountToOrder)! < Int(cell.CountValue.text!)!  ){
        cell.CountValue.text = String( Int(cell.CountValue.text!)!-1 )
        CountofProducte[sender.tag] = Int(cell.CountValue.text!)!
        self.Updatetototalprice()
    }else{
        UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("\("Minimum order Request".localize()) \((Productesdata[sender.tag].minAmountToOrder)!)")
        
    }
    
    
    
    
        
    }
    func Updatetototalprice(){
        var allprice:Float = 0
        var total:Float = 0
        for index in 0...ChooseItemsids.count-1 {
          allprice = allprice + Float(CountofProducte[index])*Float(Productesdata[index].price)
        }
        
        total = allprice + allprice*vrate/100
        
        self.totalPriceValue.text = "\(total) \("Riyal".localize())"
        
        
    }
    
    
    
    
    
   
    

   

}

extension AddorderHomeCooker {
    
    
    func updatedata(productesdata:[getproductdata] , ChooseItemsids :[Int] , imagesString:[String],type:String ){
        self.ChooseItemsids = ChooseItemsids
        self.Productesdata = productesdata
        self.imagesString = imagesString
        self.type = type
        
    }
    
    func GetAllPlacesOfHmeCoker(id : Int, type:String) {
        myLoader.showCustomLoaderview(uiview: self.view)
//        var   profiletype = ""
//        switch type {
//        case "HOME_COOKER":profiletype="home-cookers"
//        case "PARTY_COOKER":profiletype="party-cookers"
//        case "FOOD_CAR":profiletype="food-cars"
//        case "FOOD_CAR":profiletype="restaurant-owners"
//        default : break
//
//        }
        GetallHomeCookerplaces.GetHomeCookerPlace(ownedid: id, type: self.type) { (SuccessResponse) in
            if(SuccessResponse != nil){
                //Success Get All HomeCooker
               
               print("1")
                
                myLoader.hideCustomLoader()
            }
            if(SuccessResponse.count == 0){
                
              UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("No Delivery Place".localize())
               //send order with home cooker place place
                print("2")
                self.RequsestSendOrder(Type:self.type)
                
                
                
                
                
            }else{
                print("3")
                //send to map to choose delivery place
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc:HomeDeliveryPlaceMap = storyboard.instantiateViewController(withIdentifier: "HomeDeliveryPlaceMap") as! HomeDeliveryPlaceMap
                vc.updatedata(productesdata: self.Productesdata, ChooseItemsids: self.ChooseItemsids, countofProducte: self.CountofProducte)
                self.navigationController?.pushViewController(vc, animated: true)
               myLoader.hideCustomLoader()
            }
            
            
            
        }
    }
    
    
    
    
    
    
    
    func RequsestSendOrder(Type:String){
        
        myLoader.showCustomLoaderview(uiview: self.view)
        
        let headers = ["Content-Type": "application/json","Authorization": "Bearer \(getUserAuthKey())"]
        var parameters: [String : Any]!
      
        
        var  dictionarydata:[[String:Any]]=[]
        
        
        
        for index in 0...(ChooseItemsids.count-1) {
           var producteorderdata = CardProductOrder.init(fromDictionary: ["product": ChooseItemsids[index] ,"count": CountofProducte[index] ])
            dictionarydata.append(producteorderdata.toDictionary())
        }
        
        if(self.type == "home-cookers"){
            parameters = [
                "client":  (Singeleton.userInfo?.id!)! ,
                "cookerDeliveryType": "COOKER_PLACE",
                "productOrders":dictionarydata
            ]
        }else if(self.type == "food-cars"){
            parameters = [
                "client":  (Singeleton.userInfo?.id!)! ,
                "productOrders":dictionarydata
            ]
            
        }
        
                

            Alamofire.request("http://165.227.96.25/api/v1/\((self.type)!)/\((Productesdata[0].owner.id)!)/orders", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
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
                        PresentHomeViewController(ViewController:self)
                       
                         }
                        
                    catch {
                        print("An Error Done When Convert Data Success")
                        UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("\(response.result.value)")
                    }
                }else if(response.response?.statusCode == 400) {
                    print("Home Cooker doesn’t support this deliveryPlace")
                    myLoader.hideCustomLoader()
                    UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Home Cooker doesn’t support this deliveryPlace")
                }else if(response.response?.statusCode == 403) {
                    print("Order’s cooker is the only one who can accept or finish the order")
                    UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("\(response.result.value)")
                  myLoader.hideCustomLoader()
                }else if(response.response?.statusCode == 422) {
                    UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("\(response.result.value)")
                    print(response.result.value)
                  myLoader.hideCustomLoader()
                }else if(response.response?.statusCode == 404) {
                    print("RESPONSE 1 \(response.result.value)")
                    
                   myLoader.hideCustomLoader()
                    UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("\(response.result.value)")
                    
                }
                
                
            case .failure(let error):
               myLoader.hideCustomLoader()
                break
            }
        }
        
        
    }
    
    
    
    
    

    
    
    
    
  
    
    
}
