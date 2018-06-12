//
//  File.swift
//  FoodServiceProvider
//
//  Created by Index on 12/18/17.
//  Copyright © 2017 index-pc. All rights reserved.
//
import UIKit
extension PopupPhotoVc
{
    func addSubviews()
    {
        view.addSubview(takePhotoLabel)
        view.addSubview(selectPhotoLabel)
    }
    
    override func updateViewConstraints()
    {
        if (!didSetupConstraints)
        {
            takePhotoLabel.snp.makeConstraints
            {
                make in
                make.left.equalTo(self.view.snp.left).offset(25)
                make.right.equalTo(self.view.snp.right).offset(-25)
                make.top.equalTo(self.view.snp.top)
                make.height.equalTo(50)
            }
            selectPhotoLabel.snp.makeConstraints
            {
                make in
                make.left.equalTo(self.view.snp.left).offset(25)
                make.right.equalTo(self.view.snp.right).offset(-25)
                make.top.equalTo(takePhotoLabel.snp.bottom)
                make.bottom.equalTo(self.view.snp.bottom).offset(-20)
            }
        }
        super.updateViewConstraints()
    }
    
   @objc func openCameraAction()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        else
        {
            noCamera()
        }
    }
    
    @objc func openPhotoLibraryAction()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    
    }
    
    func noCamera()
    {
        let alertVC = UIAlertController(
            title: "No Camera".localized(),
            message: "Sorry, this device has no camera".localized(),
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK".localized(),
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    func handleActionForImage(image: UIImage)
    {
        let imageData:Data = UIImageJPEGRepresentation(image, 0.5)!
        
        arrayOfPhotos.append(imageData)
        
        dismiss(animated:true, completion:
        {
                PopupPhotoVc.popup?.dismiss()
        })
        
    }
    
  
}
extension PopupPhotoVc:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        var  chosenImage = UIImage()
        
        chosenImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        handleActionForImage(image: chosenImage)
        
    }
    
}


