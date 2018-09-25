//
//  CookerOrdersViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 2/20/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import DropDown
import Material
private let orderCellIdentifier = "OrderCellIdentifier"
private let buttonCellIdentifier = "ButtonCellIdentifier"
private let sectionHeader = "sectionHeader"

class MyOrdersVC: UIViewController {
    
    var didSetupConstraints = false
    
    let textAttr = [NSAttributedStringKey.font : UIFont.appFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.navigationBarColor()]
    let iconAttr = [NSAttributedStringKey.font : UIFont.fontAwesome(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.navigationBarColor()]
    
    var statusButton: Button = {
        let button = Button()
        button.titleLabel?.textAlignment = .center
        button.borderColor = UIColor.navigationBarColor()
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.navigationBarColor(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var orderStatusDropdown: DropDown = {
        let dropDown = DropDown()
        dropDown.backgroundColor = .white
        dropDown.direction = .bottom
        dropDown.separatorColor = UIColor.gray
        dropDown.selectionBackgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 244/255, alpha: 1)
        dropDown.textColor = .darkGray
        dropDown.layer.cornerRadius = 5
        
        return dropDown
    }()
    
    var collectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var orderRepo = OrderRepository()
    var orderItems = [OrderData]()
    var reponseOrder:OrderResponseApi?
    var isNewDataLoading = false
    var page:Int = 0
    var totalCount: Int = 0 //total count for api items
    var status: String? //required if filter used
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .white
        self.collectionView.register(OrderCell.self, forCellWithReuseIdentifier: orderCellIdentifier)
        self.collectionView.register(StatusCell.self, forCellWithReuseIdentifier: buttonCellIdentifier)
        collectionView.reloadData()
        setAttributedButtonTitle()
        self.setupNavigationBar()
        addViews()
        dropDownSetup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        orderItems.removeAll()
        self.status = ""
        page = 1
        getOrders(limit: 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension MyOrdersVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return orderItems.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 2
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
        return UIEdgeInsetsMake(5, 10, 5, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var  width  = Double(UIScreen.main.bounds.width)
        width =  (width - 20)
        if indexPath.row == 0
        {
            return CGSize.init(width: width, height: 150)
            
        }
        else
        {
            return CGSize.init(width: width , height: 50)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if indexPath.row == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: orderCellIdentifier, for: indexPath)
            
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonCellIdentifier, for: indexPath)
            
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        let orderItem = self.orderItems[indexPath.section]
        if self.orderItems.count > 0
        {
            
            if indexPath.row == 0
            {
                let cell = cell as? OrderCell
           //     cell?.clientName.text = orderItem.cooker.name
                if orderItem.cooker != nil {
                    cell?.clientName.text = orderItem.cooker.name
                } else if orderItem.deliveryGuy != nil{
                     cell?.clientName.text = orderItem.deliveryGuy.name
                }
                if let price = orderItem.totalPrice {
                cell?.price.text = String(price) + defaultsKey.sr.rawValue.localized()
                }
                let nativeDateString = orderItem.creationDate!.components(separatedBy: "T")
                let normalizDate = Date().offset(from: Date().getDateFromString(dateString: nativeDateString[0]))
                
                cell?.dateLabel.text = normalizDate
                cell?.orderNumber.text = String(orderItem.id)
            }
            else
            {
                let cell = cell as? StatusCell
                let textAttr = [NSAttributedStringKey.font : UIFont.appFont(ofSize: 18), NSAttributedStringKey.foregroundColor: UIColor.white]
                let iconAttr = [NSAttributedStringKey.font : UIFont.fontAwesome(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.white]
                let attrText = NSMutableAttributedString(string: orderItem.status.localized() + " ", attributes: textAttr )
                
                switch orderItem.status
                {
                case OrderStatus.accepted.rawValue:
                    let icon = NSMutableAttributedString(string: String.fontAwesomeIcon(code:"fa-thumbs-up")!, attributes:iconAttr)
                   // attrText.append(icon)
                    cell?.button.setAttributedTitle(attrText, for: .normal)
                    cell?.backgroundColor = UIColor.finishedColor()
                    
                case OrderStatus.delivered.rawValue:
                    let icon = NSMutableAttributedString(string: String.fontAwesomeIcon(code:"fa-thumbs-up")!, attributes:iconAttr)
//                    attrText.append(icon)
                    cell?.button.setAttributedTitle(attrText, for: .normal)
                    cell?.backgroundColor = UIColor.deliveredColor()
                    
                case OrderStatus.finished.rawValue:
                    let icon = NSMutableAttributedString(string: "", attributes:iconAttr)
//                   attrText.append(icon)
                    cell?.button.setAttributedTitle(attrText, for: .normal)
                    cell?.backgroundColor = UIColor.finishedColor()
                    
                case OrderStatus.pending.rawValue:
                   let icon = NSMutableAttributedString(string: String.fontAwesomeIcon(code:"fa-info")!, attributes:iconAttr)
//                    attrText.append(icon)
                    cell?.button.setAttributedTitle(attrText, for: .normal)
                    cell?.backgroundColor = UIColor.pending()
                    
                case OrderStatus.refused.rawValue:
                 let icon = NSMutableAttributedString(string: String.fontAwesomeIcon(code:"fa-thumbs-down")!, attributes:iconAttr)
//                    attrText.append(icon)
                    cell?.button.setAttributedTitle(attrText, for: .normal)
                    cell?.backgroundColor = UIColor.refusedColor()
                    
                case OrderStatus.arrived.rawValue:
                   let icon = NSMutableAttributedString(string: String.fontAwesomeIcon(code:"fa-thumbs-down")!, attributes:iconAttr)
//                    attrText.append(icon)
                    cell?.button.setAttributedTitle(attrText, for: .normal)
                    cell?.backgroundColor = UIColor.arrived()
                    
                case OrderStatus.ontheWay.rawValue:
                let icon = NSMutableAttributedString(string: String.fontAwesomeIcon(code:"fa-thumbs-down")!, attributes:iconAttr)
//                    attrText.append(icon)
                cell?.button.setAttributedTitle(attrText, for: .normal)
//
                    cell?.backgroundColor = UIColor.red
                    
                default:
                    print("Undefined Order Status")
                }
                
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let orderItem = self.orderItems[indexPath.section]
        let orderDetailsVC = OrderDetailsVC()
        orderDetailsVC.orderDetails = orderItem
        orderDetailsVC.status = status!
        
        self.navigationController?.pushViewController(orderDetailsVC, animated: true)

        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        
     if orderItems.count != totalCount
        {
            if scrollView == collectionView{
                
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

extension MyOrdersVC
{
    func getOrders(limit: Int)
    {
        //edit
        collectionView.reloadData()
        self.removeNothingLabel()
        
        self.page += 1
      // myLoader.showCustomLoaderview(uiview: self.view)
        print(self.status)
        orderRepo.getOrders(page: self.page, limit: limit, status: status, onSuccess: { (response, statusCode) in
        Loader.hideLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false

            if response.data.count == 0
                            {
                                self.collectionView.isHidden = true
                                self.statusButton.isHidden = true
                                self.addNothingAvailableLabel()
                                UIViewController.nothingLabel.text = "No Orders Available".localized()
                            }
                            else
                            {
                                self.collectionView.isHidden = false
                                self.statusButton.isHidden = false

                                self.totalCount = response.totalCount
             
                                self.orderItems.append(contentsOf: response.data)
                     
                                self.collectionView.reloadData()
                            }
        }) { (errorResponse, statusCode) in
             myLoader.hideCustomLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let errorMessage = errorResponse?.error[0].msg {
                DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage)
        }
        
        }
        
    }
}

