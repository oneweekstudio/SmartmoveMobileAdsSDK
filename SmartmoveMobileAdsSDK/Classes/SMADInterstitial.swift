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
    
    open var delegate: SMADInterstitialDelegate?
    
    public func load(_ request: SMADRequest) {
        //Code
        var params = request.baseParam
        params.updateValue("1", forKey: "number")
        params.updateValue("random", forKey: "option")
        request.urlRequest = SMADMobileAds.kSMADGetCampaign
        request.load(completionHandler: { (json) in
            //Get json
        }) { (error) in
            //Error
        }
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
            return self.responseInfo
        }
    }
    
}
