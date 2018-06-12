//
//  ExtensionCallUsVC.swift
//  FoodServiceProvider
//
//  Created by Index on 2/22/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import UIKit
extension CallUsVC
{
    @objc func makePhoneCall()  {
        let url: NSURL = URL(string: self.phoneNumberLabel.text!)! as NSURL
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func addSubView() {
        self.view.addSubview(phoneIcon)
        self.view.addSubview(phoneNumberLabel)
        self.view.addSubview(callButton)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        phoneIcon.snp.makeConstraints {
            make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(self.view.snp.top).offset(70)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.5)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.12)
        }
        phoneNumberLabel.snp.makeConstraints{
            make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(phoneIcon.snp.bottom)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.5)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.1)
        }
        callButton.snp.makeConstraints{
            make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.8)
            if UIDevice.current.model == "iPad" {
                make.height.equalTo(70)
                make.top.equalTo(phoneNumberLabel.snp.bottom).offset(20)
            } else {
                make.height.equalTo(50)
                make.top.equalTo(phoneNumberLabel.snp.bottom).offset(10)
            }
            
        }
    }
}
