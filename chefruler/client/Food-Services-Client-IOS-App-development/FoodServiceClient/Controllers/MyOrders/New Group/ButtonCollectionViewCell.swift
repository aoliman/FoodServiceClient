//
//  ButtonCollectionViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 12/16/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell
{
    var didSetupConstraints = false
    
    var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.arrived()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        
        button.titleLabel?.font = UIFont.appFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(button)
    }
    
    func updateViewConstraints()
    {
        button.snp.makeConstraints
        {
            make in
            make.center.equalTo(self.snp.center)
            make.height.equalTo(50)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
        }
       
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
