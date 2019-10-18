//
//  SMADInterstitial.swift
//  Pods
//
//  Created by Hintoro on 10/18/19.
//

import Foundation
import Alamofire
import MagicMapper
import AdSupport

open class SMADInterstitial: NSObject {
    
//    weak open var delegate: SMAdInter?
    
    public func load(_ request: SMADRequest) {
        //Code
        var params = request.baseParam
        params.updateValue("1", forKey: "number")
        params.updateValue("random", forKey: "option")
        request.urlRequest = SMADMobileAds.kSMADGetCampaign
        request.load()
    }
    
    public func present(fromRootViewController rootViewController: UIViewController) {
        //Code
    }
    
    public var isReady: Bool {
        get {
            return self.isReady
        }
    }
    
    public var hasBeenUsed: Bool {
        get {
            return self.hasBeenUsed
        }
    }
    
    public var responseInfo: SMADResponseInfo? {
        get {
            return nil
        }
    }
    
}
