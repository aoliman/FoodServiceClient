//
//  PayMentMenu.swift
//  FoodServiceClient
//
//  Created by Index on 6/24/18.
//  Copyright © 2018 Index. All rights reserved.
//
protocol Addcredit {
    func AddCrediteFunc()
    func SendOrderfuc()
}

import UIKit

class PayMentMenu: UIViewController {

    @IBOutlet weak var PaymetTableView: UITableView!

    var delegte:Addcredit!
    
    @IBOutlet weak var BackView: UIView!
    
    @IBOutlet weak var CornerView: UIView!
    var myPayments:[PaymentData]=[]
    var getpaymentrepo = GetallProdacteRepo()
    
    @IBOutlet weak var BtnSelect: UIButton!
    
    
    
    
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
        
      
        PaymetTableView.delegate = self
        PaymetTableView.dataSource = self
       // PaymetTableView.layer.cornerRadius = 6
        BtnSelect.setTitle("Select".localize(), for: .normal)
        BtnSelect.layer.cornerRadius = 4
        BtnSelect.addTarget(self, action: #selector(SendOrde), for: .touchUpInside)
       // self.navigationController?.isNavigationBarHidden = true
        CornerView.layer.cornerRadius = 6
       
         BackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
    }
    
    @objc func SendOrde(){
        
        delegte.SendOrderfuc()
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    
   
    
    
    
}






extension PayMentMenu: UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPayments.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :PaymentmenuCell = PaymetTableView.dequeueReusableCell(withIdentifier: "PaymentmenuCell", for: indexPath) as! PaymentmenuCell

        
        if indexPath.row == myPayments.count{
            cell.RadioButton.tag = indexPath.row
            cell.Paymentnumber.text = "Add new Credit card".localize()
            
            if indexPath.row == 0 {
                cell.RadioButton.tag = 0
                cell.RadioButton.select()
            }
            cell.PaymentImage.image = #imageLiteral(resourceName: "credit-card-with-add-button")
            
            cell.RadioButton.onSelect {
                if cell.RadioButton.tag ==  0 {
                    print("1")
                }else{
                    self.dismiss(animated: false, completion: nil)
                    self.delegte.AddCrediteFunc()
                    
                    print("2")
                }
            }
            
            
        }else{
            cell.RadioButton.tag = indexPath.row
            cell.Paymentnumber.text = "****-****-****-\((myPayments[indexPath.row].last4)!)"
            
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
            
            
            cell.RadioButton.onSelect {
                if cell.RadioButton.tag ==  0 {
                    print("1")
                }else{
                    self.SetdefultePayment(paymentid:self.myPayments[indexPath.row].id, index:indexPath.row)
                    print("2")
                }
            }
            
            
            
            
            cell.RadioButton.onDeselect {
                //  self.SelectItem(id :indexPath.row)
            }
        }
       
    
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.height*25/100)/2
    }
    func SelectItem(id :Int){
        for index in 0...(myPayments.count)-1 {
            if let cell1  = PaymetTableView.cellForRow(at: IndexPath(item: index, section: 0))  {
                var   cell = cell1 as! PaymentmenuCell
                if cell.RadioButton.tag == id {
                    cell.RadioButton.select()
                }else{
                    cell.RadioButton.deselect()
                }
                
            } }
        
    }
    
    
    
    
    func GetPAyments(){
        self.PaymetTableView.reloadData()
        self.myPayments=[]
        self.PaymetTableView.reloadData()
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
    
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
    
 
    
}
