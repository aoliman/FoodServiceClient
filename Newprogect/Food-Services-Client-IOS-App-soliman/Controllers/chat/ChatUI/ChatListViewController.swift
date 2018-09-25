//
//  ChatListViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 1/4/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift
import Firebase

private var chatCellIdentifier = "chatCellIdentifier"

class ChatListViewController: UIViewController {
    
    var didSetupConstraints = false
    lazy var chatRepo = ChatRepo()
   
    let userId = (Singeleton.userInfo?.id)!
    
    
    lazy var Control: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector( finishRefresh), for: UIControlEvents.valueChanged)
        return refreshControl
        
    }()
    
    var tableView = UITableView()
    
    var members:  [String] = []
    var membersInfo: [String: Any] = [:]
    var chatMembers: [User] = []
    
    var userConersation = [UsersConversation]()
    
    var lastMessages: [FirebaseMessages] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        setupView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChatListTableViewCell.self, forCellReuseIdentifier: chatCellIdentifier)
        updateViewConstraints()
        self.tableView.separatorStyle = .none
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = Control
        } else {
            
        }
       
        
        
    }
    
    @objc func finishRefresh(){
        self.Control.endRefreshing()
        chatMembers.removeAll()
        lastMessages.removeAll()
        getChatMembers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        self.navigationDrawerController?.title = " "
        getChatMembers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return chatMembers.count > 0 ? chatMembers.count : 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: chatCellIdentifier)
        
        return cell!
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = cell as? ChatListTableViewCell
        if chatMembers.count > 0 {
            
            //check if unseen messages exist
            if userConersation[indexPath.row].unSeenCount > 0 {
                cell?.backgroundColor = #colorLiteral(red: 0.9607002139, green: 0.9608381391, blue: 0.9606701732, alpha: 1)
                cell?.numberOfUnreadMessages.isHidden = false
                cell?.numberOfUnreadMessages.text = "+" + String(userConersation[indexPath.row].unSeenCount)
                cell?.lastMessageLabel.font = UIFont.appFontBold(ofSize: 14)
                cell?.lastMessageLabel.textColor = .black
                cell?.lastMessageTimeLabel.textColor = .black
            } else {
                cell?.backgroundColor = .clear
                cell?.numberOfUnreadMessages.isHidden = true
                cell?.numberOfUnreadMessages.text = ""
                cell?.lastMessageLabel.font = UIFont.appFont(ofSize: 14)
                cell?.lastMessageLabel.textColor = .lightGray
                cell?.lastMessageTimeLabel.textColor = .lightGray
            }
          
            cell?.lastMessageTimeLabel.text = getDateAsString(lastMessages[indexPath.row].createdAt)

            if let lastMessage = lastMessages[indexPath.row].text {
                if lastMessage.isEmpty {
                    cell?.lastMessageLabel.text = ""
                } else {
                    cell?.lastMessageLabel.text = lastMessages[indexPath.row].text
                }
            }
            
            let mebmer = chatMembers[indexPath.row]
            cell?.nameLabel.text = mebmer.name
            let urlString = mebmer.profileImg
            
            if mebmer.online {
                cell?.onlineStatusLabel.isHidden = false
            }
            else {
                cell?.onlineStatusLabel.isHidden = true
            }
            if urlString != nil {
                
                let url = URL(string: (urlString)!)
                cell?.userImage.kf.setImage(with: url, completionHandler: {
                    
                    (image, error, cacheType, imageUrl) in
                    
                    if image != nil {
                        cell?.userImage.image =  image!.circle
                    } else {
                        cell?.userImage.image = #imageLiteral(resourceName: "profile").circle
                    }
                })
            } else {
                cell?.userImage.image = #imageLiteral(resourceName: "profile").circle
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chatViewContoller = ChatViewController()
        chatViewContoller.receiver = self.chatMembers[indexPath.row]
        chatViewContoller.conversationId = self.userConersation[indexPath.row].conversationId
        self.navigationItem.backButton.titleColor = .white
        self.navigationItem.backButton.tintColor = .white
        
        self.navigationController?.pushViewController(chatViewContoller, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.alpha = 0.5
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.alpha = 1
    }
}

extension ChatListViewController {
    
    func getChatMembers() {

        userRef.child("\(userId)").child("conversations").queryOrdered(byChild: "lastMessageTime")
                    .observe(.value, with: {
                        
                            [weak self] (snapshot) in
                        
                            if  snapshot.exists() {
                                
                                self?.members.removeAll()
                                self?.userConersation.removeAll()
                                self?.chatMembers.removeAll()
                                
                                for childSnap in  snapshot.children.allObjects.reversed() {
                                    
                                    let snap = childSnap as! DataSnapshot
                                    if UsersConversation(snap: snap).conversationId != "" {
                                        self?.getLastMessage(UsersConversation(snap: snap).conversationId)
                                        self?.userConersation.append(UsersConversation(snap: snap))
                                        let id = snap.key
                                        self?.getMemberDetails(id)
                                        self?.members.append(snap.key)
                                    }
                                }
                                self?.tableView.reloadData()
                            } else {
                                self?.tableView.isHidden = true
                                UIViewController.nothingLabel.text = "No members".localized()
                                self?.addNothingAvailableLabel()
                                
                        }
        })
        
        let members = userRef.child("\(userId)").child("conversations").queryOrdered(byChild: "lastMessageTime")
        print(members)
    }
    
    func getMemberDetails(_ id: String) {
        
        userRef.child(id).child("details").observeSingleEvent(of: DataEventType.value, with: { [weak self] (snapshot) in
            if  snapshot.exists() {
                
                let userSnapshot = snapshot.value as? [String: Any]
                let user = User(json: userSnapshot!)!
                
                if let chatMembers = self?.chatMembers.enumerated() {
                    
                    for (index, member) in chatMembers {
                        if member.id == user.id {
                            self?.chatMembers[index] = user
                            self?.tableView.reloadData()
                            return
                        }
                    }
                }
                
                self?.chatMembers.append(user)
                self?.tableView.reloadData()
            } else {
                print("error")
            }
            
            if self?.chatMembers.count == 0 {
                self?.tableView.isHidden = true
                UIViewController.nothingLabel.text = "No members".localized()
                self?.addNothingAvailableLabel()
            } else {
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
                UIViewController.nothingLabel.text = ""
                self?.removeNothingLabel()
            }
        })
    }
    
    func getLastMessage(_ conversationId: String){
        
        lastMessages.removeAll()
        if conversationId != "" {
            conversationsRef.child(conversationId).child("lastMessage").observeSingleEvent(of: DataEventType.value, with: {[weak self] (snapshot) in
                
                self?.lastMessages.append(FirebaseMessages(snap: snapshot))
                
            })
        }
        
    }
}
