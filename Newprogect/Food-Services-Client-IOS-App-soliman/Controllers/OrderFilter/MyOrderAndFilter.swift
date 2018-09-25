//
//  MyOrderAndFilter.swift
//  FoodServiceClient
//
//  Created by Index on 5/31/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit

class MyOrderAndFilter: UIViewController {
    @IBOutlet weak var Tablevieworders: UITableView!
    
    @IBOutlet weak var ViewBtnAndImg: UIView!
    @IBOutlet weak var FilterBtn: UIButton!
    
    
    lazy var orderRepo = OrderRepository()
    var orderItems = [OrderData]()
    var reponseOrder:OrderResponseApi?
    var isNewDataLoading = false
    var page:Int = 0
    var totalCount: Int = 0 //total count for api items
    var status: String? //required if filter used
    
    var customView:MyOrderFilter!
    
    var refreshcontrol = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        FilterBtn.layer.cornerRadius = FilterBtn.layer.frame.width/2
        ViewBtnAndImg.layer.cornerRadius = FilterBtn.layer.frame.width/2
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        orderItems = []
        page = 0
        totalCount = 0
        myLoader.hideCustomLoader()
        getOrders(limit: 10)
    }
    
    func setup(){
        
        self.navigationController?.navigationBar.tintColor = .white
        setupNavigationBar()
//        self.navigationItem.backBarButtonItem?.title = "Back".localized()
        
        
        Tablevieworders.delegate = self
        Tablevieworders.dataSource = self
        status = ""
        
        FilterBtn.layer.cornerRadius = FilterBtn.layer.frame.width/2
        ViewBtnAndImg.layer.cornerRadius = FilterBtn.layer.frame.width/2
        FilterBtn.addTarget(self, action: #selector(AppearMapView), for: .touchUpInside)
        
        self.customView = Bundle.main.loadNibNamed("MyOrderFilterView", owner: self, options: nil)![0] as! MyOrderFilter
        
        self.customView.frame = CGRect(x: 0, y: self.view.layer.frame.height, width: self.view.layer.frame.width, height: self.view.layer.frame.height*25/100)
        self.view.addSubview(self.customView)
        if #available(iOS 10.0, *) {
            Tablevieworders.refreshControl = refreshcontrol
        } else {
            Tablevieworders.addSubview(refreshcontrol)
        }
        
        refreshcontrol.addTarget(self, action: #selector(RefreshMyorder), for: .valueChanged)
        self.customView.OrderStatusLabel.text = "Order status :".localize()
        Redrawfilter()
        
        
        
      //  getOrders(limit: 10)

    }
    
    
    @objc func RefreshMyorder(){
        orderItems = []
        page = 0
        totalCount = 0
         getOrders(limit: 10)
    }
    
    @objc func AppearMapView(sender:UIButton){
        UIView.animate(withDuration: 0.6, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            
            
            self.customView.ApplyFilter.backgroundColor = #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1)
            self.customView.ApplyFilter.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
             self.customView.ApplyFilter.setTitle("Apply Filter".localize(), for: .normal)
            self.customView.ApplyFilter.layer.cornerRadius = 2
            self.customView.BtnClose.removeTarget(nil, action: nil, for: .allEvents)
            self.customView.BtnClose.addTarget(self, action: #selector(self.DissAppearMapView), for: .touchUpInside)
            self.customView.frame = CGRect(x: 0, y: self.view.layer.frame.height*75/100, width: self.view.layer.frame.width, height: self.view.layer.frame.height*25/100)
            self.view.layoutIfNeeded()
            
            
        }, completion: { (istrue) in
            
        }
        )
    }
    
    
    @objc func DissAppearMapView(){
        UIView.animate(withDuration: 0.7, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            
            
            self.customView.frame = CGRect(x: 0, y: self.view.layer.frame.height, width: self.view.layer.frame.width, height: self.view.layer.frame.height*25/100)
            self.view.layoutIfNeeded()
            
            
        }, completion: nil)
    }
    
    
    func setupBtnFilter(title :String ,tag :Int,btn :UIButton ){
        
        btn.setTitle(title.localize() , for: .normal )
        btn.tag = tag
        btn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btn.setTitleColor(#colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1), for: .normal)
        
        btn.addTarget(self, action: #selector(self.BtnFilterAction), for: .touchUpInside)
        btn.layer.borderColor = #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1)
        btn.layer.borderWidth = 1.0
        btn.layer.cornerRadius = 2
        
    }
    
    func Redrawfilter(){
        self.setupBtnFilter(title: "Accepted", tag: 0, btn:  self.customView.Accept)
        self.setupBtnFilter(title: "Refused", tag: 1, btn: self.customView.Refuse)
        self.setupBtnFilter(title: "Pending", tag: 2, btn: self.customView.Pending)
        self.setupBtnFilter(title: "Finished", tag: 3, btn: self.customView.Finished)
        self.setupBtnFilter(title: "Delivered", tag: 4, btn: self.customView.Delivered)
        self.setupBtnFilter(title: "OnTheWay", tag: 5, btn: self.customView.Ontheway)
        self.setupBtnFilter(title: "Arrived", tag: 6, btn: self.customView.Arrived)
    }
    
    @objc func BtnFilterAction(sender :UIButton)  {
       
       
        
        orderItems = []
        page = 0
        totalCount = 0
        myLoader.hideCustomLoader()
        switch sender.tag {
        case 0 :
            
            if(sender.backgroundColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)){
                Redrawfilter()
                sender.backgroundColor = #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1)
                sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                status = OrderStatus.accepted.rawValue
            }else{
                status = ""
               Redrawfilter()
            }
            
            
            getOrders(limit: 10)
            break
        case 1 :
            if(sender.backgroundColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)){
                Redrawfilter()
                sender.backgroundColor = #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1)
                sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                status = OrderStatus.refused.rawValue
            }else{
                status = ""
              Redrawfilter()
            }
         
            
            getOrders(limit: 10)
            break
        case 2 :
            if(sender.backgroundColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)){
                Redrawfilter()
                sender.backgroundColor = #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1)
                sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                status = OrderStatus.pending.rawValue
            }else{
                status = ""
               Redrawfilter()
            }
           
            
            getOrders(limit: 10)
            break
        case 3 :
            if(sender.backgroundColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)){
                Redrawfilter()
                sender.backgroundColor = #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1)
                sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                status = OrderStatus.finished.rawValue
            }else{
                status = ""
              Redrawfilter()
            }
           
           
            getOrders(limit: 10)
            break
            break
        case 4 :
            if(sender.backgroundColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)){
                Redrawfilter()
                sender.backgroundColor = #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1)
                sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                status = OrderStatus.delivered.rawValue
            }else{
                status = ""
              Redrawfilter()
            }
           getOrders(limit: 10)
            
        case 5 :
            if(sender.backgroundColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)){
                Redrawfilter()
                sender.backgroundColor = #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1)
                sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                status = OrderStatus.ontheWay.rawValue
            }else{
                status = ""
                Redrawfilter()
            }
            getOrders(limit: 10)
            
            
        case 6 :
            if(sender.backgroundColor == #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)){
                Redrawfilter()
                sender.backgroundColor = #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1)
                sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                status = OrderStatus.arrived.rawValue
            }else{
                status = ""
                Redrawfilter()
            }
            getOrders(limit: 10)
            break
            
        default:
            break
        }
        
        
        
    }
    
    
    
    
    
    
}
extension MyOrderAndFilter :UITableViewDelegate ,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderItems.count
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell : orderInfoAndFilterCell = Tablevieworders.dequeueReusableCell(withIdentifier: "orderInfoAndFilterCell", for: indexPath) as! orderInfoAndFilterCell
        
        if orderItems[indexPath.row].kind == "delivery-guy-order" {
        if orderItems[indexPath.row].deliveryGuy != nil {
            if let name = orderItems[indexPath.row].deliveryGuy.name {
                cell.OrderName.text =  name
            }
            }  } else if orderItems[indexPath.row].cooker != nil{
            if let name = orderItems[indexPath.row].cooker.name {
                cell.OrderName.text =  name
            }
        }
        
        if let ordernumber = orderItems[indexPath.row].id {
            cell.OrderNumber.text = " #\(ordernumber)"
        }
        if let date = orderItems[indexPath.row].creationDate {
            let nativeDateString = date.components(separatedBy: "T")
            let normalizDate = Date().offset(from: Date().getDateFromString(dateString: nativeDateString[0]))
            cell.orderdate.text =  normalizDate
        }
        if let price = orderItems[indexPath.row].totalPrice {
            print(price)
            cell.Orderprice.text =  "\(price) \("Riyal".localize())"
        }else if let price = orderItems[indexPath.row].price {
           cell.Orderprice.text =  "\(price) \("Riyal".localize())"
        }
        if let orderstatus = orderItems[indexPath.row].status {
            cell.State = orderstatus
            cell.OrderStatus.text =  orderstatus.localize()
            switch orderstatus {
            case "PENDING":
                
                cell.OrderStatus.textColor = colorPending
                break;
                
            case "ACCEPTED":
              
                cell.OrderStatus.textColor = colorAccepted
                break;
                
            case "REFUSED":
               
                cell.OrderStatus.textColor = colorRefused
                break;
                
            case "FINISHED":
               
                cell.OrderStatus.textColor = colorFinished
                break;
                
            case "TAKEN":
              
                cell.OrderStatus.textColor = colorTaken
                break;
                
            case "ONTHEWAY":
               
                cell.OrderStatus.textColor = colorOnTheWay
                break;
                
            case "DELIVERYGUY_REQUESTED":
               
                cell.OrderStatus.textColor = colorArrived
                break;
                
            case "ARRIVED":
               
                cell.OrderStatus.textColor = colorArrived
                break;
                
            case "DELIVERED":
              
                cell.OrderStatus.textColor = colorDelivered
                break;
                
            default:
                break
            }
        }
         if orderItems[indexPath.row].cooker != nil{
        if let image = orderItems[indexPath.row].cooker.profileImg {
            cell.orderImage.af_setImage(withURL: URL(string: image)! )
            }} else if let image = orderItems[indexPath.row].deliveryGuy.profileImg {
               cell.orderImage.af_setImage(withURL: URL(string: image)! )
                
        }
        
        if (orderItems[indexPath.row].kind != nil) {
            switch orderItems[indexPath.row].kind {
                
            case "home-cooker-order":
               cell.OrderTypeImage.image = #imageLiteral(resourceName: "map_marker_home_cooker")
                break
            case "party-cooker-order":
                cell.OrderTypeImage.image = #imageLiteral(resourceName: "map_marker_party_cooker-1")
                break
            case "food-car-order":
                cell.OrderTypeImage.image = #imageLiteral(resourceName: "map_marker_food_car")
                break
                
           
            case "delivery-guy-order":
                cell.OrderTypeImage.image = #imageLiteral(resourceName: "delivery_red_partner").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))
                break
                
            case "restaurant-owner-order":
                cell.OrderTypeImage.image = #imageLiteral(resourceName: "tray (1)").tint(with: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1))
                break
                
                
            default : break
                
            }
           
            
            }
       
        cell.orderImage.layer.cornerRadius =   cell.orderImage.layer.frame.width/2

        return cell
        
        
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height*19/100
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if orderItems[indexPath.row].kind == "delivery-guy-order" {
        if (  (orderItems[indexPath.row].status == DeliveryGuyOrderStatus.onTheWay.rawValue || orderItems[indexPath.row].status == DeliveryGuyOrderStatus.arrived.rawValue || orderItems[indexPath.row].status == DeliveryGuyOrderStatus.delivered.rawValue )) {
            
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let Orderdetailescontroller : TrackDelivery = storyboard.instantiateViewController(withIdentifier: "TrackDelivery") as! TrackDelivery
            Orderdetailescontroller.orderItem = orderItems[indexPath.row]
            
            self.navigationController?.pushViewController(Orderdetailescontroller, animated: false)
            
        } else if  orderItems[indexPath.row].status == DeliveryGuyOrderStatus.refused.rawValue || orderItems[indexPath.row].status == DeliveryGuyOrderStatus.pending.rawValue ||
            orderItems[indexPath.row].status == DeliveryGuyOrderStatus.accepted.rawValue ||
            orderItems[indexPath.row].status == DeliveryGuyOrderStatus.taken.rawValue{
            
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let orderDetailsVC : DeliveryGuyPresentInfo = storyboard.instantiateViewController(withIdentifier: "DeliveryGuyPresentInfo") as! DeliveryGuyPresentInfo
            
            orderDetailsVC.orderItem = self.orderItems[indexPath.row]
            
            
            self.navigationController?.pushViewController(orderDetailsVC, animated: true)
        }}else{
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let Orderdetailescontroller : OrderDetailesSatuse = storyboard.instantiateViewController(withIdentifier: "OrderDetailesSatuse") as! OrderDetailesSatuse
            Orderdetailescontroller.orderItem = orderItems[indexPath.row]
            
            self.navigationController?.pushViewController(Orderdetailescontroller, animated: false)
        }
        
        
    }
    
    
    
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        
        if orderItems.count != totalCount
        {
            if scrollView == Tablevieworders{
                
                if ((scrollView.contentOffset.y + scrollView.frame.size.height)-10 >= scrollView.contentSize.height)
                {
                    if !isNewDataLoading {
                        
                        self.getOrders(limit: 10)
                        isNewDataLoading = true
                        
                        
                    }
                    isNewDataLoading = false
                }
            }
        }
        
    }
    
    
    
    
}





extension MyOrderAndFilter
{
    func getOrders(limit: Int)
    {
        
        CancelAllrequsst()
        //edit
        
        Tablevieworders.reloadData()
        self.removeNothingLabel()
        
        self.page += 1
        myLoader.showCustomLoaderview(uiview: self.view)
        print(self.status)
        orderRepo.getOrders(page: self.page, limit: 10, status: status, onSuccess: { (response, statusCode) in
            Loader.hideLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print(response.data)
            if response.data.count == 0
            {
               
                self.addNothingAvailableLabel()
                UIViewController.nothingLabel.text = "No Orders Available".localized()
            }
            else
            {
                self.removeNothingLabel()
                self.totalCount = response.totalCount
                self.orderItems.append(contentsOf: response.data)
                self.Tablevieworders.reloadData()
            }
            self.refreshcontrol.endRefreshing()
           myLoader.hideCustomLoader()
        }) { (errorResponse, statusCode) in
            myLoader.hideCustomLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let errorMessage = errorResponse?.error[0].msg {
                DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage)
            }
            
        }
        
    }
}


