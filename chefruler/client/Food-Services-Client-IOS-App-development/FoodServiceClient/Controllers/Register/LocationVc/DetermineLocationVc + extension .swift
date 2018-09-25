//
//  ddd.swift
//  FoodServiceProvider
//
//  Created by Index on 12/26/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import MapKit
import CoreLocation

extension DetermineLocationVc
{
    func addSubviews()
    {
        view.addSubview(logo)
        view.addSubview(label)
        view.addSubview(mapView)
        view.addSubview(continueRegisterButton)
        logo.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(self.view.snp.top).offset(50)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.4)
                make.centerX.equalTo(self.view.snp.centerX)
                make.height.equalTo(self.view.snp.height).multipliedBy(0.3)
        }
        label.snp.makeConstraints
            {
                (make) -> Void in
                make.top.equalTo(logo.snp.bottom)
                make.height.equalTo(40)
                make.centerX.equalTo(self.view.snp.centerX)
                make.width.equalTo(self.view.snp.width).multipliedBy(0.9)
                make.bottom.equalTo(mapView.snp.top).offset(-16)
           }
        mapView.snp.makeConstraints
            {
                make in
                make.top.equalTo(label.snp.bottom).offset(16)
                make.left.equalTo(self.view.snp.left)
                make.right.equalTo(self.view.snp.right)
                make.height.equalTo(self.view.snp.height).multipliedBy(0.35)
               // make.centerY.equalTo(self.view.snp.centerY)
        }
        continueRegisterButton.snp.makeConstraints
            {
                (make) -> Void in
               // make.height.equalTo(60)
                make.centerX.equalTo(self.view.snp.centerX)
               // make.width.equalTo(self.view.snp.width).multipliedBy(0.6)
                make.top.equalTo(mapView.snp.bottom).offset(50)
        }
    }

    
}

