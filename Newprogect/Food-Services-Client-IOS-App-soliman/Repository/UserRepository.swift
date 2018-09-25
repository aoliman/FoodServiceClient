
import RxSwift
import Moya
import Gloss
import Moya_Gloss
import Foundation
import SwiftyJSON

    
class UserRepository: BaseRepository {
    var provider: MoyaProvider<UserService>
    typealias successHandler = (LoginResponseApi?,Int) -> Void
    typealias failureHandler = (ErrorResponse?,Int) -> Void
    
    typealias forgetPasswordHandler = (Int) -> Void


    override init() {
        let endpointClosure = { (target: UserService) -> Endpoint<UserService> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            
            return defaultEndpoint.adding(newHTTPHeaderFields: Singeleton.defaultHeaders)
        }
        provider = MoyaProvider<UserService>(endpointClosure: endpointClosure)
    }
    
     func addTokenHeaderToProvider() {
        let endpointClosure = { (target: UserService) -> Endpoint<UserService> in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            
            return defaultEndpoint.adding(newHTTPHeaderFields: Singeleton.tokenHeaders)
        }
        provider = MoyaProvider<UserService>(endpointClosure: endpointClosure)
    }
    
    
    private var userObservable: Observable<LoginResponseApi>?
    var isValid: Variable<Bool> = Variable(false)
    
    
    func login(email: String, password: String) -> Observable<LoginResponseApi>? {
        self.userObservable = provider.rx.request(.login(email: email, password: password))
            .mapObject(type:
        LoginResponseApi.self).asObservable()
        
        return self.userObservable
    }
    
    
    func singUp(name: String, email: String, password: String , phone: String,user_address: String,user_type: String) -> Observable<LoginResponseApi>? {
        

        self.userObservable = provider.rx.request(.login(email: email, password: password))
            .mapObject(type:
                LoginResponseApi.self).asObservable()
        
        
        
        return self.userObservable
    }
    
    
   
    public func signup(name: String, email: String, password: String , phone: String,user_address: String,user_type: String , onSuccess: @escaping successHandler ,onFailure: @escaping failureHandler)
    {
        
        provider.request(.signup(name: name, email: email, password: password, phone: phone, user_address: user_address, user_type: user_type))
        {
            
            result in
            switch result {
            case .success(let response):
                
                do {
                    switch response.statusCode
                    {
                    case StatusCode.success.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(loginResponseApi, response.statusCode)
        
                    default:
                        let errorResponseApi =  try response.mapObject(ErrorResponse.self)
                        onFailure(errorResponseApi, response.statusCode)
                    }
                } catch {
                       onFailure(nil, 404)
                }
                
            case .failure(_):
                   onFailure(nil, 404)
            }
        }
    }
    
    
    
    public func verifyCode(id: Int,verify_code: String , onSuccess: @escaping successHandler ,onFailure: @escaping failureHandler  )
    {
        
        addTokenHeaderToProvider()
        provider.request(.verifyCode(id: id, verify_code: verify_code))
        {
            
            result in
            switch result {
            case .success(let response):
                
                do {
                    switch response.statusCode
                    {
                    case StatusCode.success.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(loginResponseApi, response.statusCode)
                        
                    case StatusCode.complete.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(loginResponseApi, response.statusCode)

                    default:
                        let errorResponseApi =  try response.mapObject(ErrorResponse.self)
                        onFailure(errorResponseApi, response.statusCode)
                    }
                } catch {
                    onFailure(nil, 404)
                }
                
            case .failure(_):
                onFailure(nil, 404)
            }
        }
    }
    
    
    
    public func uploadProfileImage(id: Int,images: [Data], onSuccess: @escaping successHandler ,onFailure: @escaping failureHandler  )
    {
        
        addTokenHeaderToProvider()
        provider.request(.continueRegisterProfileImage(id: id, images: images))
        {
            
            result in
            
            print(result.value?.statusCode)
            do{ print(try result.value?.mapJSON())}catch{}
            
            switch result {
            case .success(let response):
                
                do {
                    switch response.statusCode
                    {
                    case StatusCode.success.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(loginResponseApi, response.statusCode)
                        
                    case StatusCode.complete.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(loginResponseApi, response.statusCode)
                        
                    default:
                        let errorResponseApi =  try response.mapObject(ErrorResponse.self)
                        onFailure(errorResponseApi, response.statusCode)
                    }
                } catch {
                    
                    onFailure(nil, 404)
                }
                
            case .failure(_):
                onFailure(nil, 404)
            }
        }
    }
    
    
    
    public func determineLocation(id: Int,lat: Double, lan: Double, onSuccess: @escaping successHandler ,onFailure: @escaping failureHandler  )
    {
        
        addTokenHeaderToProvider()
        provider.request(.continueRegisterLocation(id: id, lat: lat, lan: lan))
        {
            
            result in
            switch result {
            case .success(let response):
                
                do {
                    switch response.statusCode
                    {
                    case StatusCode.success.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(loginResponseApi, response.statusCode)
                        
                    case StatusCode.complete.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(loginResponseApi, response.statusCode)
                        
                    default:
                        let errorResponseApi =  try response.mapObject(ErrorResponse.self)
                        onFailure(errorResponseApi, response.statusCode)
                    }
                } catch {
                    
                    onFailure(nil, 404)
                }
                
            case .failure(_):
                onFailure(nil, 404)
            }
        }
    }
    
    
    public func addCreditCardInfo(id: Int, credit_card_number: String, credit_card_password: String, credit_card_finish_year: Int, credit_card_finish_month: Int, name_in_credit_card: String, country: String, postal_code: String, onSuccess: @escaping successHandler ,onFailure: @escaping failureHandler  )
    {
        
        addTokenHeaderToProvider()
        provider.request(.continueRegisterCreditCardInfo(id: id, credit_card_number: credit_card_number, credit_card_password: credit_card_password, credit_card_finish_year: credit_card_finish_year, credit_card_finish_month: credit_card_finish_month, name_in_credit_card: name_in_credit_card, country: country, postal_code: postal_code))
        {
            
            result in
            switch result {
            case .success(let response):
                
                do {
                    switch response.statusCode
                    {
                    case StatusCode.success.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(loginResponseApi, response.statusCode)
                        
                    case StatusCode.complete.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(loginResponseApi, response.statusCode)
                        
                    default:
                        let errorResponseApi =  try response.mapObject(ErrorResponse.self)
                        onFailure(errorResponseApi, response.statusCode)
                    }
                } catch {
                    
                    onFailure(nil, 404)
                }
                
            case .failure(_):
                onFailure(nil, 404)
            }
        }
    }
    
    
    
    public func forgetPassword(phone:String ,onSuccess: @escaping forgetPasswordHandler ,onFailure: @escaping failureHandler  )
    {
        
        provider.request(.forgetPasswordPhone(phone: phone))
        {
            
            result in
            switch result {
            case .success(let response):
                
                do {
                    switch response.statusCode
                    {
                    case StatusCode.success.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(response.statusCode)
                        
                    case StatusCode.complete.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(response.statusCode)
                        
                    case StatusCode.undocumented.rawValue:
                        onSuccess(response.statusCode)

                    default:
                        let errorResponseApi =  try response.mapObject(ErrorResponse.self)
                        onFailure(errorResponseApi, response.statusCode)
                    }
                } catch {
                    
                    onFailure(nil,404)
                }
                
            case .failure(_):
                onFailure(nil,404)
            }
        }
    }
    
    
    public func VerifyCodeforgetPassword(phone:String , verify_code: String,onSuccess: @escaping forgetPasswordHandler ,onFailure: @escaping failureHandler  )
    {
        
        provider.request(.verifyCodeChangfePassword(phone: phone, verify_code: verify_code))
        {
            
            result in
            switch result {
            case .success(let response):
                
                do {
                    switch response.statusCode
                    {
                    case StatusCode.success.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(response.statusCode)
                        
                    case StatusCode.complete.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(response.statusCode)
                        
                    case StatusCode.undocumented.rawValue:
                        onSuccess(response.statusCode)
                        
                    default:
                        let errorResponseApi =  try response.mapObject(ErrorResponse.self)
                        onFailure(errorResponseApi, response.statusCode)
                    }
                } catch {
                    
                    onFailure(nil,404)
                }
                
            case .failure(_):
                onFailure(nil,404)
            }
        }
    }
    
    
    
    public func resetPassword(newPassword:String , phone: String,onSuccess: @escaping forgetPasswordHandler ,onFailure: @escaping failureHandler  )
    {
        
        provider.request(.resetPasswordPhone(newPassword: newPassword, phone: phone))
        {
            
            result in
            switch result {
            case .success(let response):
                
                do {
                    switch response.statusCode
                    {
                    case StatusCode.success.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(response.statusCode)
                        
                    case StatusCode.complete.rawValue:
                        let loginResponseApi =  try response.mapObject(LoginResponseApi.self)
                        onSuccess(response.statusCode)
                        
                    case StatusCode.undocumented.rawValue:
                        onSuccess(response.statusCode)
                        
                    default:
                        let errorResponseApi =  try response.mapObject(ErrorResponse.self)
                        onFailure(errorResponseApi, response.statusCode)
                    }
                } catch {
                    
                    onFailure(nil,404)
                }
                
            case .failure(_):
                onFailure(nil,404)
            }
        }
    }
    
    
    
    
    
   
    
}
