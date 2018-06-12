//
//  SettingCollectionReusableView.swift
//  FoodServiceProvider
//
//  Created by Index on 2/24/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit

class SettingCollectionReusableView: UICollectionReusableView {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFontRegular(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
//        label.backgroundColor = #colorLiteral(red: 0.9146607518, green: 0.9096613526, blue: 0.9139177203, alpha: 1)
        label.setAlignment()
        label.sizeToFit()
        
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.snp.makeConstraints {
            make in
            make.height.equalTo(30)
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-10)
            make.left.equalTo(self.snp.left).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
