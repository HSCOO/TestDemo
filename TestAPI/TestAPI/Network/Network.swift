//
//  Network.swift
//  TestAPI
//
//  Created by 胡生才 on 2020/11/11.
//

import Foundation
import Alamofire
import RxSwift
enum NetworkURL:String {
    case github = "https://api.github.com/"
}

struct Network {
    func get(urlString: String) -> Observable<String>{
        
        return Observable.create { observer in
            
            guard let url = URL.init(string: urlString) else {
                return Disposables.create()
            }
            
            AF.request(url, method: .get, parameters: nil).responseString { (responses) in
                var finalString = ""
                if let resString = responses.value {
                    finalString = resString
                }
                observer.on(.next(finalString))
                observer.on(.completed)
            }
            
            return Disposables.create()
        }
    }
}


