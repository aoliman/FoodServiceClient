//
//  Validators.swift
//  E-Tabeb
//
//  Created by RamyNasser on 4/23/17.
//  Copyright © 2017 index. All rights reserved.
//

import UIKit
import Material
import RxSwift
import RxCocoa
import Localize_Swift
class Validator {
    
    enum Rule {
        case notEmpty
        case email
        case number
        case emailOrPhone
        case isValidPhone
        case selected
        case minimumNumberOfCharacters
        case minimumMaximumNumberOfCharacters
        case minimumNumberOfPasswordCharacters
        case nationalIdMinimumNumberOfCharacters
    }
    
    private static var validatorsDictionary = [ErrorTextField: Validator]()
    private weak var textField: ErrorTextField?
    private var errorMessage: String = ""
    public var isValid = BehaviorSubject<Bool>(value: false)
    
    private var internalIsValid: Bool {
        willSet {
            self.isValid.onNext(newValue)
        }
    }
    
    let disposeBag = DisposeBag()
    
    private init(textField: ErrorTextField) {
        self.textField = textField
        internalIsValid = true
    }
    
    deinit {
        if let textField = self.textField {
            Validator.validatorsDictionary[textField] = nil
        }
    }
    
    public class func getInstance(textField: ErrorTextField) -> Validator {
        if let validator = Validator.validatorsDictionary[textField] {
            return validator
        } else {
            let validator = Validator(textField: textField)
            Validator.validatorsDictionary[textField] = validator
            return validator
        }
    }
    //MARK:- Rules
    private func notEmpty() -> Observable<Bool> {
        let variable = Variable<Bool>(false)
        self.textField?.rx.controlEvent([.editingChanged])
            .asDriver()
            .drive(onNext: {
                var placeholder = ""
                if let p = self.textField?.placeholder {
                    placeholder = p
                }
                
                if (self.textField?.text?.isBlank)! {
//                    self.errorMessage = "\(placeholder) \("isRequired".localized())"
                    variable.value = false
                } else {
                    variable.value = true
                }
            })
            .disposed(by: self.disposeBag)
        
        return variable.asObservable()
    }
    
  
    
    private func email() -> Observable<Bool> {
        let variable = Variable<Bool>(false)
        self.textField?.keyboardType = .emailAddress
        self.textField?.rx.controlEvent([.editingChanged])
            .asDriver()
            .drive(onNext: {
                if !(self.textField?.text?.isEmail)! {
                    self.errorMessage = "validationEmail".localized()
                    variable.value = false
                } else {
                    variable.value = true
                }
            })
            .disposed(by: self.disposeBag)
        
        return variable.asObservable()
    }
    
    private func number() -> Observable<Bool> {
        let variable = Variable<Bool>(false)
        self.textField?.keyboardType = .numberPad
        self.textField?.rx.controlEvent([.editingChanged])
            .asDriver()
            .drive(onNext: {
                //                if !(self.textField?.text?.isEmail)! {
                //                    self.errorMessage = "please enter a valid email"
                //                    variable.value = false
                //                } else {
                variable.value = true
                //                }
            })
            .disposed(by: self.disposeBag)
        
        return variable.asObservable()
    }
    
    private func emailOrPhone() -> Observable<Bool> {
        let variable = Variable<Bool>(false)
        
        self.textField?.keyboardType = .emailAddress
        self.textField?.rx.controlEvent([.editingChanged])
            .asDriver()
            .drive(onNext: {
                if !(self.textField?.text?.isEmail)! && !(self.textField?.text?.isNumber())! && !(self.textField?.text?.isNumber())!{
                    self.errorMessage = "emailOrPhoneError".localized()
                    variable.value = false
                }
                    
                else {
                    variable.value = true
                }
            })
            .disposed(by: self.disposeBag)
        
        return variable.asObservable()
    }
    
    
    
    private func isValidPhone() -> Observable<Bool> {
        let variable = Variable<Bool>(false)

        self.textField?.keyboardType = .phonePad
        self.textField?.rx.controlEvent([.editingChanged])
            .asDriver()
            .drive(onNext: {
                
                if (self.textField?.text?.isPhone())!
                    
                {
                    self.errorMessage = "PhoneError".localized()
                    variable.value = false
                }
                    
                else {
                    variable.value = true
                }
            })
            .disposed(by: self.disposeBag)
        
        return variable.asObservable()
    }
    private func minimumNumberOfCharacters() -> Observable<Bool> {
        let variable = Variable<Bool>(false)
        //        self.textField?.keyboardType = .emailAddress
        self.textField?.rx.controlEvent([.editingChanged])
            .asDriver()
            .drive(onNext: {
                if String(describing: self.textField?.text!).characters.count < 14 { // 12 is empty
                    self.errorMessage = "minNumberOfCharactersError".localized()
                    variable.value = false
                } else {
                    variable.value = true
                }
            })
            .disposed(by: self.disposeBag)
        
        return variable.asObservable()
    }
    
    private func nationalIdMinimumNumberOfCharacters() -> Observable<Bool> {
        let variable = Variable<Bool>(false)
        //        self.textField?.keyboardType = .emailAddress
        self.textField?.rx.controlEvent([.editingChanged])
            .asDriver()
            .drive(onNext: {
                if String(describing: self.textField?.text!).characters.count < 22 { // 12 is empty
                    self.errorMessage = "nationalIdMinNumberOfCharactersError".localized()
                    variable.value = false
                } else {
                    variable.value = true
                }
            })
            .disposed(by: self.disposeBag)
        
        return variable.asObservable()
    }
    
    private func minimumNumberOfPasswordCharacters() -> Observable<Bool> {
        let variable = Variable<Bool>(false)
        self.textField?.rx.controlEvent([.editingChanged])
            .asDriver()
            .drive(onNext: {
                if String(describing: self.textField?.text!).characters.count < 18 { // 12 is empty
                    self.errorMessage = "passwordError".localized()
                    variable.value = false
                } else {
                    variable.value = true
                }
            })
            .disposed(by: self.disposeBag)
        
        return variable.asObservable()
    }
    
    private func minimumMaximumNumberOfCharacters() -> Observable<Bool> {
        let variable = Variable<Bool>(false)
        self.textField?.rx.controlEvent([.editingChanged])
            .asDriver()
            .drive(onNext: {
                if String(describing: self.textField?.text!).characters.count < 21 || String(describing: self.textField?.text!).characters.count > 27 { // 12 is empty
                    self.errorMessage = "minMaxNumberOfCharactersError".localized()
                    variable.value = false
                } else {
                    variable.value = true
                }
            })
            .disposed(by: self.disposeBag)
        
        return variable.asObservable()
    }
    
    
    private func selected() -> Observable<Bool> {
        let variable = Variable<Bool>(false)
        self.textField?.rx.controlEvent([.allEvents])
            .asDriver()
            .drive(onNext: {
                var placeholder = ""
                if let p = self.textField?.placeholder {
                    placeholder = p
                }
                
                if (self.textField?.text?.isBlank)! {
                    self.errorMessage = "\(placeholder) \("isRequired".localized())"
                    variable.value = false
                } else {
                    variable.value = true
                }
            })
            .disposed(by: self.disposeBag)
        
        return variable.asObservable()
    }
    
    
    func build(_ rules: Validator.Rule...) -> Validator {
        var observables = [Observable<Bool>]()
        
        
        if rules.contains(Validator.Rule.email) {
            observables.append(self.email())
        }
        
        if rules.contains(Validator.Rule.number) {
            observables.append(self.number())
        }
        
        if rules.contains(Validator.Rule.emailOrPhone) {
            observables.append(self.emailOrPhone())
        }
        
        if rules.contains(Validator.Rule.isValidPhone) {
            observables.append(self.isValidPhone())
        }
        if rules.contains(Validator.Rule.selected) {
            observables.append(self.selected())
        }
        
        if rules.contains(Validator.Rule.notEmpty) {
            observables.append(self.notEmpty())
            
        }
        
        if rules.contains(Validator.Rule.minimumNumberOfCharacters) {
            observables.append(self.minimumNumberOfCharacters())
            
        }
        
        if rules.contains(Validator.Rule.minimumMaximumNumberOfCharacters) {
            observables.append(self.minimumMaximumNumberOfCharacters())
        }
        
        if rules.contains(Validator.Rule.minimumNumberOfPasswordCharacters) {
            observables.append(self.minimumNumberOfPasswordCharacters())
        }
        
        if rules.contains(Validator.Rule.nationalIdMinimumNumberOfCharacters) {
            observables.append(self.nationalIdMinimumNumberOfCharacters())
        }
        
        let distinctObservables = observables.map {
            $0.distinctUntilChanged()
        }
        
        Observable.combineLatest(distinctObservables) { values -> Bool in
            var result = true
            values.forEach({ (value) in
                result = result && value
            })
            return result
            }.subscribe(onNext: {
                self.internalIsValid = $0
            })
            .disposed(by: self.disposeBag)
        return self
    }
    
    func show() {
        self.textField?.rx.text.asDriver().drive(onNext: { (text) in
            if !self.internalIsValid {
                self.textField?.isErrorRevealed = true
                self.textField?.detailColor = UIColor.red
                self.textField?.detail = self.errorMessage
            } else {
                self.textField?.isErrorRevealed = false
            }
        }).disposed(by: disposeBag)
        
    }
    
}

extension ErrorTextField {
    var validator: Validator {
        return Validator.getInstance(textField: self)
    }
}

