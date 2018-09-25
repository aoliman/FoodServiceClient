//
//
////
////  NotificationViewController.swift
////  FoodServiceProvider
////
////  Created by Index on 2/19/18.
////  Copyright © 2018 index-pc. All rights reserved.
////
//
//import UIKit
//
//private let notificationCellIdentifier = "notificationCellIdentifier"
//
//class NotificationViewController: UIViewController {
//
//    var isNewDataLoading = false
//    var page:Int = 0
//    var totalCount: Int = 0
//
//    var collectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
//
//    var notifications: UserNotificationResponseApi?
//    let orderrepo = OrderRepository()
//    lazy var notificationRepo = NotificationRepo()
//    let userType = UserDefaults.standard.string(forKey: defaultsKey.userType.rawValue)
//
//    lazy var Control: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(NotificationViewController.finishRefresh), for: UIControlEvents.valueChanged)
//        return refreshControl
//    }()
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        AppUtility.lockOrientation(.portrait)
//        // Or to rotate and lock
//        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.setupView()
//        self.getNotification()
//
//        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//
//        view.addSubview(collectionView)
//
//        collectionView.delegate = self
//        collectionView.dataSource = self
//
//        if #available(iOS 10.0, *) {
//            collectionView.refreshControl = Control
//        } else {
//            // Fallback on earlier versions
//        }
//        Control.tintColor = UIColor.appColor()
//
//        self.collectionView.register(NotificationCell.self, forCellWithReuseIdentifier: notificationCellIdentifier)
//
//        collectionView.snp.makeConstraints {
//            make in
//            make.left.equalTo(self.view.snp.left)
//            make.right.equalTo(self.view.snp.right)
//            make.top.equalTo(self.view.snp.top)
//            make.bottom.equalTo(self.view.snp.bottom)
//        }
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    @objc func finishRefresh(){
//        var isNewDataLoading = false
//        var page:Int = 0
//        var totalCount: Int = 0
//        notifications = nil
//        self.Control.endRefreshing()
//
//        self.getNotification()
//
//    }
//
//}
//
//extension NotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.notifications?.data.count != nil ? (self.notifications?.data.count)! : 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(10, 0, 0, 0)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let  width  = Double(UIScreen.main.bounds.width)
//        return CGSize.init(width: width - 20 , height: 100)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: notificationCellIdentifier, for: indexPath)
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//        let cell = cell as? NotificationCell
//
//        if (self.notifications?.data[indexPath.row].seen)! {
//            cell?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            cell?.dateLabel.isHidden = false
//            cell?.clockIcon.isHidden = false
//        } else {
//            cell?.backgroundColor = #colorLiteral(red: 0.9607002139, green: 0.9608381391, blue: 0.9606701732, alpha: 1)
//            cell?.newLabel.isHidden = false
//        }
//
//        let notify = self.notifications?.data[indexPath.row]
//        cell?.nameLabel.text = notify?.fromUser.name
//        cell?.imageView.getUserImageType(type: (notify?.fromUser.type)!, status: (notify?.subject.status)!)
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        let localDate = formatter.date(from: (notify?.creationDate)!)
//        cell?.dateLabel.text = localDate?.getTimeFromString()
//        cell?.detailsLabel.text = notify?.text
//        if cell?.dateLabel.text?.guessLanguage() == "العربية" { cell?.dateLabel.textAlignment = .right } else { cell?.dateLabel.textAlignment = .left }
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let id = (notifications?.data[indexPath.row].id)!
//        updateNotificationSeen(id: id, indexPath: indexPath)
//
//        if let id = notifications?.data[indexPath.row].subject.id {
//            self.collectionView.reloadItems(at: [indexPath])
//
//    // have id and get order
//            myLoader.showCustomLoaderview(uiview: self.view)
//            orderrepo.getSingleOrder(orderId:id , stauts: "", userId: (Singeleton.userInfo?.id)!, onSuccess: { (response)  in
//
//                if (response.kind == "delivery-guy-order" && response.status == OrderStatus.ontheWay.rawValue) {
//
//                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let Orderdetailescontroller : TrackDelivery = storyboard.instantiateViewController(withIdentifier: "TrackDelivery") as! TrackDelivery
//                    Orderdetailescontroller.orderItem = response
//
//                    self.navigationController?.pushViewController(Orderdetailescontroller, animated: false)
//
//                }else{
//                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let Orderdetailescontroller : OrderDetailesSatuse = storyboard.instantiateViewController(withIdentifier: "OrderDetailesSatuse") as! OrderDetailesSatuse
//                  //  Orderdetailescontroller.title = ""
//                    Orderdetailescontroller.orderItem = response
//
//                    self.navigationController?.pushViewController(Orderdetailescontroller, animated: false)
//                }
//
//                myLoader.hideCustomLoader()
//
//
//
//
//            }, onFailure: { (error, statuscode) in
//                DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
//            })
//
//
//
//
//
//        }
//
//
//        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//            if self.notifications?.data.count != totalCount {
//
//                if scrollView == collectionView {
//
//                    if ((scrollView.contentOffset.y + scrollView.frame.size.height)-10 >= scrollView.contentSize.height) {
//
//                        if !isNewDataLoading {
//                            self.getNotification()
//                            isNewDataLoading = true
//                        }
//                        isNewDataLoading = false
//                    }
//                }
//            }
//
//        }
//
//
//    }
//
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//
//        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
//            return
//        }
//
//        flowLayout.invalidateLayout()
//    }
//
//}
//
//extension NotificationViewController {
//
//    func getNotification() {
//        if notifications != nil {
//            if self.page ==  notifications?.pageCount {
//                self.page = (notifications?.pageCount)!
//            } else {
//                self.page += 1
//            }
//        } else {
//            self.page += 1
//        }
//
//      myLoader.showCustomLoaderview(uiview: self.view)
//
//        notificationRepo.getNotification(page: page, limit:10) { (notification, statusCode) in
//            myLoader.hideCustomLoader()
//            switch statusCode {
//            case StatusCode.complete.rawValue :
//                 self.notifications = notification
//                 self.totalCount = notification.totalCount
//                if (self.notifications?.data.count)! > 0 {
//                    self.removeNothingLabel()
//                    self.collectionView.isHidden = false
//                    self.collectionView.reloadData()
//                } else {
//                    self.collectionView.isHidden = true
//                    self.addNothingAvailableLabel()
//                    UIViewController.nothingLabel.text = "Notification empty".localized()
//                }
//
//            case StatusCode.badRequest.rawValue:
//                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "badRequest")
//
//            case StatusCode.unauthorized.rawValue:
//                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "unauthenticated")
//
//            case StatusCode.forbidden.rawValue:
//                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "forbidden")
//
//            case StatusCode.notFound.rawValue:
//                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "not Found")
//
//            case StatusCode.unprocessableEntity.rawValue:
//                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "un processable Entity")
//
//            case StatusCode.serverError.rawValue :
//                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "ServrError".localized())
//
//            default:
//                DataUtlis.data.noInternetDialog()
//
//            }
//        }
//    }
//
//    func updateNotificationSeen(id: Int, indexPath: IndexPath) {
//
//        notificationRepo.updateSeenNotification(id: id) { statusCode in
//
//            if statusCode == StatusCode.complete.rawValue {
//             let cell = self.collectionView.cellForItem(at: indexPath)
//                cell?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            }
//
//
//        }
//    }
//
//}
//
//
//
//
//

//
//  NotificationViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 2/19/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit

private let notificationCellIdentifier = "notificationCellIdentifier"

class NotificationViewController: UIViewController {
    
    
    
   
        let orderrepo = OrderRepository()
       lazy var notificationRepo = NotificationRepo()
    
    
    
    
    
    var collectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
    
    var notifications: UserNotificationResponseApi?
    var isNewDataLoading = false
    var page:Int = 0
    var totalCount: Int = 0
    
    
    
    var isCalled: Bool = false
    
    
    let userType = UserDefaults.standard.string(forKey: defaultsKey.userType.rawValue)
    
    lazy var Control: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NotificationViewController.finishRefresh), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = Control
        } else {
            collectionView.addSubview(Control)
            // Fallback on earlier versions
        }
        Control.tintColor = UIColor.appColor()
        
        self.collectionView.register(NotificationCell.self, forCellWithReuseIdentifier: notificationCellIdentifier)
        
        collectionView.snp.makeConstraints {
            make in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.notifications = nil
        self.page = 0
        self.getNotification(20)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func finishRefresh(){
        self.Control.endRefreshing()
        self.page = 0
        self.totalCount = 0
        self.notifications = nil
        self.isNewDataLoading = false
        self.getNotification(20)
        
    }
    
}

extension NotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.notifications != nil ? (self.notifications?.data.count)! : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 0, 0, 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let  width  = Double(UIScreen.main.bounds.width)
        return CGSize.init(width: width - 20 , height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: notificationCellIdentifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cell = cell as? NotificationCell
        if self.notifications != nil {
        if (self.notifications?.data[indexPath.row].seen)! {
            cell?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cell?.dateLabel.isHidden = false
            cell?.clockIcon.isHidden = false
        } else {
            cell?.backgroundColor = #colorLiteral(red: 0.9607002139, green: 0.9608381391, blue: 0.9606701732, alpha: 1)
            cell?.newLabel.isHidden = false
        }
        
        let notify = self.notifications?.data[indexPath.row]
        cell?.nameLabel.text = notify?.fromUser.name
        if notify?.fromUser.type != UserType.client.rawValue {
            cell?.imageView.getUserImageType(type: (notify?.fromUser.type)!, status: (notify?.subject.status)!)
        } else {
            
            if let profileImg =  notify?.fromUser.profileImg {
                
                let url = URL(string: (profileImg))
                cell?.imageView.kf.setImage(with: url, completionHandler: {
                    
                    (image, error, cacheType, imageUrl) in
                    if image != nil {
                        cell?.imageView.image =  image!
                    }
                    else {
                        cell?.imageView.image = #imageLiteral(resourceName: "profile")
                    }
                })
            } else {
                cell?.imageView.image = #imageLiteral(resourceName: "profile")
            }
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let localDate = formatter.date(from: (notify?.creationDate)!)
        cell?.dateLabel.text = localDate?.getTimeFromString()
        cell?.detailsLabel.text = notify?.text
        if cell?.dateLabel.text?.guessLanguage() == "العربية" { cell?.dateLabel.textAlignment = .right } else { cell?.dateLabel.textAlignment = .left }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = (notifications?.data[indexPath.row].id)!
        
        updateNotificationSeen(id: id, indexPath: indexPath)
        
        if let id = notifications?.data[indexPath.row].subject.id {
                        self.collectionView.reloadItems(at: [indexPath])
            
                // have id and get order
                        myLoader.showCustomLoaderview(uiview: self.view)
                        orderrepo.getSingleOrder(orderId:id , stauts: "", userId: (Singeleton.userInfo?.id)!, onSuccess: { (response)  in
            
                            if (response.kind == "delivery-guy-order" && response.status == OrderStatus.ontheWay.rawValue) {
            
                                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let Orderdetailescontroller : TrackDelivery = storyboard.instantiateViewController(withIdentifier: "TrackDelivery") as! TrackDelivery
                                Orderdetailescontroller.orderItem = response
            
                                self.navigationController?.pushViewController(Orderdetailescontroller, animated: false)
            
                            }else{
                                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let Orderdetailescontroller : OrderDetailesSatuse = storyboard.instantiateViewController(withIdentifier: "OrderDetailesSatuse") as! OrderDetailesSatuse
                              //  Orderdetailescontroller.title = ""
                                Orderdetailescontroller.orderItem = response
            
                                self.navigationController?.pushViewController(Orderdetailescontroller, animated: false)
                            }
            
                            myLoader.hideCustomLoader()
            
            
            
            
                        }, onFailure: { (error, statuscode) in
                            DataUtlis.data.WarningDialog(Title: "FailedTitle".localized(), Body: "NoInternet".localized())
                        })
        }
            
            
            
            
        
        
        
//        if notifications?.data[indexPath.row].fromUser.type == UserType.client.rawValue {
//
//            if let id = notifications?.data[indexPath.row].subject.id {
//
//                switch userType {
//
//                case UserType.foodCars.rawValue?:
//                    getFoodCarOrderDetails(id)
//
//                case UserType.houseCook.rawValue?:
//                    getHomeOrderDetails(id)
//
//                case UserType.partyCooks.rawValue?:
//                    getPartyOrderDetails(id)
//
//                case UserType.restaurantOwner.rawValue?:
//                    getRestaurantOrderDetails(id)
//
//                case UserType.driverPartner.rawValue?:
//                    getDeliveryGuyOrderDetails(id)
//
//                default:
//                    print("")
//                }
//            }
//        }
        
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        flowLayout.invalidateLayout()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if self.notifications?.data.count != totalCount {
            
            if scrollView == collectionView {
                
                if ((scrollView.contentOffset.y + scrollView.frame.size.height)-10 >= scrollView.contentSize.height) {
                    
                    if !isNewDataLoading {
                        self.getNotification(10)
                        isNewDataLoading = true
                    }
                    isNewDataLoading = false
                }
            }
        }
        
    }
    
}

extension NotificationViewController {
    
    func getNotification(_ limit: Int) {
        
        if notifications != nil {
            if self.page ==  notifications?.pageCount {
                self.page = (notifications?.pageCount)!
            } else {
                self.page += 1
            }
        } else {
            self.page += 1
        }
        
        myLoader.showCustomLoaderview(uiview: self.view)
        
        notificationRepo.getNotification(page: self.page, limit: 5) { (notification, statusCode) in
            myLoader.hideCustomLoader()
            switch statusCode {
            case StatusCode.complete.rawValue :
                
                
                
           
                
                self.totalCount = notification.totalCount
                
                if notification.data.count == 0 {
                    
                    self.collectionView.isHidden = true
                    self.addNothingAvailableLabel()
                    UIViewController.nothingLabel.text = "Notification empty".localized()
                    
                } else {
                    
                    UIViewController.nothingLabel.removeFromSuperview()
                    
                    
                    
                    if notification.totalCount != self.notifications?.data.count {
                        
                        if self.notifications ==  nil {
                            self.notifications = notification
                            
                        } else {
                            
                          self.notifications?.data.append(contentsOf: notification.data)
                         }
                        
                        
                        
                        
                        self.collectionView.reloadData()
                    }
                }
                
                
            case StatusCode.badRequest.rawValue:
                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "badRequest")
                
            case StatusCode.unauthorized.rawValue:
                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "unauthenticated")
                
            case StatusCode.forbidden.rawValue:
                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "forbidden")
                
            case StatusCode.notFound.rawValue:
                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "not Found")
                
            case StatusCode.unprocessableEntity.rawValue:
                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "un processable Entity")
                
            case StatusCode.serverError.rawValue :
                DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "ServrError".localized())
                
            default:
                DataUtlis.data.noInternetDialog()
                
            }
        }
    }
    
    func updateNotificationSeen(id: Int, indexPath: IndexPath) {
        //        Loader.show(view: self.view)
        notificationRepo.updateSeenNotification(id: id) { statusCode in
            //            Loader.hideLoader()
            if statusCode == StatusCode.complete.rawValue {
                let cell = self.collectionView.cellForItem(at: indexPath)
                cell?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.collectionView.reloadItems(at: [indexPath])
            }
            
            
        }
    }
}

