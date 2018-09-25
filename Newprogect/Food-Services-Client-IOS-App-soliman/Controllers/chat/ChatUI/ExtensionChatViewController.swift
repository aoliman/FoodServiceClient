//
//  File.swift
//  FoodServiceProvider
//
//  Created by Index on 1/10/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import JSQMessagesViewController

extension ChatViewController {

    
    func removeAccessoryButton() {
        
        if self.inputToolbar.sendButtonOnRight {
            inputToolbar.contentView.leftBarButtonItem.isHidden = true
        } else {
            inputToolbar.contentView.rightBarButtonItem.isHidden = true
        }
        inputToolbar.contentView.textView.placeHolder = "Type a message".localized()

    }
    
    func createCustomNavigationBarItem() {
        
        setupNavigationBar()
    
        let chatNavigationBarItem = ChatNavigationBarItem()
        
        if let urlString = receiver?.profileImg {
            let url = URL(string: (urlString))
            chatNavigationBarItem.userImage.kf.setImage(with: url, completionHandler: {
                (image, error, cacheType, imageUrl) in
                
                if image != nil {
                    chatNavigationBarItem.userImage.image =  image!.circle
                    self.receiverImage = image
                    
                } else {
                    self.receiverImage = #imageLiteral(resourceName: "profile").circle
                    chatNavigationBarItem.userImage.image = #imageLiteral(resourceName: "profile").circle
                }
            })
        } else {
            self.receiverImage = #imageLiteral(resourceName: "profile").circle
            chatNavigationBarItem.userImage.image = #imageLiteral(resourceName: "profile").circle
        }
        
        chatNavigationBarItem.nameLabel.text =  receiver?.name

        self.navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor()
        
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: chatNavigationBarItem)
      //  self.navigationItem.leftBarButtonItem?.tintColor = .white
       self.navigationItem.backButton.titleColor = .white
    }
    
    func hideKeyboardWhenTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        tapGesture.cancelsTouchesInView = true
        self.collectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        
//        UpdateUnTypingNow()
        collectionView.inputView?.endEditing(true)
        collectionView.superview?.endEditing(true)
        collectionView.backgroundView?.endEditing(true)
        collectionView.collectionViewLayout?.collectionView.endEditing(true)
    }
}
