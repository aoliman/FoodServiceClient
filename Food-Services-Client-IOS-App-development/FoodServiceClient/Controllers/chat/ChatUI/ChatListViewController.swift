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

    var setOnlineSwitch: UISwitch = {
        let switchBtn = UISwitch()
        switchBtn.onTintColor =  UIColor.navigationBarColor()
        switchBtn.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)

        switchBtn.translatesAutoresizingMaskIntoConstraints = false
        return switchBtn
    }()
    
    lazy var Control: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(finishRefresh), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    var onlineStatus = Bool()
   
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Chat list".localized()
        label.textColor = UIColor.navigationBarColor()
        label.font = UIFont.appFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var tableView = UITableView()
    
    // variables used in firebase
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
        setOnlineSwitch.addTarget(self, action: #selector(changeOnlineStatus), for: .valueChanged)
        updateViewConstraints()
        self.tableView.separatorStyle = .none
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = Control
        } else {
            // Fallback on earlier versions
        }
        Control.tintColor = UIColor.appColor()
        
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
        
        onlineStatus = UserDefaults.standard.bool(forKey: defaultsKey.onlineStatus.rawValue)
        setOnlineSwitch.setOn(onlineStatus, animated: true)
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
//                cell?.backgroundColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:0.3)
                cell?.backgroundColor = UIColor.navigationBarColor().withAlphaComponent(0.1)
                cell?.numberOfUnreadMessages.text = String(userConersation[indexPath.row].unSeenCount)
            } else {
                cell?.backgroundColor = .clear
                cell?.numberOfUnreadMessages.text = ""
            }
            
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
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chatViewContoller = ChatViewController()
        chatViewContoller.receiver = self.chatMembers[indexPath.row]
        chatViewContoller.conversationId = self.userConersation[indexPath.row].conversationId
      
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
                                print("eeee")
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
                
                for (index, member) in (self?.chatMembers.enumerated())! {
                    
                    if member.id == user.id {
                        self?.chatMembers[index] = user
                        self?.tableView.reloadData()
                        return
                    }
                    
                }
                
                self?.chatMembers.append(user)
                
                self?.tableView.reloadData()
            } else {
                print("eeee")
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
    
    @objc func changeOnlineStatus() {
        
        chatRepo.getOnlineStatus(online: setOnlineSwitch.isOn) { (statusCode) in
            switch statusCode {
                case StatusCode.complete.rawValue , StatusCode.success.rawValue, StatusCode.undocumented.rawValue:
                    UserDefaults.standard.set(self.setOnlineSwitch.isOn, forKey: defaultsKey.onlineStatus.rawValue)
                    self.setOnlineSwitch.setOn(self.setOnlineSwitch.isOn, animated: true)
                    self.updateOnlineStatusInFirebase(self.setOnlineSwitch.isOn)
                
                case StatusCode.badRequest.rawValue:
                    DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "badRequest")
                    
                case StatusCode.unauthorized.rawValue:
                    DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "unauthenticated")
                    
                case StatusCode.forbidden.rawValue:
                    DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "forbidden")
                    
                case StatusCode.notFound.rawValue:
                    DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "not Found")
                    
                    
                case StatusCode.unprocessableEntity.rawValue:
                    DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "not Found")
                    
                case StatusCode.serverError.rawValue :
                    DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body: "ServrError".localized())
                    
                default:
                    DataUtlis.data.noInternetDialog()
                

            }
            
            
           
        }
    }
    
    func updateOnlineStatusInFirebase(_ status: Bool) {
        
        let ref = userRef.child("\(userId)").child("details")
        
        let online = [
            "online": status,
            
            ] as [String : Any]
        
        ref.updateChildValues(online)
    }
    
    
//    func observeChannels(clientID: Int, providerID: Int, indexPath: IndexPath)
//    {
//        chatRef.child("client\(clientID)provider\(providerID)").child("lastMessage").observe(.value, with: { (snapshot) in
//                if let LastMessage = snapshot.value as? [String:Any]
//                {
//                    let cell = self.tableView.cellForRow(at: indexPath) as? ChatListTableViewCell
//                    let message = LastMessage["message"] as? String
//                    cell?.lastMessageLabel.text = message
//
//
//                } else {
//                    print("Error! Could not decode channel data")
//
//                }
//
//            })
//    }
//
  
//
//    func fetchUnseenCount(clientID: Int, providerID: Int, indexPath: IndexPath)
//    {
//        chatRef.child("client\(clientID)provider\(providerID)").child("provider\(providerID)")
//            .observe(.value, with:
//                {
//                    (snapshot) in
//                    if let client = snapshot.value as? [String:Any]
//                    {
//                        let cell = self.tableView.cellForRow(at: indexPath) as? ChatListTableViewCell
//                        let message = client["unseenCount"] as? Int
//                        if message! > 0
//                        {
//                            cell?.backgroundColor = UIColor(red:0.75, green:0.75, blue:0.75, alpha:0.3)
//                            cell?.numberOfUnreadMessages.text = "(" + String(message!) + ")"
//                        }
//                    }
//                    else
//                    {
//                        print("Error! Could not decode channel data")
//                    }
//            })
//    }
//
   
}
