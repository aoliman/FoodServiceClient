
//  Data.swift
//  SIGNET
//

import Foundation
import SwiftMessages
import UIKit
import Alamofire
import Alamofire
import SystemConfiguration
class DataUtlis {
    static var data = DataUtlis()
    
    func isValidEmail(Email:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: Email)
    }
    
    
     func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    
    func SuccessDialog(Title:String ,Body:String ){
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.success)
        success.configureDropShadow()
        success.configureContent(title: Title, body: Body)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .bottom
        successConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        SwiftMessages.show(config: successConfig, view: success)
    }
    
    func WarningDialog(Title:String ,Body:String ){
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.info)
        success.configureDropShadow()
        success.configureContent(title: Title, body: Body)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .bottom
        successConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        SwiftMessages.show(config: successConfig, view: success)
    }
    
    func noInternetDialog(){
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.info)
        success.configureDropShadow()
        success.configureContent(title: "internetProblemTitle".localized(), body: "internetProblemBody".localized())
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .bottom
        successConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        SwiftMessages.show(config: successConfig, view: success)
        
        
    }
    func ErrorDialog(Title:String ,Body:String ){
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.error)
        success.configureDropShadow()
        success.configureContent(title: Title, body: Body)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .bottom
        successConfig.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        SwiftMessages.show(config: successConfig, view: success)
        
        
    }
    
    
}
