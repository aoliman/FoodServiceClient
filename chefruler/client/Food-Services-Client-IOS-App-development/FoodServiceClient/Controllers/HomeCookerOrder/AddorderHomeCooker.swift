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
import SwiftyJSON
class AddorderHomeCooker: UIViewController , UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate{
 
 
    @IBOutlet weak var Totalpricelabel: UILabel!
    @IBOutlet weak var totalPriceValue: UILabel!
    @IBOutlet weak var brnSendorder: UIButton!
    @IBOutlet weak var TableViewOrder: UITableView!
   
    @IBOutlet weak var ProducteLAbel: UILabel!
    @IBOutlet weak var HomeCookerView: UIView!
    @IBOutlet weak var DateAndTime: UILabel!
    @IBOutlet weak var DateValue: UILabel!
    @IBOutlet weak var TimeValue: UILabel!
    @IBOutlet weak var BtnTime: UIButton!
    @IBOutlet weak var BtnDate: UIButton!
    @IBOutlet weak var HomeCookerHeight: NSLayoutConstraint!
    @IBOutlet weak var BackTableView: UIView!
    
    var CountofProducte:[Int]=[]
    var ChooseItemsids :[Int]=[]
    var Productesdata:[getproductdata] = []
    var imagesString:[String]=[]
    var images:[UIImage]=[]
    var gradientView  = CAGradientLayer()
    var  vrate:Float = 0.0
    var type:String!
    var picker : UIDatePicker!
    var mydate:Date!
    var mytime:Date!
    var GetallHomeCookerplaces = GetallProdacteRepo()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        //AddShadow(view:TableViewOrder.backgroundView!)
       
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
     }
    
    
    func setup(){
        self.navigationController?.navigationBar.tintColor = .white
        setupNavigationBar()
//        self.navigationItem.backBarButtonItem?.title = "Back".localized()
        
        self.title = "Cart".localized()
        
        
        if Productesdata[0].kind == "restaurant-owner-product" {
            for index in 0...(ChooseItemsids.count-1) {
               
                CountofProducte.append(1)
             
                
            }
        }else{
            for index in 0...(ChooseItemsids.count-1) {
                if Productesdata[index].minAmountToOrder != nil {
                    CountofProducte.append(Productesdata[index].minAmountToOrder)
                }
                
            }
        }
        
        
        
        
        
        
        
        TableViewOrder.dataSource = self
        TableViewOrder.delegate = self
        
         Totalpricelabel.text = "Total Charge".localize()
        brnSendorder.setTitle("Next".localize(), for: .normal)
        brnSendorder.layer.cornerRadius = 4
        brnSendorder.addTarget(self, action: #selector(Sendtonext), for: .touchUpInside)
        myLoader.showCustomLoaderview(uiview: self.view)
        
        Alamofire.request("http://67.205.139.227/api/v1/vat-rate").responseJSON { (data) in
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
            case .failure(_):
                break
            }
        }
        
        
        
        if self.type == "home-cookers" {
            HomeCookerHeight.constant = UIScreen.main.bounds.height*20/100
            ProducteLAbel.text = "Products".localize()
            HomeCookerView.isHidden = false
            
            
            
            
           // HomeCookerView.layer.sha
            DateAndTime.text = "Date and time".localize()
            DateValue.text = "Delivery date".localize()
            TimeValue.text = "Delivery time".localize()
            BtnTime.titleLabel?.font = UIFont.fontAwesome(ofSize: 30)
             BtnTime.titleLabel?.adjustsFontSizeToFitWidth = true
            BtnTime.setTitle(String.fontAwesomeIcon(name: .clockO), for: .normal)
            BtnDate.titleLabel?.font = UIFont.fontAwesome(ofSize: 30)
            BtnDate.titleLabel?.adjustsFontSizeToFitWidth = true
            BtnDate.setTitle(String.fontAwesomeIcon(name: .calendar), for: .normal)
            BtnDate.addTarget(self, action: #selector(MovetoCalender), for: .touchUpInside)
            BtnTime.addTarget(self, action: #selector(MovetoTime), for: .touchUpInside)
            HomeCookerView.layoutIfNeeded()
            
            AddShadow(view:HomeCookerView)
        }else{
            HomeCookerHeight.constant = 4
            ProducteLAbel.text = "Products".localize()
            HomeCookerView.isHidden = true
            DateAndTime.isHidden = true
            DateValue.isHidden = true
            TimeValue.isHidden = true
            BtnTime.isHidden = true
            BtnTime.isHidden = true
            BtnDate.isHidden = true
//            BtnDate.addTarget(self, action: #selector(), for: .touchUpInside)
//            BtnTime.addTarget(self, action: #selector(), for: .touchUpInside)
            
        }
        AddShadow(view:BackTableView)
        
        let tapdate = UITapGestureRecognizer(target: self, action: #selector(DateTap(_:)))
        tapdate.numberOfTapsRequired = 1
        DateValue.isUserInteractionEnabled = true
        DateValue.addGestureRecognizer(tapdate)
        
        
        let taptime = UITapGestureRecognizer(target: self, action: #selector(TimeTap(_:)))
        taptime.numberOfTapsRequired = 1
        TimeValue.isUserInteractionEnabled = true
        TimeValue.addGestureRecognizer(taptime)
        
  
    }
    @objc func DateTap(_ recognizer: UITapGestureRecognizer) {
        
        MovetoCalender()
        
    }
    @objc func TimeTap(_ recognizer: UITapGestureRecognizer) {
        
        MovetoTime()
        
    }
    func AddShadow(view:UIView){
        
        var  shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: view.layer.bounds, cornerRadius: 3).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 1, height: 1)
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowRadius = 2
        
        view.layer.insertSublayer(shadowLayer, at: 0)
        shadowLayer.layoutIfNeeded()
       
    }
    
    
    
    @objc func Sendtonext(){
        
        PushPopcredite()
        
        
        
        
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
        if Productesdata[indexPath.row].kind == "restaurant-owner-product" {
         cell.CountValue.text=String(1)
        }else{
            cell.CountValue.text=String(CountofProducte[indexPath.row])

        }
        cell.MinuseBtn.addTarget(self, action: #selector(MinusCount(sender:)), for: .touchUpInside)
        cell.PlusBtn.addTarget(self, action: #selector(PlusCount(sender:)), for: .touchUpInside)
        
            return cell
            
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
          return   UIScreen.main.bounds.height*21/100
        
    }
    
    @objc func PlusCount(sender : UIButton) {
        var cell:InfoHomeCookerCell = TableViewOrder.cellForRow(at: IndexPath(row:sender.tag , section: 0)) as! InfoHomeCookerCell
        if (Productesdata[sender.tag].kind ==  "restaurant-owner-product" ) {
            
                cell.CountValue.text = String( Int(cell.CountValue.text!)!+1 )
                CountofProducte[sender.tag] = Int(cell.CountValue.text!)!
                self.Updatetototalprice()
            
        }else{
            if((Productesdata[sender.tag].maxAmountToOrder)! > Int(cell.CountValue.text!)!  ){
                cell.CountValue.text = String( Int(cell.CountValue.text!)!+1 )
                CountofProducte[sender.tag] = Int(cell.CountValue.text!)!
                self.Updatetototalprice()
            }else{
                UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("\("Maxmum order Request".localize()) \((Productesdata[sender.tag].maxAmountToOrder)!)")
                
            }
        }
        
        
      }
    
    
  @objc  func MinusCount(sender : UIButton) {
        var cell:InfoHomeCookerCell = TableViewOrder.cellForRow(at: IndexPath(row:sender.tag , section: 0)) as! InfoHomeCookerCell
    
    
    
    
//    if(Int(cell.CountValue.text!)! > 1){
//        cell.CountValue.text = String( Int(cell.CountValue.text!)!-1 )
//        CountofProducte[sender.tag] = Int(cell.CountValue.text!)!
//        self.Updatetototalprice()
//    }
    
    if (Productesdata[sender.tag].kind ==  "restaurant-owner-product" ) {
        
        if( 1 < Int(cell.CountValue.text!)!  ){
            cell.CountValue.text = String( Int(cell.CountValue.text!)!-1 )
            CountofProducte[sender.tag] = Int(cell.CountValue.text!)!
            self.Updatetototalprice()
        }
        
    }else{
        if((Productesdata[sender.tag].minAmountToOrder)! < Int(cell.CountValue.text!)!  ){
            cell.CountValue.text = String( Int(cell.CountValue.text!)!-1 )
            CountofProducte[sender.tag] = Int(cell.CountValue.text!)!
            self.Updatetototalprice()
        }else{
            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("\("Minimum order Request".localize()) \((Productesdata[sender.tag].minAmountToOrder)!)")
            
        }
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
                vc.senddate = self.combineDateWithTime(date: self.mydate, time: self.mytime)!
                self.navigationController?.pushViewController(vc, animated: true)
               myLoader.hideCustomLoader()
            }
            
            
            
        }
    }
    
    
    
    func PushPopcredite(){
        if(self.type == "food-cars" || type == "restaurant-owners" ){
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let passController : PayMentMenu = storyboard.instantiateViewController(withIdentifier: "PayMentMenu") as! PayMentMenu
            
            passController.modalPresentationStyle = .custom
            passController.modalTransitionStyle = .crossDissolve
            
            passController.delegte = self
            // passController.OrderOwner = orderDetails?.order!
            present(passController, animated: true, completion: nil)
            
        }else{
            if mydate == nil  {
                UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please Choose Day")
            }else if mytime == nil {
                UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please Choose Time")
            }else{
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let passController : PayMentMenu = storyboard.instantiateViewController(withIdentifier: "PayMentMenu") as! PayMentMenu
                
                passController.modalPresentationStyle = .custom
                passController.modalTransitionStyle = .crossDissolve
                
                passController.delegte = self
                // passController.OrderOwner = orderDetails?.order!
                present(passController, animated: true, completion: nil)
                
                // self.navigationController?.pushViewController(passController, animated: false)
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
            if mydate == nil  {
              UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please Choose Day")
                return
            }else if mytime == nil {
              UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please Choose Time")
                return
            }else{
               let senddate =  combineDateWithTime(date: mydate, time: mytime)!
                parameters = [
                    "client":  (Singeleton.userInfo?.id!)! ,
                    "cookerDeliveryType": "COOKER_PLACE",
                    "productOrders":dictionarydata ,
                    "deliveryDate":Int( (senddate.timeIntervalSince1970)*1000 )
                ]
            }
           
        }else if(self.type == "food-cars" || type == "restaurant-owners" ){
            parameters = [
                "client":  (Singeleton.userInfo?.id!)! ,
                "productOrders":dictionarydata
            ]
            
        }
        
                

            Alamofire.request("http://67.205.139.227/api/v1/\((self.type)!)/\((Productesdata[0].owner.id)!)/orders", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print("Request  \(response.request)")

            print(parameters)
            switch response.result {
            case .success:
                print(response.response?.statusCode)
                 print("RESPONSE 1 \(response.result.value)")
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
                } else  {
                    do{

                        let json = try  JSON(data: response.data!)
                        Alert.showAlert(title: "Error".localized(), message: json["error"].string!)

                        myLoader.hideCustomLoader()
                    }catch{}
                    
                }


            case .failure(let error):
               myLoader.hideCustomLoader()
                break
            }
        }
        
        
    }
    
    
    
    ///choose calender and time
    @objc func MovetoCalender(){
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
    
    @objc  func MovetoTime(){
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
            DateValue.text=String( describing: now)
            mydate = picker.date
            
            print(mydate)
        }else{
            
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = DateFormatter.Style.none
            dateformatter.timeStyle = DateFormatter.Style.medium
            let now = dateformatter.string(from: picker.date)
            TimeValue.text=String( describing: now)
            mytime = picker.date
            print(mytime)
            
            
        }
    }

    

    
    
    
    
  
    
    
}


extension AddorderHomeCooker : Addcredit  , PresentpopUpcredite {
    func presentPupupCredite() {
        PushPopcredite()
    }
    
    func AddCrediteFunc() {
        var vc = CreditCardVC()
        vc.ispopup = true
        vc.delegte = self
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func SendOrderfuc() {
        if (type == "food-cars" || type == "restaurant-owners" ) {
            RequsestSendOrder(Type:type)
        }else{
            GetAllPlacesOfHmeCoker(id: Productesdata[0].owner.id, type: type)
        }
    }
    
    
}
