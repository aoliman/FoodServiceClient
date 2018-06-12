import Foundation
import Localize_Swift
import Gloss

enum Singeleton {
    
    static let defaultHeaders : [String : String] = ["Content-Type":"application/json"]
    static let tokenHeaders : [String : String] = ["Content-Type":"application/json" ,"Authorization": "Bearer \(Singeleton.token)"]
    
    static let userDefaults = UserDefaults.standard
    
    static var userInfo:User?{
        if let info = Singeleton.userDefaults.value(forKey: defaultsKey.userData.rawValue) {
            return User(json: info as! JSON)!
        }
        return nil
    }
    
    
    static var userId:Int?{
        if let Id = Singeleton.userDefaults.value(forKey: defaultsKey.userId.rawValue) {
            return Id as? Int
        }
        return nil
    }
    
    
    static var logined : Bool {
        if Singeleton.userDefaults.bool(forKey: defaultsKey.isLogged.rawValue) {
            return true
        }
        return false
    }
    
    static var token:String {
        if let token = Singeleton.userDefaults.string(forKey: defaultsKey.token.rawValue) {
            return token
        }
        return ""
    }
    
    
    static var userName:String {
        if let username = Singeleton.userDefaults.string(forKey: defaultsKey.userName.rawValue) {
            return username
        }
        return ""
    }
    
    static var userEmail:String {
        if let useremail = Singeleton.userDefaults.string(forKey: defaultsKey.userEmail.rawValue) {
            return useremail
        }
        return ""
    }
    
    static var userPhone:String {
        if let userphone = Singeleton.userDefaults.string(forKey: defaultsKey.userPhone.rawValue) {
            return userphone
        }
        return ""
    }
    
    static var userPassword:String {
        if let userpassword = Singeleton.userDefaults.string(forKey: defaultsKey.userPassword.rawValue) {
            return userpassword
        }
        return ""
    }
    
    
    //userPassword
    
}

