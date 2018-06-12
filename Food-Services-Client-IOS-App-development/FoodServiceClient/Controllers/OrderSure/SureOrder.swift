//
//  SureOrder.swift
//  FoodService
//
//  Created by index-ios on 4/11/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import GoogleMaps
import Toast_Swift
import Localize_Swift
class SureOrder: UIViewController {
    
    var CookerName:String!
    var PeopleNumber:Int!
    var Deliverydate:Date!
    var TotalPrice:Double!
    var Location:CLLocationCoordinate2D!
    var Items:[Int]=[]
    var listofproducte:[getproductdata]=[]
    @IBOutlet weak var TableSureorder: UITableView!
    var Getallproducterepo = GetallProdacteRepo()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        TableSureorder.delegate=self
        TableSureorder.dataSource=self
        TableSureorder.tableFooterView = UIView()
        LoadSpecificProduct(Ids :Items )
        self.title = "Compelete Order".localized()
        
        
        
    }
    func Setupinfo(cookerName:String,
                   peopleNumber:Int,deliverydate:Date,totalPrice:Double,items:[Int],location:CLLocationCoordinate2D){
        self.CookerName=cookerName
        self.Deliverydate=deliverydate
        self.PeopleNumber=peopleNumber
        self.TotalPrice=totalPrice
        self.Items=items
        self.Location=location
    }
    
    

  
}
extension SureOrder :UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listofproducte.count+3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        if(indexPath.row < listofproducte.count){
             let cell : NameCell = TableSureorder.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! NameCell
            cell.name.text=listofproducte[indexPath.row].name
            cell.price.text=String(listofproducte[indexPath.row].price) 
            return cell
        }else if(indexPath.row == listofproducte.count){
            let cell : peopleNumber = TableSureorder.dequeueReusableCell(withIdentifier: "peopleNumber", for: indexPath) as! peopleNumber
            cell.peoplenumber.text=String(PeopleNumber)
            cell.name.text=self.CookerName
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            cell.deliverydate.text=String(describing: dateFormatter.string(from: self.Deliverydate))
            return cell
            
        }else if(indexPath.row == listofproducte.count+1){
            let cell : Totalpricepartycooker = TableSureorder.dequeueReusableCell(withIdentifier: "Totalpricepartycooker", for: indexPath) as! Totalpricepartycooker
            cell.Totalprice.text="\(self.TotalPrice!) \("Riyal".localize())"
            return cell
            
        }else if(indexPath.row == listofproducte.count+2){
            let cell : BtnSure = TableSureorder.dequeueReusableCell(withIdentifier: "BtnSure", for: indexPath) as! BtnSure
            cell.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
            //add target here and to action
            
            cell.Btncompleteorder.addTarget(self, action: #selector(BtnSendOrder), for: .touchUpInside)
            return cell
            
        }else{
            let cell : NameCell = TableSureorder.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! NameCell
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let customInfoWindow = Bundle.main.loadNibNamed("HeaderforSureorder", owner: self, options: nil)![0] as! HeaderTwoLable
        customInfoWindow.name.text="Name".localized()
        customInfoWindow.price.text="Price".localized()
        
        
        return customInfoWindow
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row < listofproducte.count){
            return CGFloat(Double(self.view.frame.width)*10/100)
        }else if(indexPath.row == listofproducte.count){
            return CGFloat(Double(self.view.frame.width)*35/100)
            
        }else if(indexPath.row == listofproducte.count+1){
            return CGFloat(Double(self.view.frame.width)*30/100)
            
        }else if(indexPath.row == listofproducte.count+2){
            return CGFloat(Double(self.view.frame.width)*20/100)
            
        }else{
          return CGFloat(1)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(Double(self.view.frame.width)*20/100)
    }
    
    
    func LoadSpecificProduct(Ids :[Int] )  {
      myLoader.showCustomLoaderview(uiview: self.view)
        for id in Ids {
            Getallproducterepo.GetSpecificProduct(id:id , completionSuccess: {  (SuccessResponse) in
                if(SuccessResponse != nil){
                    //Success Get Specific producte
                    let data=SuccessResponse
                    if data != nil {
                     self.listofproducte.append(data)
                        self.TableSureorder.reloadData()
                    }
                    
                }
            })
            
        }
        
     TableSureorder.reloadData()
       myLoader.hideCustomLoader()
    }
    
    func CreateorderPartycooker(PartyCookerid:Int,lang :Double , lat:Double,Date:Int,Count:Int ,productOrders:[[String:Int]]){
        Getallproducterepo.CreateOrderfForPartyCooker(PartyCookerid: PartyCookerid, lang: lang, lat: lat, Date: Date, Count: Count, productOrders: productOrders) { (successresponse) in
            myLoader.showCustomLoaderview(uiview: self.view)
            PresentHomeViewController(ViewController: self)
            myLoader.hideCustomLoader()
            
            
            
        }
    }
    @objc func BtnSendOrder(sender:UIButton){
        if listofproducte.count == 0{
            UIApplication.shared.keyWindow?.rootViewController?.view.makeToast("Pleas Wait Untill Load")
        }else{
            var productOrders:[[String:Int]]=[]
            for item in Items {
                productOrders.append(["product":Int(item) ])
            }
            print(Date().timeIntervalSince1970*1000)
            print(Int(self.Deliverydate.timeIntervalSince1970*1000+600*1000))
            CreateorderPartycooker(PartyCookerid: listofproducte[0].owner.id, lang: Location.longitude, lat: Location.latitude, Date: Int(self.Deliverydate.timeIntervalSince1970*1000), Count: self.PeopleNumber, productOrders: productOrders )
            sender.isEnabled=false
        }
        
        
    }
    
    
    
    
    
    
}





