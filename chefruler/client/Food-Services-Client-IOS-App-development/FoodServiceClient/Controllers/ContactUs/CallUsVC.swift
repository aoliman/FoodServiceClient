//
//  CallUsVC.swift
//  FoodServiceProvider
//
//  Created by Index on 2/22/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import SwiftIcons

class CallUsVC: UIViewController {
    
    var didSetupConstraints = false
    
    var phoneIcon: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGrayApp()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.setIcon(icon: .googleMaterialDesign(.phoneIphone), iconSize: 70,color: .lightGrayApp(), bgColor: .clear)
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.deliveredColor().withAlphaComponent(0.5)
        label.textAlignment = .center
        label.sizeToFit()
        label.text = "+966564486115"
        label.contentMode = .scaleToFill

        return label
        
    }()
    
   
    var callButton: UIButton = {
        let button = UIButton.appButton()
        button.setTitle("CallNow".localized(), for: .normal)
        button.backgroundColor = UIColor.navigationBarColor()
        //button. = 3
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        addSubView()
        callButton.addTarget(self, action: #selector(makePhoneCall), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
