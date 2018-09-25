//
//  AboutCollectionCell.swift
//  FoodServiceProvider
//
//  Created by Index on 3/17/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift
import Material

class AboutCollectionCell: UICollectionViewCell {
    
    var didSetupConstraints = false
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.setAlignment()
        label.sizeToFit()
        
        return label
        
    }()
    
    func updateViewConstraints() {
        super.layoutSubviews()
        
        label.snp.makeConstraints {
            make in
//            make.height.equalTo(30)
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right)
            make.left.equalTo(self.snp.left)
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        updateViewConstraints()
    }
    
   
    
    func addViews() {
        
     addSubview(label)
    }
    
  
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
