//
//  ProfileVc + extension.swift
//  FoodServiceClient
//
//  Created by Index PC-2 on 3/18/18.
//  Copyright © 2018 Index. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import Toucan
extension ProfileVC {
    func addSubviews()
    {
        
     adjustLayout()
        
    }
    
    
    
    func adjustLayout(){
        view.addSubview(userImage)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(phoneLabel)
        view.addSubview(locationLabel)
        view.addSubview(mapView)
        view.addSubview(EditPrifileBtn)
        
        self.EditPrifileBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.left.equalTo(self.view).offset(20)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        self.userImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.snp.top).offset(10)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(self.userImage.snp.bottom)
            make.centerX.equalTo(self.userImage)
            make.width.equalTo(300)
            
        }
        
        self.emailLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(self.nameLabel.snp.bottom)
            make.centerX.equalTo(self.nameLabel)
            make.width.equalTo(300)
            
        }
        self.phoneLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(self.emailLabel.snp.bottom)
            make.centerX.equalTo(self.emailLabel)
            make.width.equalTo(300)
        }
        
        self.locationLabel.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(self.phoneLabel.snp.bottom).offset(5)
            make.centerX.equalTo(self.phoneLabel)
            make.width.equalTo(300)
        }
        
        

        self.mapView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom)
            make.top.equalTo(self.locationLabel.snp.bottom)
            make.centerX.equalTo(self.locationLabel)
            make.width.equalTo(self.view.snp.width)
        }


        userImage.layer.borderWidth = 0
        userImage.layer.masksToBounds = false
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        
        let url = URL(string: (Singeleton.userInfo?.profileImg)!)
        self.userImage.kf.setImage(with: url, completionHandler: {
            (image, error, cacheType, imageUrl) in
             self.userImage.image =  image?.circle
        })

        self.nameLabel.text = Singeleton.userName
        self.emailLabel.text =  Singeleton.userEmail
        self.phoneLabel.text = Singeleton.userPhone
        self.locationLabel.text = Singeleton.userInfo?.address
        self.setMap(For: (Singeleton.userInfo?.location.lat)!, long:  (Singeleton.userInfo?.location.lng)!, name: (Singeleton.userInfo?.name)!)
        
    }
    
}
