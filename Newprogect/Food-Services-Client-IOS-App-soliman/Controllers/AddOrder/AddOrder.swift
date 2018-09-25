//
//  AddOrder.swift
//  FoodService
//
//  Created by index-ios on 3/25/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import Moya_Gloss
import SwiftyJSON
class AddOrder: UIViewController , UIAlertViewDelegate {
    var orderdata: getproductdata!
    var card :Cardorder!
    var mydate:Date!
    var mytime:Date!
    @IBOutlet weak var Nocard: UILabel!
    var MyCardOrders:[CardProductOrder]=[]
    var Myarryofdata:[getproductdata]=[]
    var price :Int!
    var quantity:Int!
    var name:String!
    var cookername:String!
    var totalprice:String!
    var date:String!
    var deliveryway:Int!
    var columcount:Int!
    var totalpricewhenedit :Int!
    var selectcard:Int!
    var mydatesend:String?
    var isNewDataLoading=false
    var header:Int!
    var ids:[Int]=[]
    var Getallproducterepo = GetallProdacteRepo()
    var picker : UIDatePicker!
    @IBOutlet weak var tableAddoeder: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
    self.navigationController?.navigationBar.tintColor = .white
   Nocard.text="No Orders In Card".localized()
        
   
    
    
    let type = UserDefaults.standard.integer(forKey: Type)
    
    
    if(type == 1) {
    
   // self.navigationItem.setHidesBackButton(true, animated: false)
    
    }
        
        if   retetrivecard().ownedid == 0 {
            
            
        }else{
            tableAddoeder.sectionHeaderHeight=CGFloat(Double(self.view.frame.width)*15/100)
            card=retetrivecard()
            MyCardOrders=card.productOrders
           
            
            for id in MyCardOrders {
                print(id.product!)
                ids.append(id.product!)
            }
            LoadSpecificProduct(Ids: ids)
            
        }

    }
    override func viewWillAppear(_ animated: Bool) {
      self.navigationController?.isNavigationBarHidden = true
    }
    
    
}

extension AddOrder : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return columcount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row <  Myarryofdata.count) {
          let cell : QuantityCell = tableAddoeder.dequeueReusableCell(withIdentifier: "QuantityCell", for: indexPath) as! QuantityCell
            
            cell.NameLable.text=Myarryofdata[indexPath.row].name

            
            cell.QuantityEditTxt.text=String(MyCardOrders[indexPath.row].count)
            if(indexPath.row==selectcard){
              cell.QuantityEditTxt.isEnabled=true
            }else{
             cell.QuantityEditTxt.isEnabled=false
            }
            
            cell.DeleteBtn.tag=MyCardOrders[indexPath.row].product
            cell.DeleteBtn.addTarget(self, action: #selector(DeleteBtn(sender:)), for: .touchUpInside)
            cell.PriceLable.text=String(Myarryofdata[indexPath.row].price)
            cell.QuantityEditTxt.addTarget(self, action: #selector(EditTotalprice), for: .editingChanged)
            cell.min=orderdata.minAmountToOrder
            cell.max=orderdata.maxAmountToOrder
            return cell
        }else if (  indexPath.row <  Myarryofdata.count+1){
            let cell : CookerNameCell = tableAddoeder.dequeueReusableCell(withIdentifier: "CookerNameCell", for: indexPath) as! CookerNameCell
            cell.Cookernamelable.text=orderdata.owner.name
            cell.preparationtimelabel.text = String(orderdata.cookingDuration)
            return cell
        }else if (  indexPath.row <  Myarryofdata.count+2){
            let cell : CardTotalPriceCell = tableAddoeder.dequeueReusableCell(withIdentifier: "CardTotalPriceCell", for: indexPath) as! CardTotalPriceCell
            cell.Pricelable.text="\("Riyal".localize()) \(String(Float(MyCardOrders[selectcard].count)*orderdata.price))"
            EditTotalprice()
            return cell
        }
            
        else if (  indexPath.row <  Myarryofdata.count+3){
            let cell : Deliverydaycell = tableAddoeder.dequeueReusableCell(withIdentifier: "Deliverydaycell", for: indexPath) as! Deliverydaycell
            cell.clanderbtn.addTarget(self, action: #selector(MovetoCalender), for: .touchUpInside)
            cell.timebtn.addTarget(self, action: #selector(MovetoTime), for: .touchUpInside)
            return cell
        }
            
        else if (  indexPath.row <  Myarryofdata.count+4){
            let cell : WaydeliveryCell = tableAddoeder.dequeueReusableCell(withIdentifier: "WaydeliveryCell", for: indexPath) as! WaydeliveryCell
            
            
            return cell
        } else if (  indexPath.row <  Myarryofdata.count+5){
            let cell : Mapcell = tableAddoeder.dequeueReusableCell(withIdentifier: "Mapcell", for: indexPath) as! Mapcell
            //print(">>>> \(self.orderdata.owner.id) <<<")
            cell.setorderdata(neworderdata: self.orderdata.owner.id, profiletype: self.orderdata.owner.type!, homecookerlocation:CLLocationCoordinate2D(latitude:Double( orderdata.owner.location.lat), longitude:Double(orderdata.owner.location.lng) ) , locationid: orderdata.owner.id)
            
            return cell
        }else if (  indexPath.row <  Myarryofdata.count+6){
            let cell : BtnCell = tableAddoeder.dequeueReusableCell(withIdentifier: "BtnCell", for: indexPath) as! BtnCell
            cell.btnordercomplition.addTarget(self, action: #selector(Sendorder), for: .touchUpInside)
             return cell
        }else {
            let cell : WaydeliveryCell = tableAddoeder.dequeueReusableCell(withIdentifier: "WaydeliveryCell", for: indexPath) as! WaydeliveryCell
          
            return cell
            }
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
       
        let customInfoWindow = Bundle.main.loadNibNamed("HeaderOfCompleteorder", owner: self, options: nil)![0] as! HeaderThreeLabel
        
        customInfoWindow.name.text="Name".localized()
        customInfoWindow.price.text="Price".localized()
        customInfoWindow.quantity.text="Quantity".localized()
        
        return customInfoWindow
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row <  Myarryofdata.count){
            return UIScreen.main.bounds.height*35/100/4
        }
        else if(indexPath.row <  Myarryofdata.count+1){
            return (UIScreen.main.bounds.height*35/100)/2
        }
       else if(indexPath.row <  Myarryofdata.count+2){
            return (UIScreen.main.bounds.height*35/100)/2
        }
       else if(indexPath.row <  Myarryofdata.count+3){
            return (UIScreen.main.bounds.height*35/100)/2
        }
      else  if(indexPath.row <  Myarryofdata.count+4){
           return (UIScreen.main.bounds.height*35/100)/1.5
            
        }
       else if(indexPath.row <  Myarryofdata.count+5){
            return (UIScreen.main.bounds.height*40/100)
        }
    
            
            
            
        else {
            return UIScreen.main.bounds.height*15/100
        }
    }
    

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        if(indexPath.row <  Myarryofdata.count){
          ShowAndReload(index: indexPath.row)
        }
        
    }
    
}


extension AddOrder {
    
    @objc func MovetoCalender(){
        var alert = UIAlertView(title: "Select Date ".localize(), message: "", delegate: self, cancelButtonTitle: "Ok".localize())
        alert.tag = 1
        picker = UIDatePicker(frame: CGRect(x: 10, y: alert.bounds.size.height, width: 300, height: 200))
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
        let cell : Deliverydaycell =  tableAddoeder.cellForRow(at: IndexPath(row: Myarryofdata.count+2 , section: 0)) as! Deliverydaycell
        if(alertView.tag == 1){
            
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = DateFormatter.Style.long
            dateformatter.timeStyle = DateFormatter.Style.none
            let now = dateformatter.string(from: picker.date)
           cell.dattxt.text=String( describing: now)
            mydate = picker.date
            
            print(mydate)
        }else{
            
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = DateFormatter.Style.none
            dateformatter.timeStyle = DateFormatter.Style.medium
            let now = dateformatter.string(from: picker.date)
            cell.timetxt.text=String( describing: now)
            mytime = picker.date
            print(mytime)
            
            
        }
    }

    
    @objc func EditTotalprice(){
        print("in EditTotalprice ")
        if let pricecell = (tableAddoeder.cellForRow(at: IndexPath(row: selectcard , section: 0)) as? QuantityCell){
        if let price = Int(pricecell.PriceLable.text!) {
            if let Quantity = Int(pricecell.QuantityEditTxt.text!) {
                var totalprice : Double = Double(price*Quantity)
               
                let totalcell = tableAddoeder.cellForRow(at: IndexPath(row: Myarryofdata.count+1, section: 0)) as! CardTotalPriceCell
                
                var   rial="Riyal".localize()
                
                totalcell.Pricelable.text="\(rial) \(totalprice)"
                
                }
        }
     
            
            pricecell.QuantityEditTxt.placeholder=""
            if( pricecell.QuantityEditTxt.text != ""  && pricecell.QuantityEditTxt.text != nil){
                print(Int(pricecell.QuantityEditTxt.text!)!)
             
                if(  Int(pricecell.QuantityEditTxt.text!)! <= orderdata.maxAmountToOrder  ){
                    if(  Int(pricecell.QuantityEditTxt.text!)! >= orderdata.minAmountToOrder ){
                        pricecell.QuantityEditTxt.dividerActiveColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
                        pricecell.QuantityEditTxt.dividerNormalColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
                     saveorderincard(product:orderdata.id
                        , count: Int(pricecell.QuantityEditTxt.text!)!)
                        print(retetrivecard().toDictionary())
                        
                    }else{
                        pricecell.QuantityEditTxt.dividerActiveColor=#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                        pricecell.QuantityEditTxt.dividerNormalColor=#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                        
                    }
                }else{
                    pricecell.QuantityEditTxt.dividerActiveColor=#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                    pricecell.QuantityEditTxt.dividerNormalColor=#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                    
                }
                
            }else{
                pricecell.QuantityEditTxt.dividerActiveColor=#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                pricecell.QuantityEditTxt.dividerNormalColor=#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                
            }
            
            
            
        
        }
        
       
        
        
    }
    
    
    
    
}



extension AddOrder :Mydatedelgate {
    func MyselecteDate(date: Date) {
      var card = retetrivecard()
       UserDefaults.standard.removeSuite(named: Card)
        card.deliveryDate = Int( date.timeIntervalSince1970*1000)
        
        var addcarddata = [String : Any ]()
        var  dictionarydata:[[String:Any]]=[]
        for dic in card.productOrders {
           dictionarydata.append(dic.toDictionary())
         }
       
        
        
        
        addcarddata=["ownedid" : card.ownedid ,
                     "client": card.client ,
                     "deliveryDate" : card.deliveryDate ,
                     "clientDeliveryType": card.clientDeliveryType ,
                     "cookerDeliveryType": card.cookerDeliveryType,
                     "deliveryPlace":card.deliveryPlace,
                     "productOrders" : dictionarydata]
        let carddata=Cardorder.init(fromDictionary: addcarddata)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: carddata)
        UserDefaults.standard.set(encodedData, forKey: Card)
        UserDefaults.standard.synchronize()
        print(retetrivecard().toDictionary())
        
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
       mydatesend=dateFormatter.string(from: date)
        let cell : Deliverydaycell =  tableAddoeder.cellForRow(at: IndexPath(row: Myarryofdata.count+2 , section: 0)) as! Deliverydaycell
        cell.dattxt.text=String(describing: mydatesend!)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "calendarsegue" {
            let vc : MyCalander = segue.destination as! MyCalander
            vc.delegate = self
        }
    }
   
    
  
 
    func LoadSpecificProduct(Ids :[Int] )  {
        for id in Ids {
            Getallproducterepo.GetSpecificProduct(id:id , completionSuccess: {  (SuccessResponse) in
                if(SuccessResponse != nil){
                    //Success Get Specific producte
                    let data=SuccessResponse
                    if data != nil {
                        self.Myarryofdata.append(data)
                        self.columcount=6+self.Myarryofdata.count
                        self.ShowAndReload(index:0)
                       
                    }
                    
                }
            })
        }
     
      
       }
    
    func ShowAndReload(index:Int){
        selectcard=index
        orderdata=Myarryofdata[index]
        tableAddoeder.isHidden=false
        Nocard.isHidden=true
        
        tableAddoeder.sectionHeaderHeight=CGFloat(Double(self.view.frame.width)*15/100)
        tableAddoeder.delegate=self
        tableAddoeder.dataSource=self
        tableAddoeder.reloadData()
        
        
        
    }
    
    
    
    
    @objc func DeleteBtn(sender:UIButton){
        
        
        
        
        let dialogMessage = UIAlertController(title: "Choose Answer".localized(), message: "You Want To Delete This Order".localize(), preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK".localized(), style: .default, handler: { (action) -> Void in
            print("ok")
            
            DeletProductfromcard(product: sender.tag)
            if   retetrivecard().ownedid == 0 {
                self.orderdata=nil
                 self.card = nil
                
                
                 self.MyCardOrders.removeAll()
                 self.Myarryofdata.removeAll()
                 self.columcount=0
                 self.selectcard=0
                 self.isNewDataLoading=false
                 self.header=0
                 self.ids.removeAll()
                
                
            }else{
                 self.orderdata=nil
                 self.card = nil
                
                
                 self.MyCardOrders.removeAll()
                 self.Myarryofdata.removeAll()
                 self.columcount=0
                 self.selectcard=0
                 self.isNewDataLoading=false
                 self.header=0
                 self.ids.removeAll()
                 self.tableAddoeder.sectionHeaderHeight=CGFloat(Double(self.view.frame.width)*15/100)
                 self.card=retetrivecard()
                self.MyCardOrders=self.card.productOrders
                
                
                for id in  self.MyCardOrders {
                    print(id.product!)
                     self.ids.append(id.product!)
                }
                self.LoadSpecificProduct(Ids: self.ids)
                
                
            }
             self.tableAddoeder.reloadData()
            if( self.columcount==0){
                 self.tableAddoeder.isHidden=true
                 self.Nocard.isHidden=false
                if(retetrivecard().ownedid==0){
                  self.Nocard.text="No Item In Card".localize()
                }
            }
            print(retetrivecard().toDictionary())
            
            
           
           
            
        })
        
        
        let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel) { (action) -> Void in
            print("cancel")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        
        self.present(dialogMessage, animated: true, completion: nil)
        
   }
    
    @objc func Sendorder(){
        let cell : Deliverydaycell =  tableAddoeder.cellForRow(at: IndexPath(row: Myarryofdata.count+2 , section: 0)) as! Deliverydaycell
        
        if(cell.dattxt.text == "Determinde Delivary Day".localize()){
            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please Choose Day")
        }else if( cell.timetxt.text == "Determinde Delivary Time".localize()){
            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Please Choose Time")
        } else if(cell.timetxt.text != "Determinde Delivary Time".localize() && cell.dattxt.text != "Determinde Delivary Day".localize()){
            
            if(retetrivecard().cookerDeliveryType == "FOOD_CAR"){
                // food-cars
                
                RequsestSendOrder(Type: "food-cars")
                
            }else{
                //home-cookers
                RequsestSendOrder(Type: "home-cookers")
                
                
            }
       
        }
        
        
   }
    func deleteproductfromcard(){
         let cardorder=retetrivecard().productOrders
        for products in cardorder!{
            DeletProductfromcard(product: products.product)
        }
        
        if   retetrivecard().ownedid == 0 {
            self.orderdata=nil
            self.card = nil
            
            
            self.MyCardOrders.removeAll()
            self.Myarryofdata.removeAll()
            self.columcount=0
            self.selectcard=0
            self.isNewDataLoading=false
            self.header=0
            self.ids.removeAll()
            
            
        }else{
            self.orderdata=nil
            self.card = nil
            
            
            self.MyCardOrders.removeAll()
            self.Myarryofdata.removeAll()
            self.columcount=0
            self.selectcard=0
            self.isNewDataLoading=false
            self.header=0
            self.ids.removeAll()
            self.tableAddoeder.sectionHeaderHeight=CGFloat(Double(self.view.frame.width)*15/100)
            self.card=retetrivecard()
            self.MyCardOrders=self.card.productOrders
            
            
            for id in  self.MyCardOrders {
                print(id.product!)
                self.ids.append(id.product!)
            }
            self.LoadSpecificProduct(Ids: self.ids)
            
            
        }
        self.tableAddoeder.reloadData()
        if( self.columcount==0){
            self.tableAddoeder.isHidden=true
            self.Nocard.isHidden=false
            if(retetrivecard().ownedid==0){
                self.Nocard.text="No Item In Card".localize()
            }
        }
        print(retetrivecard().toDictionary())
        
    }

    func RequsestSendOrder(Type:String){
    
    myLoader.showCustomLoaderview(uiview: self.view)
    
    let headers = ["Content-Type": "application/json","Authorization": "Bearer \(getUserAuthKey())"]
    var parameters: [String : Any]!
    var Card=retetrivecard()
        
            
            let date = (combineDateWithTime(date: mydate, time: mytime)!).timeIntervalSince1970 * 1000
            if(Type ==  "food-cars"){
                parameters = [
                    "client": Card.client ,
                    "deliveryDate" : date ,
                    "clientDeliveryType": Card.clientDeliveryType ,
                    "productOrders":Card.toDictionary()["productOrders"]!]
                
            }else{
                if(Card.cookerDeliveryType == "COOKER_PLACE"){
                    parameters = [
                        "client": Card.client ,
                        "deliveryDate" : date ,
                        "clientDeliveryType": Card.clientDeliveryType ,
                        "cookerDeliveryType": Card.cookerDeliveryType,
                        
                        "productOrders":Card.toDictionary()["productOrders"]!]
                    
                }else{
                    parameters = [
                        "client": Card.client ,
                        "deliveryDate" : date ,
                        "clientDeliveryType": Card.clientDeliveryType ,
                        "cookerDeliveryType": Card.cookerDeliveryType,
                        "deliveryPlace": Card.deliveryPlace,
                        "productOrders":Card.toDictionary()["productOrders"]!]
                }
            }
            
            
            Alamofire.request("http://67.205.139.227/api/v1/\(Type)/\(Card.ownedid!)/orders", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                print("Request  \(response.request)")
                
                print(parameters)
                switch response.result {
                case .success:
                    print(response.response?.statusCode)
                    if(response.response?.statusCode == 201){
                        do {
                            let respnseapisucess = try
                                print("RESPONSE 1 \(response.result.value)")
                            Loader.hideLoader()
                            self.deleteproductfromcard()
                            // PresentHomeViewController(ViewController:self)
                            
                        }
                            
                        catch {
                            print("An Error Done When Convert Data Success")
                            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("\(response.result.value)")
                        }
                    } else{
                        do{
                            let json = try  JSON(data: response.data!)
                            Alert.showAlert(title: "Error".localized(), message: json["error"].string!)
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



