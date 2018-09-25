//
//  BaseViewModel.swift
//  E-Tabeb
//
//  Created by RamyNasser on 5/3/17.
//  Copyright © 2017 Code95. All rights reserved.
//

import Foundation
import RxSwift
import Moya_Gloss
import Moya
import Localize_Swift

class BaseRepository {
    func isValid(observables: Observable<Bool>...) -> Observable<Bool> {
        let distinctObservables = observables.map {
            $0.distinctUntilChanged()
        }
        
        let observable = Observable.combineLatest(distinctObservables) { values -> Bool in
            var result = true
            values.forEach({ (value) in
                result = result && value
            })
            return result
        }
        return observable
    }
    
}

