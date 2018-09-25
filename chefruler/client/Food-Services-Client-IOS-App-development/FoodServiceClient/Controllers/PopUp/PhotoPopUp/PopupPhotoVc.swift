//
//  PopupOpenPhotoCameraViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 12/18/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import PopupDialog

class PopupPhotoVc: UIViewController
{
    
    var didSetupConstraints = false
    
    weak var delegate: PhotosDelegate?
    
    func passDataBackwards()
    {
        delegate?.didFinishPicking(with: arrayOfPhotos)
    }
    
    var arrayOfPhotos = [Data]()
    {
        didSet {
            passDataBackwards() //send data to used view controller
        }

    }

    var photosArray = [Data]()
    
    var takePhotoLabel: UILabel = {
        let label = UILabel()
        label.text = "Take Photo".localized()
        label.setAlignment()
        label.textColor = .darkGray
        label.isUserInteractionEnabled = true

        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var selectPhotoLabel: UILabel = {
        let label = UILabel()
        label.text = "Select photo from gallery".localized()
        label.setAlignment()
        label.textColor = .darkGray
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    static var popup: PopupDialog?

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        updateViewConstraints()
    
        var tap = UITapGestureRecognizer(target: self, action: #selector(openCameraAction))
        
        takePhotoLabel.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(openPhotoLibraryAction))
        selectPhotoLabel.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

protocol PhotosDelegate :class{
    func didFinishPicking(with data: [Data])
}

