//
//  SMADAnalytics.swift
//  SmartmoveMobileAdsSDK
//
//  Created by Hintoro on 10/22/19.
//

import Foundation
import Alamofire
import MagicMapper


public class SMADAnalytics : SMADRequest {
    
    public override init() {
        super.init()
    }
    
    func request( url :String,  campaign_id:Int, size: String) {
        var params:[String:Any] = baseParam
        params.updateValue(campaign_id, forKey: "campaign")
        params.updateValue(size, forKey: "size")
        for (key, value) in params {
            print("-> \(key)  - \(value)")
        }
        Alamofire.request( url, method: .get, parameters: params)
            .responseJSON {response in
                log.debug("URL Analytics = \(response.request)")
                switch (response.result){
                case.success(let data):
                    log.debug(data)
                    break
                case .failure(let error):
                    log.debug(error)
                    break
                }
        }
    }

    public func requestViewAd(campaign_id: Int, size:String) {
        log.debug("==============")
        log.debug(SMADMobileAds.kSMADUrlViewAd)
        log.debug(campaign_id)
        log.debug(size)
        log.debug("==============")
        self.request(url: SMADMobileAds.kSMADUrlViewAd, campaign_id: campaign_id, size: size)
    }
    
    public func requestClickAd(campaign_id: Int, size:String)  {
        log.debug("==============")
        log.debug(SMADMobileAds.kSMADUrlClickAd)
        log.debug(campaign_id)
        log.debug(size)
        log.debug("==============")
        self.request(url: SMADMobileAds.kSMADUrlClickAd, campaign_id: campaign_id, size: size)
    }
    
}
