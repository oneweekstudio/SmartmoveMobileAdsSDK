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
            if let data = json as? KeyValue {
                let response = SMADResponseInfo(data)
                self.setResponseInfo(response)
                self.delegate?.interstitialDidReceiveAd(self)
            }
        }) { (error) in
            //Error
            self.delegate?.interstitial(self, didFailToReceiveAdWithError: error)
        }
    }
    
    public func load(_ request: SMADRequest, completionHandler :@escaping () -> Void, faillureHandler: @escaping () -> Void) {
           //Code
           var params = request.baseParam
           params.updateValue("1", forKey: "number")
           params.updateValue("random", forKey: "option")
           request.urlRequest = SMADMobileAds.kSMADGetCampaign
           request.load(completionHandler: { (json) in
               //Get json
               if let data = json as? KeyValue {
                   let response = SMADResponseInfo(data)
                   self.setResponseInfo(response)
                   self.delegate?.interstitialDidReceiveAd(self)
                   completionHandler()
               }
           }) { (error) in
               //Error
               self.delegate?.interstitial(self, didFailToReceiveAdWithError: error)
                faillureHandler()
           }
       }
    
    public func present(fromRootViewController rootViewController: UIViewController) {
        //Code
        guard let response = self.responseInfo else { return }
        let storyboard = UIStoryboard.init(name: "SMInterstitialViewController", bundle: getBundlePath())
        let intersitialViewController =  storyboard.instantiateViewController(withIdentifier: "SMADIntersitialViewController") as! SMADIntersitialViewController
        intersitialViewController.modalPresentationStyle = .overCurrentContext
        intersitialViewController.hidesBottomBarWhenPushed = true
        
        //Pass data
        intersitialViewController.model = response
        intersitialViewController.delegate = self.delegate
        rootViewController.present(intersitialViewController, animated: false, completion: nil)
    }
    
    public var isReady: Bool = false
    
    public var hasBeenUsed: Bool = false
    
    public var responseInfo: SMADResponseInfo?
    
    private func setResponseInfo(_ response: SMADResponseInfo) {
        self.responseInfo = response
    }
    
}
