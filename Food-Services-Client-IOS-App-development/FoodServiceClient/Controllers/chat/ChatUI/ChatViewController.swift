//
//  ChatViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 1/9/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    
    var conversationId = String()
    var firebaseMessages = [FirebaseMessages]()
    
//    var conversition = [Conversition]()
//    var conversitionDate = String()
//    var client = [DataModel]()
//    var clientName: String?
    var receiverImage: UIImage?

    var receiver: User?
    
    var userId: String = String(Singeleton.userInfo!.id!)

    var userData = UserDefaults.standard.object(forKey: defaultsKey.userData.rawValue) as? [String: Any]

    var user: User?
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()

    var receiverUnseenCount = Int()
    
//    static var checkSend: UILabel = {
//        let label = UILabel()
//        label.textColor = .darkGray
//        label.font = UIFont.fontAwesome(ofSize: 20)
//        label.text = String.fontAwesomeIcon(code: "fa-clock-o")
//        label.textAlignment = .center
////        label.isHidden = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = User(json: userData!)

//        //chat Info for managment or normal client
//        clientName = client.count > 0 ? client[0].name : "Mangment".localized()
//        receiverId = client.count > 0 ? String(client[0].id) : "0"
//
        removeAccessoryButton() //remove default AccessoryButton from JSQMessagesViewController
        
        createCustomNavigationBarItem() //navigationBar With back Button & ChatNavigationBar Button
        
        self.senderId = String(describing: (user?.id)!)
        
        self.senderDisplayName = user?.name
    
        self.inputToolbar.contentView.textView.delegate = self
         
        collectionView?.collectionViewLayout.incomingAvatarViewSize = CGSize(width: kJSQMessagesCollectionViewAvatarSizeDefault, height:kJSQMessagesCollectionViewAvatarSizeDefault )
        collectionView?.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        // This is a beta feature that mostly works but to make things more stable it is diabled.
        collectionView?.collectionViewLayout.springinessEnabled = false
        
        automaticallyScrollsToMostRecentMessage = true
        
        hideKeyboardWhenTapped()
        
        fetchMessages()
        finishReceivingMessage()
        updateUnseenCount()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        self.fetchIsTyping()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        return messages[indexPath.row]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let message = messages[indexPath.item]
        print(message.senderId, senderId)
        if message.senderId == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
    }
   
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
            as! JSQMessagesCollectionViewCell

//        cell.addSubview(ChatViewController.checkSend)
//        ChatViewController.checkSend.frame = cell.frame

        let message = self.messages[indexPath.row]

        if message.senderDisplayName == receiver?.name {
            cell.textView.textColor = .black
        }
        
        return cell
    }

    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        
        let bubbleImageFactory = JSQMessagesBubbleImageFactory(bubble: UIImage.jsq_bubbleCompactTailless(), capInsets: UIEdgeInsets.zero)
        
       return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.navigationBarColor())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        
        let bubbleImageFactory = JSQMessagesBubbleImageFactory(bubble: UIImage.jsq_bubbleCompactTailless(), capInsets: UIEdgeInsets.zero)
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        let message = messages[indexPath.row]
        
        var prevMessage = messages[indexPath.row]
    
        
        if indexPath.row != 0 {
            prevMessage = messages[indexPath.row - 1]
        } else if indexPath.row == 0 {
            if message.senderDisplayName == receiver?.name {
                let avatarImage = JSQMessagesAvatarImageFactory.avatarImage(with: receiverImage, diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
                
                return avatarImage
            }
        }

        if message.senderDisplayName == receiver?.name && message.senderDisplayName != prevMessage.senderDisplayName {
            
            let avatarImage = JSQMessagesAvatarImageFactory.avatarImage(with: receiverImage, diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))

            return avatarImage
        }
        return nil
    }
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        let ref = conversationsRef.child(conversationId).child("messages").childByAutoId()
        let newMessage = [ "createdAt": Date().millisecondsSince1970,
                           "senderId": Int(senderId)!,
                           "text": text] as [String : Any]
        
        ref.setValue(newMessage, withCompletionBlock: { error,_ in
            if (error != nil) {
//                ChatViewController.checkSend.isHidden = false
            } else {
//                ChatViewController.checkSend.isHidden = true
            }
        })

        fetchReceiverUnseenCount()
        updateLastMeesage(text)
        finishSendingMessage()
        self.collectionView.reloadData()

    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapCellAt indexPath: IndexPath!, touchLocation: CGPoint) {
        
        print(indexPath)
    }
   
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
       
        super.collectionView(collectionView, attributedTextForCellBottomLabelAt: indexPath)
        super.collectionView(collectionView, layout: JSQMessagesCollectionViewFlowLayout(), heightForCellBottomLabelAt: indexPath)
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        
        
        let message = self.messages[indexPath.row]
        let date = message.date
        let calendar = Calendar.current

        let hour = calendar.component(.hour, from: date!)
        let day = calendar.component(.day, from: date!)
        
       
        
        if indexPath.row == 0 {
            return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
        } else {
            let prevMesssage = self.messages[indexPath.row - 1]
            let prevDate = prevMesssage.date
            let prevDay = calendar.component(.day, from: prevDate!)
            let prevHour = calendar.component(.hour, from: prevDate!)
            
            if message.senderDisplayName == receiver?.name && prevMesssage.senderDisplayName == user?.name {
                return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
            }
            
            if day != prevDay {
                
                return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
            } else {
                if hour != prevHour {
                    return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)

                }
            }
            
          
            
        }
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAt indexPath: IndexPath!) -> CGFloat {
        let message = self.messages[indexPath.row]
        let date = message.date
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date!)
        let day = calendar.component(.day, from: date!)
      
        if indexPath.row == 0 {
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        } else {
            let prevMesssage = self.messages[indexPath.row - 1]
            let prevDate = prevMesssage.date
            let prevDay = calendar.component(.day, from: prevDate!)
            let prevHour = calendar.component(.hour, from: prevDate!)
            
            if message.senderDisplayName == receiver?.name && prevMesssage.senderDisplayName == user?.name {
                return kJSQMessagesCollectionViewCellLabelHeightDefault
            }
            
            if day != prevDay {
                return kJSQMessagesCollectionViewCellLabelHeightDefault
            } else {
                if hour != prevHour {
                    return kJSQMessagesCollectionViewCellLabelHeightDefault
                }
            }
        }
        return 0.0

    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = self.messages[indexPath.row]
        
        if indexPath == collectionView.indexPathsForSelectedItems?.last {
            return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
        }
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAt indexPath: IndexPath!) -> CGFloat {
        
        if indexPath == collectionView.indexPathsForSelectedItems?.last {
            
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
        return 0.0
    }
    
    func keyboardWillShow(notification: NSNotification) {
    }

    override func finishSendingMessage(animated: Bool) {
        super.finishSendingMessage(animated: true)
        updateLastMessageTime()
    }
    
    func keyboardWillHide(notification: NSNotification) {
//        self.UpdateUnTypingNow()

    }
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {

        self.inputToolbar.contentView.textView.endEditing(true)
        return true
    }

    override func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        return true
    }
    
    override func textViewDidBeginEditing(_ textView: UITextView) {
        super.textViewDidBeginEditing(textView)

//            self.UpdateTypingNow()
    }
    
    override func textViewDidEndEditing(_ textView: UITextView) {
//        self.UpdateUnTypingNow()
    }
    
    override func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ChatViewController {
    
    func updateUnseenCount() {
        
        let ref = userRef.child("\(userId)").child("conversations").child(String(describing: (receiver?.id)!))
        
        let unSeenCount = [
            "unSeenCount": 0,
            ] as [String : Any]
        
        ref.updateChildValues(unSeenCount)
       
        let refrence = userRef.child("\(userId)").child("unSeen").child(String(describing: (receiver?.id)!))
//        let unseeencount = [ "unSeenCount": 0 ] as [String : Any]
        refrence.removeValue()
        
    }
    
    func fetchReceiverUnseenCount() {
        
        userRef.child(String(describing: (receiver?.id)!)).child("conversations").child("\(userId)").observeSingleEvent(of: .value, with: {  (dataSnapshot) in
            
            let snap =  dataSnapshot.value as? [String: Any]

            self.receiverUnseenCount = (snap?["unSeenCount"] as? Int) != nil ? (snap?["unSeenCount"] as? Int)! : 0
            self.updateReceiverUnseenCount()

        })
        
        
    }
    
    func updateReceiverUnseenCount() {
        
        let ref = userRef.child(String(describing: (receiver?.id)!)).child("conversations").child("\(userId)")
        
        let unSeenCount = [
            "conversationId" : conversationId,
            "unSeenCount": receiverUnseenCount + 1,
            ] as [String : Any]
        
        ref.updateChildValues(unSeenCount)

        let refrence = userRef.child(String(describing: (receiver?.id)!)).child("unSeen")
        let unSeen = [ "\(userId)" : receiverUnseenCount + 1] as [String : Any]
        refrence.updateChildValues(unSeen)

        
    }
    
    func fetchMessages() {

        conversationsRef.child(conversationId).child("messages").observe(.value, with: { [weak self] (dataSnapshot) in
            self?.messages.removeAll()

            for childSnap in  dataSnapshot.children.allObjects {
                
                let snap = childSnap as! DataSnapshot
                
                let messageObj: FirebaseMessages = FirebaseMessages(snap: snap)
                
                self?.firebaseMessages.append(messageObj)
                
                if let id = self?.senderId  {
                    
                    if messageObj.senderId == Int(id) {
                        
                        let jsqMessage = JSQMessage(senderId: "\(String(describing: (self?.userId)!))", senderDisplayName: self?.user?.name, date: messageObj.createdAt, text:  messageObj.text)
                        self?.messages.append(jsqMessage!)
                        
                    } else if messageObj.senderId == self?.receiver?.id {
                        let jsqMessage = JSQMessage(senderId: "\(String(describing: (self?.receiver?.id!)!))", senderDisplayName: self?.receiver?.name, date: messageObj.createdAt, text:  messageObj.text)
                        self?.messages.append(jsqMessage!)
                    }
                } else { return }
              
            }
            self?.collectionView.reloadData()
            self?.scrollToBottom(animated: true)
        })

    }
//
//
//    func fetchIsTyping() {
//        chatRef.child("client\(receiverId!)provider\(userId)").child("client\(receiverId!)")
//            .observe(.value, with:
//            {
//                (snapshot) in
//
//                if let LastMessage = snapshot.value as? [String:Any]
//                {
//                    if let isTyping = LastMessage["isTyping"] as? Bool
//                    {
//                        if isTyping
//                        {
//                            self.showTypingIndicator = true
//                            self.scrollToBottom(animated: true)
//                        }
//                        else
//                        {
//                             self.showTypingIndicator = false
//                        }
//
//                    }
//                }
//
//            })
//    }
//
//
    func updateLastMeesage(_ text: String) {
            
        let ref = conversationsRef.child(conversationId).child("lastMessage")
        let newMessage = [ "createdAt": Date().millisecondsSince1970,
                           "senderId": Int(senderId)!,
                           "text": text] as [String : Any]
        
        ref.updateChildValues(newMessage)
    }
    
    func updateLastMessageTime() {
        
        let receiverRef = userRef.child(String(describing: (receiver?.id)!)).child("conversations").child("\(userId)")
        let senderRef = userRef.child("\(userId)").child("conversations").child(String(describing: (receiver?.id)!))
        
        let lastMessageTime = [ "lastMessageTime": Date().millisecondsSince1970] as [String : Any]
        
        receiverRef.updateChildValues(lastMessageTime)
        senderRef.updateChildValues(lastMessageTime)

    }
//
//    func UpdateTypingNow() {
//
//        let ref = chatRef.child("client\(receiverId!)provider\(userId)").child("provider\(userId)")
//
//            let newMessage = [
//                "isTyping": true,
//
//                ] as [String : Any]
//
//            ref.updateChildValues(newMessage)
//
//    }
//
//
//    func UpdateUnTypingNow() {
//
//        let ref = chatRef.child("client\(receiverId!)provider\(userId)").child("provider\(userId)")
//
//        let newMessage = [
//            "isTyping": false,
//
//            ] as [String : Any]
//
//        ref.updateChildValues(newMessage)
//    }
}


