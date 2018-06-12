//
//  NotificationViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 2/19/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit

private let notificationCellIdentifier = "notificationCellIdentifier"

class NotificationViewController: UIViewController
{
    var collectionView: UICollectionView = UICollectionView(frame: CGRect(),collectionViewLayout: UICollectionViewFlowLayout())
    var notifications: [NotificationResponseApi] = []
    lazy var profileRepo = ProfileRespository()
    lazy var Control: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NotificationViewController.finishRefresh), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    var page: Int = 1
    var limit: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.getNotification(page:page , limit:limit)
        
        collectionView.backgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 244/255, alpha: 1)
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = Control
        } else {
            // Fallback on earlier versions
        }
        Control.tintColor = UIColor.appColor()
        
        self.collectionView.register(NotificationCollectionViewCell.self, forCellWithReuseIdentifier: notificationCellIdentifier)
        
        collectionView.snp.makeConstraints
            {
                make in
                make.left.equalTo(self.view.snp.left)
                make.right.equalTo(self.view.snp.right)
                make.top.equalTo(self.view.snp.top)
                make.bottom.equalTo(self.view.snp.bottom)
           }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getNotification(page:Int , limit:Int) {
        
        if DataUtlis.data.isInternetAvailable() {
        myLoader.showCustomLoaderview(uiview: self.view)
            UIApplication.shared.isNetworkActivityIndicatorVisible = true

        profileRepo.getNotification(page: 1, limit: 10, onSuccess: { (notifications, statusCode) in
            Loader.hideLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.notifications = notifications.data
            self.collectionView.reloadData()
        }) { (errorResponse, statusCode) in
            myLoader.hideCustomLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let errorMessage = errorResponse?.error[0].msg {
            DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage)
            }
            }
        } else {
            DataUtlis.data.noInternetDialog()
        }
    }
    @objc func finishRefresh(){
        self.Control.endRefreshing()
        self.getNotification(page: 1, limit: 10)
        
    }
    
}
extension NotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.notifications.count
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
        return UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let  width  = Double(UIScreen.main.bounds.width)
        
        return CGSize.init(width: width, height: 70)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: notificationCellIdentifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        let cell = cell as? NotificationCollectionViewCell
        cell?.addBottomBorderWithColor()
        let notify = self.notifications[indexPath.row]
        let nativeDateString = notify.creationDate!.components(separatedBy: "T")
        let normalizDate = Date().offset(from: Date().getDateFromString(dateString: nativeDateString[0]))
        


        cell?.label.text = notify.text
        cell?.label.sizeToFit()
        cell?.emotionIcon.image = #imageLiteral(resourceName: "happy_face")
        cell?.timeLabel.text = normalizDate
        //"منذ ١٣ دقيقه"
        
        if cell?.timeLabel.text?.guessLanguage() == "العربية"
        {cell?.timeLabel.textAlignment = .right}
        else{cell?.timeLabel.textAlignment = .left}
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
    }
    
}

