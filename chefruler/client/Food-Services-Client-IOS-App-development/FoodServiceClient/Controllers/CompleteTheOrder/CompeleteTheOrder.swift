//
//  CompeleteTheOrder.swift
//  FoodService
//
//  Created by index-ios on 3/14/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import Material
import FontAwesome_swift
class CompeleteTheOrder: UIViewController {
    @IBOutlet weak var CompleteOrderTableview: UITableView!
    
    @IBOutlet weak var refuseBtn: RaisedButton!
    @IBOutlet weak var acceptBtn: RaisedButton!
    var Orderinfocelldata=["name","price","quantity"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        CompleteOrderTableview.delegate=self
        CompleteOrderTableview.dataSource=self
        CompleteOrderTableview.sectionHeaderHeight=CGFloat(Double(self.view.frame.width)*15/100)
        
        refuseBtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        refuseBtn.setTitle("Accept".localize()+"  \(String.fontAwesomeIcon(name: .thumbsUp))", for: .normal)
        
        acceptBtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        acceptBtn.setTitle("Refuse".localize()+" \(String.fontAwesomeIcon(name: .thumbsDown ))", for: .normal)
        
        
    }


}
extension CompeleteTheOrder :UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  ( indexPath.row < 5){
            
           let   cell = CompleteOrderTableview.dequeueReusableCell(withIdentifier: "OrderInfoCell", for: indexPath) as! OrderInfoCell
            cell.NameLable.text=Orderinfocelldata[0]
            cell.PriceLable.text=Orderinfocelldata[1]
            cell.QuantityLable.text=Orderinfocelldata[2]
            return cell
            
        }else if(indexPath.row == 5){
            let cell = CompleteOrderTableview.dequeueReusableCell(withIdentifier: "ClientInfoCell", for: indexPath) as! ClientInfoCell
//            cell.NameLable.text=Orderinfocelldata[0]
//            cell.PriceLable.text=Orderinfocelldata[1]
//            cell.QuantityLable.text=Orderinfocelldata[2]
           
            return cell
            
        }else if(indexPath.row == 6){
          let cell = CompleteOrderTableview.dequeueReusableCell(withIdentifier: "PriCeInfoCell", for: indexPath) as! PriCeInfoCell
            return cell
        }
        else {
            return UITableViewCell()
        }
      
        
        
        
    }
    

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView=UIView.afromNib()
         return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  ( indexPath.row < 5){
           return CGFloat(Double(self.view.frame.width)*10/100)
            
        }else if(indexPath.row == 5){
          return CGFloat(Double(self.view.frame.width)*30/100)
            
        }else if(indexPath.row == 6){
          return  CGFloat(Double(self.view.frame.width)*25/100)
        }else {
             return CGFloat(Double(self.view.frame.width)*25/100)
        }
    }
    
    
    
}
