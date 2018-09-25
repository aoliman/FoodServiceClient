//
//  ExtensionContinueRegister.swift
//  FoodServiceProvider
//
//  Created by index-pc on 12/9/17.
//  Copyright © 2017 index-pc. All rights reserved.
//
import PopupDialog

extension RegisterImageVC
{
    func addSubviews()
    {
        self.view.addSubview(registerView)
        self.view.addSubview(logo)
        registerView.addSubview(titleLabel)
        registerView.addSubview(openCameraButton)
        registerView.addSubview(photosView)
        photosView.addSubview(collectionView)
        registerView.addSubview(continueRegisterButton)
    }
    
    override func updateViewConstraints()
    {
        if (!didSetupConstraints)
        {
            
            logo.snp.makeConstraints
                {
                    (make) -> Void in
                    make.top.equalTo(self.view.snp.top).offset(45)
                    make.width.equalTo(self.view.snp.width).multipliedBy(0.4)
                    make.centerX.equalTo(self.view.snp.centerX)
                    make.height.equalTo(self.view.snp.height).multipliedBy(0.3)
            }
            registerView.snp.makeConstraints
                {
                    (make) -> Void in
                    make.top.equalTo(logo.snp.bottom)
                    make.left.equalTo(self.view.snp.left)
                    make.right.equalTo(self.view.snp.right)
                    make.bottom.equalTo(self.view.snp.bottom)
            }
            titleLabel.snp.makeConstraints
                {
                    (make) -> Void in
                    make.height.equalTo(60)
                    make.centerX.equalTo(registerView.snp.centerX)
                    make.width.equalTo(registerView.snp.width)
                    make.bottom.equalTo(openCameraButton.snp.top)
            }
            openCameraButton.snp.makeConstraints
                {
                    (make) -> Void in
                    make.bottom.equalTo(photosView.snp.top).offset(-25)
                    make.width.equalTo(registerView.snp.width).multipliedBy(0.5)
                    make.centerX.equalTo(registerView.snp.centerX)
                    make.height.equalTo(60)
            }
            photosView.snp.makeConstraints
                {
                    make in
                    make.left.equalTo(self.view.snp.left)
                    make.right.equalTo(self.view.snp.right)
                    make.height.equalTo(registerView.snp.height).multipliedBy(0.35)
                    make.centerY.equalTo(registerView.snp.centerY)
            }
            collectionView.snp.makeConstraints
                {
                    make in
                    make.left.right.equalTo(photosView)
                    make.top.bottom.equalTo(photosView)
            }
            continueRegisterButton.snp.makeConstraints
                {
                    (make) -> Void in
                   // make.height.equalTo(60)
                    make.centerX.equalTo(registerView.snp.centerX)
                  //  make.width.equalTo(registerView.snp.width).multipliedBy(0.6)
                    make.top.equalTo(collectionView.snp.bottom).offset(50)
            }
        }
        super.updateViewConstraints()
    }
    
    func isEmpty() -> Bool {
        
        // check if photos array is empty
        if photosArray.count > 0 {
            return false
        }
        else {
            return true
        }
    }
    
    func imagesUploadedSucessfull(response: User)
    {
        Loader.hideLoader()
        collectionView.reloadData()
        let index = IndexPath(item: (self.photosArray.count) - 1, section: 0)
        self.collectionView.scrollToItem(at: index, at: UICollectionViewScrollPosition.bottom, animated: true)
    }
    
    @objc func popupPhotoCamera()
    {
        let popupPhotoViewController = PopupPhotoVc()
        
        PopupPhotoVc.popup = PopupDialog.init(viewController: popupPhotoViewController)
        
        // Create buttons
        let cancelButton = CancelButton(title: "Cancel".localized()) {
            
        }
        
        PopupPhotoVc.popup?.buttonAlignment = .horizontal
        
        PopupPhotoVc.popup?.addButton(cancelButton)
        
        self.present(PopupPhotoVc.popup!, animated: true, completion: {
            popupPhotoViewController.delegate =  self
        })
    }
    
    func removePhotoAction(sender: UIButton)
    {
        photosArray.remove(at: sender.tag)
        collectionView.reloadData()
        UiHelpers.setEnabled(button: self.continueRegisterButton, isEnabled: false)

    }
}

//MARk:- this delegate will contain image
extension RegisterImageVC: PhotosDelegate {
    func didFinishPicking(with data: [Data]) {
            if photosArray.count > 8
            {
                //presentAlert()
            }
            else
            {
                UiHelpers.setEnabled(button: self.continueRegisterButton, isEnabled: true)
                photosArray = data
                collectionView.reloadData()
            }
        
    }
}

