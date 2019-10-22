//
//  SMADAnalytics.swift
//  SmartmoveMobileAdsSDK
//
//  Created by Hintoro on 10/22/19.
//

import Foundation
import Alamofire
import MagicMapper


public class SMADAnalytics : NSObject {
    
    var urlRequest :String = ""
    
    public init( url:String) {
        super.init()
        urlRequest = url
    }
    
   public func request(_ completionHandler: @escaping (String) -> Void, failureHandler :@escaping (Error) -> Void) {
        Alamofire.request(urlRequest).responseJSON { (response) in
            switch (response.result){
            case.success(let JSON):
                log.debug(JSON)
                guard let json = JSON as? KeyValue, let data = json["data"] as? String else { return }
                completionHandler(data)
                break
            case .failure(let error):
                log.debug(error)
                failureHandler(error)
                break
            }
        }
    }
    
    
}
