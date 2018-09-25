//
//  ChatNavigationBarItem.swift
//  FoodServiceProvider
//
//  Created by Index on 1/9/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift

class ChatNavigationBarItem: UIView {
    
    var didSetupConstraints = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        updateViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.setAlignment()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
        
    }()
    
    var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    func addSubviews() {
        self.addSubview(nameLabel)
        self.addSubview(userImage)
    }
    
    func updateViewConstraints() {
        
        if (!didSetupConstraints) {

            userImage.snp.remakeConstraints {
                make in
                if UIDevice.current.model == "iPad" {
                    make.width.equalTo(self.snp.width).multipliedBy(0.07)
                    if Localize.currentLanguage() == "ar" {
                        make.right.equalTo(self.snp.right)
                    } else {
                        make.left.equalTo(self.snp.left)
                    }
                } else {
                    make.width.equalTo(self.snp.width).multipliedBy(0.2)
                    if Localize.currentLanguage() == "ar" {
                        make.right.equalTo(self.snp.right).offset(15)
                    } else {
                        make.left.equalTo(self.snp.left).offset(-15)
                    }
                }
                make.centerY.equalTo(self.snp.centerY)
                make.height.equalTo(35)
            }
            nameLabel.snp.remakeConstraints {
                make in
                if Localize.currentLanguage() == "ar" {
                    make.right.equalTo(userImage.snp.left)
                } else {
                    make.left.equalTo(userImage.snp.right)
                }
                make.centerY.equalTo(userImage.snp.centerY)
                
                if UIDevice.current.model == "iPad" {
                    make.width.equalTo(self.snp.width).multipliedBy(0.25)

                } else {
                    make.width.equalTo(self.snp.width).multipliedBy(0.3)
                }
                make.height.equalTo(30)
            }
           
        }
    }
    
}
