//
//  StatusButtonCollectionViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 2/20/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit

class StatusCell: UICollectionViewCell {
    var didSetupConstraints = false
    
    var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
       
        button.attributedTitle(for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners:[.bottomRight, .bottomLeft], cornerRadii: CGSize.init(width: 10.0, height: 10.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        addViews()
        setNeedsUpdateConstraints()
        updateViewConstraints()
    }
    
    func addViews()
    {
        addSubview(button)
    }
    
    func updateViewConstraints()
    {
        button.snp.makeConstraints
        {
            make in
            make.center.equalTo(self.snp.center)
            make.height.equalTo(60)
            make.width.equalTo(self.snp.width).multipliedBy(0.6)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
