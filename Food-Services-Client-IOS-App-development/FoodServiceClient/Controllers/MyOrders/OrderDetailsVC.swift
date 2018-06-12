//
//  DeliverPlaceOrderDetailsVC.swift
//  FoodServiceProvider
//
//  Created by Index on 2/5/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Localize_Swift
private let orderdetailsIdentifier = "orderdetailsIdentifier"
private let orderDetailsInfoIdentifier = "orderDetailsInfoIdentifier"
private let buttonCellIdentifier = "buttonCellIdentifier"
private let totalPriceCellIdentifier = "totalPriceCellIdentifier"
private let labelCellIdentifier = "labelCellIdentifier"
private let detailesMapCell = "detailesMapCellIdentifier"

private let sectionHeader = "sectionHeader"
private let sectionFooter = "sectionFooter"

class OrderDetailsVC: UIViewController
{
    var collectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
    //map configration
    var homecookerlocation :CLLocationCoordinate2D!
    var mylocation = CLLocation()
    var locationmaanager = CLLocationManager()
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 12
    var id:Int!
    var profiletype:String!
    var Btnlocation :CLLocationCoordinate2D!
    var Getallproducterepo = GetallProdacteRepo()
    //mapview apper
    var FoodCararry:[AllFoodCArData]=[]
    var Ids:[Int]=[]
    var Name:[String]=[]
    var Phone:[String]=[]
    var LocationFoodcar:[NSArray]=[]
    var AllFoodcar:[DeliveryGuyInfoRes]=[]
    var Foodcarid:[FoodCarMapRes]=[]
    var counter = 0
    
    var myview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints  = false
        
        return view
    }()
    var RateBtn : UIButton = {
    let button =  UIButton()
    button.imageView?.contentMode = .scaleAspectFit
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        button.setTitleColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), for: .normal)
        button.setTitle("Rate".localize(), for: .normal )
    button.backgroundColor = #colorLiteral(red: 0.009331892245, green: 0.7435878515, blue: 0.8486500382, alpha: 1)
       button.layer.cornerRadius = 10
    return button
    }()
    
    var showmark :[CLLocationCoordinate2D]=[]
    
    lazy var orderRepo = OrderRepository()
    var orderDetails:OrderData?
    var status = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if(  orderDetails?.status! == "FINISHED"){
            self.Configaremap()
        }
        
        
        self.setupView()
        view.addSubview(collectionView)
        
        self.setupNavigationBar()
        //back button back grround
        self.navigationController?.navigationBar.tintColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .white
        
        self.collectionView.register(OrderDetailsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader , withReuseIdentifier: sectionHeader)
        
        self.collectionView.register(OrderDetailsCollectionFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter , withReuseIdentifier: sectionFooter)
        
        self.collectionView.register(DeliverPlaceOrderCell.self, forCellWithReuseIdentifier: orderdetailsIdentifier)
        self.collectionView.register(OrderDetailsInfoCell.self, forCellWithReuseIdentifier: orderDetailsInfoIdentifier)
        self.collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: buttonCellIdentifier)
        self.collectionView.register(TotalPriceCell.self, forCellWithReuseIdentifier: totalPriceCellIdentifier)
        self.collectionView.register(LabelCollectionViewCell.self, forCellWithReuseIdentifier: labelCellIdentifier)
        self.collectionView.register(DetailesMapCell.self, forCellWithReuseIdentifier: detailesMapCell)
        print(orderDetails?.status)
        collectionView.snp.makeConstraints {
                make in
                make.left.equalTo(self.view.snp.left).offset(5)
                make.right.equalTo(self.view.snp.right).offset(-5)
                make.top.equalTo(self.view.snp.top).offset(70)
                make.bottom.equalTo(self.view.snp.bottom)
        }
      
        if(orderDetails?.status == "DELIVERED"){
            if(orderDetails?.rated == false){
            view.addSubview(RateBtn)
            RateBtn.addTarget(self, action: #selector(PopupRate), for: .touchUpInside)
             RateBtn.snp.makeConstraints { (make) -> Void in
           // make.top.equalTo(self.view.snp.top).offset(380)
             make.centerY.equalTo(self.view.snp.centerY).offset(50)
             make.centerX.equalTo(self.view.snp.centerX).offset(1)
             make.height.equalTo(self.view.frame.height/13)
             make.width.equalTo(self.view.frame.width*5/10)
            
            
        }
            }
            
        }
        
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func PopupRate(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let passController : PopupRate = storyboard.instantiateViewController(withIdentifier: "PopupRate") as! PopupRate
        
        passController.modalPresentationStyle = .custom
        passController.modalTransitionStyle = .crossDissolve
        
        print(orderDetails?.id!)
        print(orderDetails?.toJSON())
        if( orderDetails?.kind! == "delivery-guy-order" ){
          passController.isDeliveryguyorder = true
          passController.OrderId = orderDetails?.id!
            passController.clientid = orderDetails?.client.id!
          passController.OrderOwner = orderDetails?.order!
        }else{
             passController.clientid = orderDetails?.client.id!
            passController.isDeliveryguyorder = false
           passController.OrderId = orderDetails?.id!
            
        }
       // passController.OrderOwner = orderDetails?.order!
        present(passController, animated: true, completion: nil)
    }
   
}

extension OrderDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            if indexPath == [0,0]
            {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeader, for: indexPath) as! OrderDetailsCollectionReusableView
                
                if orderDetails?.cooker != nil {
                    if orderDetails?.cooker.type == "PARTY_COOKER" {
                        headerView.quantity.isHidden = true

                    } else if orderDetails?.cooker.type == "HOME_COOKER" {
                        headerView.quantity.isHidden = false

                    } else {
                        headerView.quantity.isHidden = true
                        //food-cars
                    }
                   

                } else {
                    headerView.quantity.isHidden = true

                }
//                if orderDetails?.status == OrderStatus.arrived.rawValue {
//                    headerView.quantity.isHidden = true
//                } else {
//                    headerView.quantity.isHidden = false
//
//                }
                return headerView
            }
            
        case UICollectionElementKindSectionFooter:
            
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionFooter, for: indexPath) as! OrderDetailsCollectionFooter
            
            return footerView
            
        default:
            
            print(false, "Unexpected element kind")
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        if section == 0 || section == 1
        {
            let  width  = Double(UIScreen.main.bounds.width)
            
            return CGSize(width: width - 10, height: 1)
        }
        else
        {
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        if section == 0
        {
            let  width  = Double(UIScreen.main.bounds.width)
            return CGSize(width: width - 10, height: 60 )
        }
        else
        {
            return CGSize.zero
        }
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if orderDetails?.status == OrderStatus.finished.rawValue {
            return 4

        } else {
            //edit
            print(orderDetails?.status)
            return  3

        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if section == 0 {
            if orderDetails?.status == OrderStatus.arrived.rawValue {
                
                return 1

            } else  if orderDetails?.status == OrderStatus.accepted.rawValue {
                return 1
                
            } else {
                return 1

            }

            
        } else if section == 1 {
            if orderDetails?.status == OrderStatus.arrived.rawValue {
                //party-cooker-order
                if orderDetails?.individualsCount != nil {
                    return 4
                } else {
                    return 3
                }
                
            } else  if orderDetails?.status == OrderStatus.finished.rawValue {
                //party-cooker-order
                if orderDetails?.individualsCount != nil {
                    //this for number of cell in section 2
                    //edit
                    return 5
                } else {
                    //edit
                    return 5
                }
                
            } else  if orderDetails?.status == OrderStatus.accepted.rawValue {
               return 2
                
            } else {
               return 2
                
            }
            
            
        } else if section == 3 {
            
            if orderDetails?.status == OrderStatus.pending.rawValue {
                return 2
            }
            //edit
            return 1
        } else {
            return 1

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        if section == 3 {
            if orderDetails?.status == OrderStatus.pending.rawValue {
                
                let cellwidth  = Double(UIScreen.main.bounds.width * 0.4) - 10
                let totalCellWidth: Double = cellwidth * Double(collectionView.numberOfItems(inSection: 3))
                let totalSpacingWidth:Double = Double(10 * (collectionView.numberOfItems(inSection: 3)))
                
                let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
                let rightInset = leftInset
                
                return UIEdgeInsetsMake(20, leftInset, 0, rightInset)
            } else {
                return UIEdgeInsetsMake(4, 0, 0, 0)

            }

        } else {
            return UIEdgeInsetsMake(0, 0, 0, 0)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var  width  = Double(UIScreen.main.bounds.width)
        width =  (width - 10)
        
        if indexPath.section == 2 {
            return CGSize.init(width: width, height: 100)

        } else if indexPath.section == 3 {
            
            if orderDetails?.status == OrderStatus.pending.rawValue {
                
                return CGSize.init(width: width * 0.4 , height: 50)
            } else {
                return CGSize.init(width: width, height: 300)
            }
            
        } else {
            return CGSize.init(width: width, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if indexPath.section == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: orderdetailsIdentifier, for: indexPath)
            
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: orderDetailsInfoIdentifier, for: indexPath)
            
            return cell
        }
            
        else if indexPath.section == 2
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: totalPriceCellIdentifier, for: indexPath)
            
            return cell
        }
        else if indexPath.section == 3
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailesMapCell, for: indexPath)
            
            return cell
        }
        else
        {
            switch orderDetails?.status
            {
                case OrderStatus.accepted.rawValue?:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonCellIdentifier, for: indexPath)
                    return cell

                
                case OrderStatus.delivered.rawValue?:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelCellIdentifier, for: indexPath)
                    return cell
                
                case OrderStatus.finished.rawValue?:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelCellIdentifier, for: indexPath)
                    return cell

                case OrderStatus.pending.rawValue?:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonCellIdentifier, for: indexPath)
                    return cell
                
                case OrderStatus.refused.rawValue?:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelCellIdentifier, for: indexPath)
                    return cell
                
             case OrderStatus.arrived.rawValue?:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonCellIdentifier, for: indexPath)
                
                return cell
                default:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: labelCellIdentifier, for: indexPath)
                    return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
                if indexPath.section == 0
                {
                    let cell = cell as? DeliverPlaceOrderCell
                    if orderDetails?.cooker != nil {
                        if orderDetails?.cooker.type == "PARTY_COOKER" {
                            if orderDetails?.productOrders != nil {
                                let productOrders = orderDetails?.productOrders[indexPath.row]
                                if productOrders?.product.serviceFees != nil {
                                    let price = (productOrders?.product.price)! + (productOrders?.product.serviceFees)!
                                    cell?.price.text = String(price) + " " + defaultsKey.sr.rawValue.localized()
                                    
                                } else {
                                    if let price = productOrders?.product.price {
                                        cell?.price.text = "\(price)" + " " + defaultsKey.sr.rawValue.localized()
                                        
                                    }
                                }
                                cell?.quantity.text = ""
                                
                            } else  {
                                cell?.type.text = ""
                                cell?.quantity.text = ""
                                cell?.price.text = ""
                            }
                        } else if orderDetails?.cooker.type == "HOME_COOKER" {
                            if orderDetails?.productOrders != nil {
                                let productOrders = orderDetails?.productOrders[indexPath.row]
                                if productOrders?.product.serviceFees != nil {
                                    let price = (productOrders?.product.price)! + (productOrders?.product.serviceFees)!
                                    cell?.price.text = "\(price)" + " " + defaultsKey.sr.rawValue.localized()
                                } else {
                                    if let price = productOrders?.product.price {
                                        cell?.price.text = "\(price)" + " " + defaultsKey.sr.rawValue.localized()

                                    }
                                }
                                
                                if let count = productOrders?.count {
                                  cell?.quantity.text =  String(describing:count) + " " + "x"
                                }
                                
                            } else  {
                                cell?.type.text = ""
                                cell?.quantity.text = ""
                                cell?.price.text = ""
                            }
                     } else {
                            //food-cars
                            if orderDetails?.productOrders != nil {
                                let productOrders = orderDetails?.productOrders[indexPath.row]
                                if productOrders?.product.serviceFees != nil {
                                    let price = (productOrders?.product.price)! + (productOrders?.product.serviceFees)!
                                    cell?.price.text = "\(price)" + " " + defaultsKey.sr.rawValue.localized()
                                } else {
                                    let price = productOrders?.product.price
                                    cell?.price.text = "\(price)" + " " + defaultsKey.sr.rawValue.localized()
                                }
                                cell?.quantity.text = ""
                                
                            } else  {
                                cell?.type.text = ""
                                cell?.quantity.text = "" + "x"
                                cell?.price.text = ""
                            }
                        }
                        
                        
                    }

//
                }
                else if indexPath.section == 1
                {
                    
                    let cell = cell as? OrderDetailsInfoCell
                    if orderDetails?.cooker != nil {
                        if orderDetails?.cooker.type == "PARTY_COOKER" {
                            if orderDetails?.individualsCount != nil {
                                // if party cooker
                                if indexPath.row == 0
                                {
                                    cell?.titleLable.text = "Order number".localized()
                                    if let id = orderDetails?.id {
                                        cell?.textLabel.text = "\(id)"
                                    }
                                    
                                } else if indexPath.row == 1 {
                                    
                                    if self.orderDetails?.cooker != nil {
                                        cell?.titleLable.text = "HomeCooker".localized()
                                        cell?.textLabel.text = orderDetails?.cooker.name
                                    } else {
                                        cell?.titleLable.text = "delivery Guy".localized()
                                        cell?.textLabel.text = orderDetails?.deliveryGuy.name
                                    }
                                    
                                }else if indexPath.row == 2 {
                                    cell?.titleLable.text = "delivery date".localized()
                                    if orderDetails?.deliveryDate != nil {
                                        let timeInterval = Double((orderDetails?.deliveryDate)!)
                                        let deliveryDate = Date(timeIntervalSince1970: timeInterval)
                                        cell?.textLabel.text = "\(deliveryDate)"
                                    } else {
                                        
                                        cell?.textLabel.text = "notFound".localized()
                                    }
                                }else  {
                                    
                                    cell?.titleLable.text = "individual count".localized()
                                    if let individualsCount = orderDetails?.id {
                                        cell?.textLabel.text = "\(individualsCount)"
                                    }
                                    
                                }
                            } else {
                                
                            }
                        } else if orderDetails?.cooker.type == "HOME_COOKER" {
                            if indexPath.row == 0 {
                                cell?.titleLable.text = "Order number".localized()
                                if let id = orderDetails?.id {
                                    cell?.textLabel.text = "\(id)"
                                }
                            }
                            if indexPath.row == 2 {
                                cell?.titleLable.text = "Delivery Place".localized()
                                if let id = orderDetails?.deliveryPlace.name {
                                    cell?.textLabel.text = "\(id)"
                                }
                            }
                            if indexPath.row == 3 {
                                cell?.titleLable.text = "Delivery Date".localized()
                                if let id = orderDetails?.deliveryDate {
//                                    let date = Date.init(timeIntervalSince1970: TimeInterval(id) )
//                                    let dateformatter = DateFormatter()
//                                    dateformatter.dateStyle = DateFormatter.Style.long
//                                    dateformatter.timeStyle = DateFormatter.Style.none
//                                    let now = dateformatter.string(from: date)
//
                                    
                                    
                                    
                                    
                                    let date = Date(timeIntervalSince1970: Double((orderDetails?.deliveryDate)!))
                                    let dayTimePeriodFormatter = DateFormatter()
                                    dayTimePeriodFormatter.dateFormat = "dd MMM "
                                    
                                    dayTimePeriodFormatter.locale = Locale.init(identifier: Localize.currentLanguage())
                                    let dateString = dayTimePeriodFormatter.string(from: date)
                                    
                                   
                                    
                                    cell?.textLabel.text = "\(dateString)"
                                }
                            }
                            if indexPath.row == 4 {
                                if let id = orderDetails?.deliveryDate {
                                    cell?.titleLable.text = "Delivery Time".localized()
                                    let date = Date.init(timeIntervalSince1970: TimeInterval(id) )
                                    let dateformatter = DateFormatter()
                                    dateformatter.dateFormat = " hh:mm a"
                                    dateformatter.dateStyle = DateFormatter.Style.none
                                    dateformatter.timeStyle = DateFormatter.Style.medium
                                    let now = dateformatter.string(from: date)
                                    cell?.textLabel.text = "\(now)"
                                }
                               
                            }
                                
                            else if indexPath.row == 1
                            {
                                if self.orderDetails?.cooker != nil {
                                    cell?.titleLable.text = "HomeCooker".localized()
                                    cell?.textLabel.text = orderDetails?.cooker.name
                                } else  {
                                    cell?.titleLable.text = "delivery Guy".localized()
                                    cell?.textLabel.text = orderDetails?.deliveryGuy.name
                                }
                                
                            }
                        } else  {
                             // food car
                            if indexPath.row == 0 {
                                cell?.titleLable.text = "Order number".localized()
                                if let id = orderDetails?.id {
                                    cell?.textLabel.text = "\(id)"
                                }
                            }
                            if indexPath.row == 2 {
                                cell?.titleLable.text = "Delivery Place".localized()
                                if let id = orderDetails?.deliveryPlace {
                                    cell?.textLabel.text = "\(id)"
                                }
                            }
                            if indexPath.row == 3 {
                                cell?.titleLable.text = "Delivery Date".localized()
                                if let id = orderDetails?.deliveryDate {
                                    cell?.textLabel.text = "\(id)"
                                }
                            }
                            if indexPath.row == 4 {
//                                cell?.titleLable.text = "Delivery Time".localized()
//                                if let id = orderDetails?.deliveryGuy. {
//                                    cell?.textLabel.text = "\(id)"
//                                }
                            }
                            else if indexPath.row == 1
                            {
                                if self.orderDetails?.cooker != nil {
                                    cell?.titleLable.text = "HomeCooker".localized()
                                    cell?.textLabel.text = orderDetails?.cooker.name
                                } else {
                                    cell?.titleLable.text = "delivery Guy".localized()
                                    cell?.textLabel.text = orderDetails?.deliveryGuy.name
                                }
                                
                            
                        }
                            }
                     } else {
                            
                        }
                    
                        
                    
                } else if indexPath.section == 2
                {
                    let cell = cell as? TotalPriceCell
                    cell?.titleLable.text = "totalPrice".localized()
                    
                    if let totalPrice = orderDetails?.totalPrice {
                        cell?.textLabel.text = "\(totalPrice)" + " " + defaultsKey.sr.rawValue.localized()

                    }
                }
                else if indexPath.section == 3
                {
                    switch orderDetails?.status
                    {
                        
                         case OrderStatus.accepted.rawValue?:
                            let cell = cell as? ButtonCollectionViewCell
                            cell?.button.layer.cornerRadius = 0
                            cell?.button.backgroundColor = .appGreenColor()
                            cell?.button.addTarget(self, action: #selector(updateOrderStatus), for: .touchUpInside)
                            cell?.button.setTitle("Finish Cooking".localized(), for: .normal)

                        case OrderStatus.delivered.rawValue?:
                            let cell = cell as? LabelCollectionViewCell
                            cell?.label.text = "OrderDeliverd".localized()
                            
                        case OrderStatus.finished.rawValue?:
                            let cell = cell as? DetailesMapCell
//                            cell?.label.text = "Cooking Finished".localized()
                              cell?.orderdetailes = orderDetails!
                               cell?.parentviewcontroller = self
                        case OrderStatus.pending.rawValue?:
                            let cell = cell as? ButtonCollectionViewCell
                            
                            cell?.button.layer.cornerRadius = 0

                            if indexPath.row == 0 {
                                cell?.button.addTarget(self, action: #selector(updateOrderStatus), for: .touchUpInside)
                                cell?.button.backgroundColor = .appGreenColor()
                                cell?.backgroundColor = .appGreenColor()
                                cell?.button.setTitle("Accept".localized(), for: .normal)
                                cell?.button.tag = 0

                            } else {
                                cell?.button.addTarget(self, action: #selector(updateOrderStatus), for: .touchUpInside)
                                cell?.button.backgroundColor = UIColor.refusedColor()
                                cell?.backgroundColor = UIColor.refusedColor()
                                cell?.button.setTitle("Refused".localized(), for: .normal)
                                cell?.button.tag = 1

                            }
                        
                       case OrderStatus.arrived.rawValue?:
                           let cell = cell as? ButtonCollectionViewCell
                            cell?.button.layer.cornerRadius = 0
                            cell?.button.addTarget(self, action: #selector(updateOrderStatus), for: .touchUpInside)
                            cell?.button.backgroundColor = UIColor.arrived()
                            cell?.button.setTitleColor(.white, for: .normal)
                           
                            cell?.button.setTitle("FINISHED".localized(), for: .normal)
                            cell?.button.tag = 0
                        case OrderStatus.refused.rawValue?:
                            let cell = cell as? LabelCollectionViewCell
                            cell?.label.text = "Order Refused".localized()

                        default:
                            print("undefined Status")
                    }
                    
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.section == 3 {
            switch orderDetails?.status {

                case OrderStatus.pending.rawValue?:
                    if indexPath.row == 0 {
                        self.status = OrderStatus.accepted.rawValue
                        updateOrderStatus(nil)

                    } else {
                        self.status = OrderStatus.refused.rawValue
                        updateOrderStatus(nil)

                }
                
            case OrderStatus.arrived.rawValue?:
                 updateOrderStatus(nil)
                default:
                print("undefined status")
            }
            
        }
    }
}
extension OrderDetailsVC {
    
    @objc func updateOrderStatus(_ sender: UIButton?) {
        switch orderDetails?.status {
        case OrderStatus.accepted.rawValue?:
                self.status = OrderStatus.finished.rawValue
        case OrderStatus.pending.rawValue?:
                if sender?.tag == 0 {
                    self.status = OrderStatus.accepted.rawValue

                } else if sender?.tag == 1 {
                    self.status = OrderStatus.refused.rawValue
                }
        case OrderStatus.arrived.rawValue?:
             self.status = OrderStatus.finished.rawValue
            
            default:
            print("undefined status")
        }
        updateOrder()
        
    }
    
    func updateOrder() {

        var cookerType:String = ""
        print("cooker is \(self.orderDetails?.kind!)")
       
         // order is cooker
         if orderDetails?.cooker != nil {
            // get cooker type :- home  cooker , party cooker , food car
            if orderDetails?.cooker.type != nil {
                 cookerType = CookerType.checkType(userType: (orderDetails?.cooker.type)!)
             }
            myLoader.showCustomLoaderview(uiview: self.view)
            orderRepo.updateOrderStatus(cookerType: cookerType, orderId: (self.orderDetails?.id)!, stauts: self.status , userId:(self.orderDetails?.cooker.id)!, onSuccess: { (statusCode) in
                switch statusCode {
                case StatusCode.undocumented.rawValue:
                    Loader.hideLoader()
                    DataUtlis.data.SuccessDialog(Title: "Success".localized(), Body: "Order Status Changed".localized())
                    self.orderDetails?.status = self.status
                    self.collectionView.reloadData()
                    
                    
                default:
                    myLoader.hideCustomLoader()
                  
                }
            }) { (errorResponse, statusCode) in
                Loader.hideLoader()
                if let errorMessage = errorResponse?.error[0].msg {
                    DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage)
                }
            }
           
         } else if orderDetails?.deliveryGuy != nil{
            // order is delivery guy
            
           myLoader.showCustomLoaderview(uiview: self.view)
            orderRepo.updateOrderStatus(cookerType: "delivery-guys", orderId: (self.orderDetails?.id)!, stauts: self.status , userId:(self.orderDetails?.cooker.id)!, onSuccess: { (statusCode) in
                switch statusCode {
                case StatusCode.undocumented.rawValue:
                    Loader.hideLoader()
                    DataUtlis.data.SuccessDialog(Title: "Success".localized(), Body: "Order Status Changed".localized())
                    self.orderDetails?.status = self.status
                    self.collectionView.reloadData()
                    
                    
                default:
                     myLoader.hideCustomLoader()
                    
                }
            }) { (errorResponse, statusCode) in
                Loader.hideLoader()
                if let errorMessage = errorResponse?.error[0].msg {
                    DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage)
                }
            }
        }
        
        
       
        
    }
    
       
    
}

extension OrderDetailsVC :DeliveryGuychoose {
 
    
    
    func PushDeliveryOrderDetailes(Orderdetailes: OrderData, deliveryguy: DeliveryGuyInfoRes) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let passController : DeliveryOrderDetailes = storyboard.instantiateViewController(withIdentifier: "DeliveryOrderDetailes") as! DeliveryOrderDetailes
        passController.Orderdetailes = Orderdetailes
        passController.deliveryguy = deliveryguy
        self.navigationController?.pushViewController(passController, animated: false)
    }
    
    
    
    
    
}


