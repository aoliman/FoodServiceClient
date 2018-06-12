//
//  TotalPriceCollectionViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 2/7/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit

class TotalPriceCell: UICollectionViewCell
{
    var didSetupConstraints = false
    
    var titleLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.appFontBold(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.appFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func prepareForReuse()
    {
        super.prepareForReuse()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.navigationBarColor().withAlphaComponent(0.1)
        
        addViews()
        setNeedsUpdateConstraints()
        updateViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews()
    {
        addSubview(view)
        view.addSubview(textLabel)
        view.addSubview(titleLable)
    }
    
    func updateViewConstraints()
    {
        if (!didSetupConstraints)
        {
            view.snp.makeConstraints
                {
                    make in
                    make.top.equalTo(self.snp.top).offset(20)
                    make.centerX.equalTo(self.snp.centerX)
                    make.width.equalTo(self.snp.width).multipliedBy(0.8)
                    make.height.equalTo(70)
            }
            titleLable.snp.makeConstraints
                {
                    make in
                    make.top.equalTo(view.snp.top)
                    make.width.equalTo(self.snp.width).multipliedBy(0.8)
                    make.height.equalTo(30)
                    make.centerX.equalTo(view.snp.centerX)
            }
            textLabel.snp.makeConstraints
                {
                    make in
                    make.top.equalTo(titleLable.snp.bottom)
                    make.centerX.equalTo(self.snp.centerX)
                    make.width.equalTo(self.snp.width).multipliedBy(0.8)
                    make.height.equalTo(30)
            }
        }
    }
}

