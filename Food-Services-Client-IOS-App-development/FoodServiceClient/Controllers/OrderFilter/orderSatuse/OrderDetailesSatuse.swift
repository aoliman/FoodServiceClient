//
//  OrderDetailesSatuse.swift
//  FoodServiceClient
//
//  Created by Index on 6/3/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import FSPagerView
class OrderDetailesSatuse: UIViewController {

    
    
    @IBOutlet weak var Tableviewtopconstrain: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var TableviewDetailes: UITableView!
    var orderItem:OrderData!
    
    var imagesString:[String]=[]
  
    @IBOutlet weak var PagerViewImages: FSPagerView! {
        didSet {
            self.PagerViewImages.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl!
    var Getallproducterepo = GetallProdacteRepo()
    
     let orderrepo = OrderRepository()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        setupNavigationBar()
//        self.navigationItem.backBarButtonItem?.title = "Back".localized()
        Tableviewtopconstrain.constant = self.view.layer.frame.height*22/100
        

        TableviewDetailes.delegate = self
        TableviewDetailes.dataSource = self
       // Setup()
       
    }
  
    
    func Setup(){
        
        myLoader.showCustomLoaderview(uiview: self.view)
        orderrepo.getSingleOrder(orderId: orderItem.id! , stauts: "", userId: (Singeleton.userInfo?.id)!, onSuccess: { (response)  in
            
          print(response)
            self.orderItem = response
             self.imagesString.removeAll()
            if self.orderItem.productOrders != nil {
                for producte in self.orderItem.productOrders{
                    if producte.product.imgs[0] != nil {
                        
                        self.imagesString.append(producte.product.imgs[0])
                        
                    }
                }}
            self.SetPagerViewImage()
            self.PagerViewImages.reloadData()
            self.TableviewDetailes.reloadData()
             myLoader.hideCustomLoader()
            
             }, onFailure: { (error, statuscode) in
            DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
        self.navigationController?.navigationBar.tintColor = .white
        Setup()
       
        
        
    }

  

}


extension OrderDetailesSatuse :UITableViewDelegate ,UITableViewDataSource {
    
    @objc func GetDeliveryGuy(){
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let Orderdetailescontroller : FinishedAndGetDirection = storyboard.instantiateViewController(withIdentifier: "FinishedAndGetDirection") as! FinishedAndGetDirection
        Orderdetailescontroller.orderItem = orderItem
        Orderdetailescontroller.isGetdirection = false
        self.navigationController?.pushViewController(Orderdetailescontroller, animated: false)
        
        
        
    }
    
    @objc func GetDirection(){
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let Orderdetailescontroller : FinishedAndGetDirection = storyboard.instantiateViewController(withIdentifier: "FinishedAndGetDirection") as! FinishedAndGetDirection
        Orderdetailescontroller.orderItem = orderItem
        Orderdetailescontroller.isGetdirection = true
        self.navigationController?.pushViewController(Orderdetailescontroller, animated: false)
        
    }
    
    
    @objc func PopupRate(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let passController : PopupRate = storyboard.instantiateViewController(withIdentifier: "PopupRate") as! PopupRate
        
        passController.modalPresentationStyle = .custom
        passController.modalTransitionStyle = .crossDissolve
        
        print(orderItem?.id!)
        print(orderItem?.toJSON())
        if( orderItem?.kind! == "delivery-guy-order" ){
            passController.isDeliveryguyorder = true
            passController.OrderId = orderItem?.id!
            passController.clientid = orderItem?.client.id!
            passController.OrderOwner = orderItem?.order!
        }else{
            passController.clientid = orderItem?.client.id!
            passController.isDeliveryguyorder = false
            passController.OrderId = orderItem?.id!
            
        }
        // passController.OrderOwner = orderDetails?.order!
        passController.delegate = self
        present(passController, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(orderItem)
        
        
            return orderItem.productOrders.count+2

       
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       // PopupRate()
        if(indexPath.row == 0){
          let cell : OrderSatutsNumber = TableviewDetailes.dequeueReusableCell(withIdentifier: "OrderSatutsNumber", for: indexPath) as! OrderSatutsNumber
            cell.OrderNumberValue.text = "#\(orderItem.id!)".localize()
             cell.OrderStatusValue.text = "  \("\(orderItem.status!)".localize())"
            switch orderItem.status {
            case "PENDING":
                
                cell.OrderStatusValue.textColor = colorPending
                break;
                
            case "ACCEPTED":
                
                cell.OrderStatusValue.textColor = colorAccepted
                break;
                
            case "REFUSED":
                
                cell.OrderStatusValue.textColor = colorRefused
                break;
                
            case "FINISHED":
                
                cell.OrderStatusValue.textColor = colorFinished
                break;
                
            case "ONTHEWAY":
                
                cell.OrderStatusValue.textColor = colorTaken
                break;
                
            case "ONTHEWAY":
                
                cell.OrderStatusValue.textColor = colorOnTheWay
                break;
                
            case "DELIVERYGUY_REQUESTED":
                
                cell.OrderStatusValue.textColor = colorArrived
                break;
                
            case "ARRIVED":
                
                cell.OrderStatusValue.textColor = colorArrived
                break;
                
            case "DELIVERED":
                
                cell.OrderStatusValue.textColor = colorDelivered
                break;
                
            default:
                break
            }
            return cell
        } else if(indexPath.row == orderItem.productOrders.count+1){
            let cell : orderClientNamecell = TableviewDetailes.dequeueReusableCell(withIdentifier: "orderClientNamecell", for: indexPath) as! orderClientNamecell
            if let name = orderItem.cooker.name {
              cell.ClientNameValue.text = orderItem.cooker.name!
            }
            if let individualsCount = orderItem.individualsCount {
                cell.NumberofcustesValue.text = "\(orderItem.individualsCount!) \("Guest".localize())"
            }
            
            
            if let cooker = orderItem.cooker{
                if let address = cooker.address {
                    cell.AdressValue.text = address
                }
            }
            
            if orderItem.totalPrice != nil {
                cell.TotalChargeValue.text = "\(orderItem.totalPrice!) \("Riyal".localize())"
            }
            
             cell.DeliveredBtn.isHidden = true
            cell.GetDiraction.isHidden = true
            cell.GetdeliveryGuy.isHidden = true
            
            if orderItem.status == OrderStatus.delivered.rawValue && orderItem.rated == false {
              cell.DeliveredBtn.isHidden = false
               cell.DeliveredBtn.setTitle("Rated".localize(), for: .normal)
                cell.GetDiraction.isHidden = true
                cell.GetdeliveryGuy.isHidden = true
                 cell.DeliveredBtn.layer.cornerRadius = 3
                cell.DeliveredBtn.addTarget(self, action: #selector(PopupRate), for: .touchUpInside)
                
            }
            
            if orderItem.status == OrderStatus.finished.rawValue && orderItem.cooker.type  != "PARTY_COOKER" {
                
                cell.DeliveredBtn.isHidden = true
                cell.ViewBtnHieight.isHidden = false
                cell.GetDiraction.isHidden = false
                cell.GetdeliveryGuy.isHidden = false
               
                
                cell.GetDiraction.layer.cornerRadius = 2
                cell.GetdeliveryGuy.layer.cornerRadius = 2
                
                cell.GetDiraction.addTarget(self, action: #selector(GetDirection), for: .touchUpInside)
                cell.GetdeliveryGuy.addTarget(self, action: #selector(GetDeliveryGuy), for: .touchUpInside)
            }
//            else if orderItem.status == OrderStatus.arrived.rawValue && orderItem.cooker.type  != "PARTY_COOKER"{
//
//                cell.DeliveredBtn.isHidden = true
//                cell.ViewBtnHieight.isHidden = false
//                cell.GetDiraction.isHidden = false
//                cell.GetdeliveryGuy.isHidden = false
//                cell.DeliveredBtn.titleLabel?.text = "Finished".localize()
//                cell.DeliveredBtn.addTarget(self, action: #selector(SendStatutoPartycooker), for: .touchUpInside)
//
//
//
//
//
//                 }
            else if orderItem.status == OrderStatus.arrived.rawValue && orderItem.cooker.type  == "PARTY_COOKER"{
                
                cell.DeliveredBtn.isHidden = false
                cell.ViewBtnHieight.isHidden = false
                cell.GetDiraction.isHidden = true
                cell.GetdeliveryGuy.isHidden = true
                cell.DeliveredBtn.titleLabel?.text = "Finished".localize()
                cell.DeliveredBtn.addTarget(self, action: #selector(SendStatutoPartycooker), for: .touchUpInside)
                }else{
                
                
                
                cell.GetDiraction.isHidden = true
                cell.GetdeliveryGuy.isHidden = true
                
                
              
            }
           
            return cell
           
        }
        else{
          let cell : OrderProducteDetailes = TableviewDetailes.dequeueReusableCell(withIdentifier: "OrderProducteDetailes", for: indexPath) as! OrderProducteDetailes
            if let name = orderItem.productOrders[indexPath.row-1].product.name {
              cell.NameVlue.text = orderItem.productOrders[indexPath.row-1].product.name
            }
            if let count = orderItem.productOrders[indexPath.row-1].count {
               cell.ProducteCount.text = "\(orderItem.productOrders[indexPath.row-1].count!) \("Box".localize())"
            }
           
            if  orderItem.productOrders[indexPath.row-1].product.price != nil && orderItem.productOrders[indexPath.row-1].count != nil {
               cell.priceValue.text = "\(Float (orderItem.productOrders[indexPath.row-1].count)*orderItem.productOrders[indexPath.row-1].product.price) \("Riyal".localize())"
            }
           
            
            
         return cell
        }
        
      
        
        
        
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row == 0){
            return UIScreen.main.bounds.height*15/100
        }
        else if(indexPath.row == orderItem.productOrders.count+1){
           
             return UIScreen.main.bounds.height*35/100
        }
        else{
             return UIScreen.main.bounds.height*10/100
        }
    }
    
    
    @objc func SendStatutoPartycooker(){
        var   profiletype = ""
        switch orderItem.cooker.type {
        case "HOME_COOKER":profiletype="home-cookers"
        case "PARTY_COOKER":profiletype="party-cookers"
        case "FOOD_CAR":profiletype="food-cars"
        case "RESTAURANT_OWNER":profiletype="restaurant-owners"
        default : break
            
        }
        
        Getallproducterepo.SendOrderStatus(Orderid: orderItem.id , clientid: orderItem.cooker.id , Status: "FINISHED", type:profiletype) { [weak  self](successresponse) in
            print("Send Success \(successresponse)")
            let cell :orderClientNamecell = self!.TableviewDetailes.cellForRow(at: IndexPath(item: self!.orderItem.productOrders.count+1, section: 0)) as!  orderClientNamecell
                cell.DeliveredBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                cell.DeliveredBtn.isHidden = true
            
        }
    }
    
    
   
    
    
    
    
}



extension OrderDetailesSatuse :FSPagerViewDataSource ,FSPagerViewDelegate {
    // number of image in pagerview
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imagesString.count
    }
    // set image to evey cell
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let url = self.imagesString[index]
        
        cell.imageView?.af_setImage(withURL: URL(string:url)!)
        return cell
    }
    // tell pagecontrol to move to count of same cell
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        self.pageControl.currentPage = index
    }
    // tell pagecontrol to move to count of same cell
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
    //setup pageview and page control
    func  setpagecontrol(){
        PagerViewImages.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        PagerViewImages.isInfinite = true
        PagerViewImages.transformer = FSPagerViewTransformer(type: .crossFading )
        pageControl.setStrokeColor(#colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1), for: .selected)
        pageControl.setStrokeColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        pageControl.setFillColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        pageControl.setFillColor(#colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1), for: .selected)
        
        pageControl.contentHorizontalAlignment = .center
        
        
        
        
    }
    
    
    func SetPagerViewImage(){
        PagerViewImages.dataSource = self
        PagerViewImages.delegate = self
        pageControl.numberOfPages = imagesString.count
        setpagecontrol()
    }
    
    
    
    
    
    
    
    
    
    
    
}

extension OrderDetailesSatuse : RateSend {
    func SendRate() {
        let cell :orderClientNamecell = TableviewDetailes.cellForRow(at:IndexPath(item:orderItem.productOrders.count+1 , section: 0) ) as! orderClientNamecell
        cell.DeliveredBtn.isHidden = true
        
    }
    
    
}



