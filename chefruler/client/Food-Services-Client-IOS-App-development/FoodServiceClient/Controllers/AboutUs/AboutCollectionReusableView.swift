//
//  AboutCollectionReusableView.swift
//  FoodServiceProvider
//
//  Created by Index on 6/27/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift

class AboutCollectionReusableView: UICollectionReusableView {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFontRegular(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.setAlignment()
        
        return label
        
    }()
    
    let iconLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.fontAwesome(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.snp.makeConstraints {
            make in
            make.centerY.equalTo(self.snp.centerY)
            if Localize.currentLanguage() == "ar" {
                make.right.equalTo(self.snp.right).offset(-10)
            } else {
                make.left.equalTo(self.snp.left).offset(10)
            }
            make.height.equalTo(self.snp.height)
            make.width.equalTo(self.snp.width).offset(-10)
        }
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}




