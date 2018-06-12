//
//  ImageCollectionViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 12/18/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift
import Foundation

class ImageCollectionViewCell: UICollectionViewCell
{
    var didSetupConstraints = false
    
    weak var delegate: RemoveImageDelegate?
    
   lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        //imageView.masks = true
        return imageView
    }()
    let closeButton: UIButton = {
        
        let button = UIButton()
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 26)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.titleLabel?.setAlignment()
        button.setTitle(String.fontAwesomeIcon(code: "fa-close"), for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        addViews()
        setNeedsUpdateConstraints()
        updateViewConstraints()
        self.closeButton.addTarget(self, action: #selector(removePhotoAction), for: .touchUpInside)
        
    }
    
    func customizeCellView()
    {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    
    func addViews()
    {
        addSubview(imageView)
        addSubview(closeButton)
    }
    
    func updateViewConstraints()
    {
        imageView.snp.makeConstraints
            {
                make in
                make.left.equalTo(self.snp.left)
                make.right.equalTo(self.snp.right)
                make.bottom.equalTo(self.snp.bottom)
                make.top.equalTo(self.snp.top)
        }
        closeButton.snp.makeConstraints
            {
                make in
                if Localize.currentLanguage() == "en"
                {
                    make.left.equalTo(imageView.snp.left).offset(15)
                }
                else
                {
                    make.right.equalTo(imageView.snp.right).offset(-15)
                }
                make.width.equalTo(30)
                make.height.equalTo(30)
                make.top.equalTo(imageView.snp.top).offset(15)
                
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func removePhotoAction(){
        if let delegate = self.delegate {
            delegate.removeImage(cell: self)
        }
    }
}

protocol RemoveImageDelegate:class {
    func removeImage(cell: ImageCollectionViewCell)
}

