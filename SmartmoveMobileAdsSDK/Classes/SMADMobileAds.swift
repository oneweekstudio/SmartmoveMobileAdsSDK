//
//  SMADMobileAds.swift
//  Pods
//
//  Created by Hintoro on 10/18/19.
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

public class SMADMobileAds : NSObject {
    
    public var isDebug: Bool = false
    
    static let kSMADGetCampaign = "http://cpibe.appboom.net/api/v2.1/get_campaign"
    static let kSMADUrlClickAd = "http://cpibe.appboom.net/api/v2.1/click_ad"
    static let kSMADUrlViewAd = "http://cpibe.appboom.net/api/v2.1/view_ad"
    
    
    static let kSMADGetCampaignSanbox = "http://ads.appboom.net/api/v2.1/get_campaign"
    static let kSMADUrlClickAdSanbox = "http://ads.appboom.net/api/v2.1/click_ad"
    static let kSMADUrlViewAdSanbox = "http://ads.appboom.net/api/v2.1/view_ad"
    

    public static let shared = SMADMobileAds()
    
    @available(*, deprecated)
    public class func setDebug(_ isDebug:Bool = true){
        SMADMobileAds.shared.isDebug = isDebug
        log.debug("Debug mode: \(isDebug)")
    }
    
    @available(*, deprecated)
    public class func config(_ enableDebug:Bool = true) {
        let console = ConsoleDestination()
        log.addDestination(console)
        SMADMobileAds.shared.isDebug = enableDebug
    }
    
    //Sử dụng hàm này để gọi debug mode
    public func enableDebug(_ isDebug:Bool = false) {
        let console = ConsoleDestination()
        log.addDestination(console)
        SMADMobileAds.shared.isDebug = isDebug
        print("SMADMobileAdsSDK - SanboxMode : \(SMADMobileAds.shared.isDebug)")
    }
    
}
