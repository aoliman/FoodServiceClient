//
//  LabelCollectionViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 2/25/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    
    var didSetupConstraints = false
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .appGreenColor()
        label.textAlignment = .center
        label.sizeToFit()
        label.contentMode = .scaleToFill
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = UIColor.appGreenColor().withAlphaComponent(0.1)
        
        return label
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        addViews()
        setNeedsUpdateConstraints()
        updateViewConstraints()
    }
    
    func addViews()
    {
        addSubview(label)
    }
    
    func updateViewConstraints()
    {
        label.snp.makeConstraints {
            make in
            make.center.equalTo(self.snp.center)
            make.height.equalTo(50)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

