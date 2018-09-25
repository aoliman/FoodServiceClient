//
//  Paymentmethod.swift
//  FoodServiceClient
//
//  Created by Index on 6/19/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit

class Paymentmethod: UIViewController {
    
    @IBOutlet weak var PaymetTableView: UITableView!
    @IBOutlet weak var ViewBtnAndImg: UIView!
    
    @IBOutlet weak var AddBtn: UIButton!
    
    var myPayments:[PaymentData]=[]
    var getpaymentrepo = GetallProdacteRepo()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      GetPAyments()
    }
   func setup(){
    
    AddBtn.layer.cornerRadius = AddBtn.layer.frame.width/2
    ViewBtnAndImg.layer.cornerRadius = AddBtn.layer.frame.width/2
    self.view.bringSubview(toFront: AddBtn)
    PaymetTableView.delegate = self
    PaymetTableView.dataSource = self
    AddBtn.addTarget(self, action: #selector(AddPayment), for: .touchUpInside)
    
    
    }
    @objc func AddPayment(){
       
        self.navigationController?.pushViewController(CreditCardVC(), animated: false)
    }

  

}


extension Paymentmethod: UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPayments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :PaymentmethodCell = PaymetTableView.dequeueReusableCell(withIdentifier: "PaymentmethodCell", for: indexPath) as! PaymentmethodCell
        cell.BorderView.layer.cornerRadius = 4
        cell.BorderView.clipsToBounds = true
        cell.BorderView.layer.borderWidth = 2
        cell.BorderView.layer.borderColor = #colorLiteral(red: 0.8469870687, green: 0.8471063972, blue: 0.8469493985, alpha: 0.7433112158)
        cell.RadioButton.tag = indexPath.row
        cell.Paymentnumber.text = "****-****-****-\((myPayments[indexPath.row].last4)!)"
        cell.deletbutton.tag = indexPath.row
        cell.deletbutton.addTarget(self, action: #selector(DeletePayment(sender:)), for: .touchUpInside)
        if indexPath.row == 0 {
            cell.RadioButton.tag = 0
            cell.RadioButton.select()
        }
        
        switch myPayments[indexPath.row].brand {
        case "Visa":
            cell.PaymentImage.image = #imageLiteral(resourceName: "visa")
            break
        case "MasterCard":
            cell.PaymentImage.image = #imageLiteral(resourceName: "mastercard-png-6954")
             break
        case "American Express":
          //  cell.PaymentImage.image = #imageLiteral(resourceName: "Amex")
             break
        case "Discover":
            cell.PaymentImage.image = #imageLiteral(resourceName: "discover")
             break
        case "Diners Club":
            cell.PaymentImage.image =  #imageLiteral(resourceName: "diners-club-pay-logo")
             break
        case "JCB":
            cell.PaymentImage.image = #imageLiteral(resourceName: "jcb")
             break
        case "UnionPay":
            cell.PaymentImage.image = #imageLiteral(resourceName: "union-pay")
             break
       
        default:
            break
            
        }
  //      cell.PaymentImage.image =
        
//        cell.RadioButton.onSelect {
//            print(self.myPayments[indexPath.row].id)
//            self.SetdefultePayment(paymentid:self.myPayments[indexPath.row].id, index:indexPath.row)
//
//        }
        
        
        
        cell.RadioButton.onSelect {
            if cell.RadioButton.tag ==  0 {
                print("1")
            }else{
                print(self.myPayments[indexPath.row].id)
                self.SetdefultePayment(paymentid:self.myPayments[indexPath.row].id, index:indexPath.row)
                print("2")
            }
        }
        
        
        cell.RadioButton.onDeselect {
          //  self.SelectItem(id :indexPath.row)
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.height*30/100)/2
    }
    func SelectItem(id :Int){
        for index in 0...(myPayments.count)-1 {
            if let cell1  = PaymetTableView.cellForRow(at: IndexPath(item: index, section: 0))  {
              var   cell = cell1 as! PaymentmethodCell
           if cell.RadioButton.tag == id {
                cell.RadioButton.select()
           }else{
            cell.RadioButton.deselect()
            }
            
            } }
        
    }
    
    
    
    
    func GetPAyments(){
        
        getpaymentrepo.GetMyPayment(completion: { (response) in
            print(response)
            self.myPayments=[]
            self.PaymetTableView.reloadData()
            self.myPayments=response
            self.PaymetTableView.reloadData()
          }) { (iserror) in
            
        }
    }
    
    
    
    
    func SetdefultePayment(paymentid:String,index:Int){
        myLoader.showCustomLoaderview(uiview: self.view)
        getpaymentrepo.SetdefultePayment(paymentid: paymentid) { (response) in
         self.SelectItem(id :index)
            self.GetPAyments()
        myLoader.hideCustomLoader()
        }
    }
    
    
    
    
    @objc func DeletePayment(sender:UIButton){
        
        
        let dialogMessage = UIAlertController(title: "Choose Answer".localized(), message: "You Want To Delate".localize(), preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK".localize(), style: .default, handler: { (action) in
            print("ok")
            myLoader.showCustomLoaderview(uiview: self.view)
            self.getpaymentrepo.DeletePayment(paymentid: self.myPayments[sender.tag].id) { (response) in
                self.GetPAyments()
                myLoader.hideCustomLoader()
            }
 
        
            
            
            
        })
        let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel) { (action) -> Void in
            print("cancel")
        }
        
        
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)
        
        
        
        
        
        
    }
    
}
