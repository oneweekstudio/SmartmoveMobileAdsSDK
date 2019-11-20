//
//  SMADNative.swift
//  Pods
//
//  Created by Hintoro on 10/18/19.
//

import Foundation
import Alamofire
import MagicMapper
import AdSupport

open class SMADNative : NSObject {
    
    private var smadAnalytics:SMADAnalytics?
    
    public override init() {
        super.init()
    }
    
    public func load(_ request: SMADRequest) {
        //Code
        var params = request.baseParam
        params.updateValue("1", forKey: "number")
        params.updateValue("random", forKey: "option")
        
        if SMADMobileAds.shared.isDebug {
            log.debug("SanboxMode: SMADNative load...")
            request.urlRequest = SMADMobileAds.kSMADGetCampaignSanbox
        } else {
            log.debug("ProductionMode: SMADNative load...")
            request.urlRequest = SMADMobileAds.kSMADGetCampaign
        }
        
        request.load(completionHandler: { (json) in
            //Get json
            if let data = json as? KeyValue {
                let response = SMADResponseInfo(data)
                self.setResponseInfo(response)
                self.smadAnalytics = SMADAnalytics()
            }
        }) { (error) in
            //Error
        }
    }
    
    public func load(_ request: SMADRequest, completionHandler :@escaping () -> Void, faillureHandler: @escaping () -> Void) {
        //Code
        var params = request.baseParam
        params.updateValue("1", forKey: "number")
        params.updateValue("random", forKey: "option")
        
        if SMADMobileAds.shared.isDebug {
            log.debug("SanboxMode: SMADNative load...")
            request.urlRequest = SMADMobileAds.kSMADGetCampaignSanbox
        } else {
            log.debug("ProductionMode: SMADNative load...")
            request.urlRequest = SMADMobileAds.kSMADGetCampaign
        }
        
        request.load(completionHandler: { (json) in
            //Get json
            if let data = json as? KeyValue {
                let response = SMADResponseInfo(data)
                self.setResponseInfo(response)
                self.smadAnalytics = SMADAnalytics()
                completionHandler()
            }
        }) { (error) in
            //Error
            faillureHandler()
        }
    }
    
    
    public func present(fromRootViewController rootViewController: UIViewController) {
        //Code show dialog
        
        
    }
    
    public func showDialog(fromRootViewController rootViewController: UIViewController, titleCancel: String = "Cancel", titleSubmit: String = "Get it!", success:@escaping (Bool) -> Void) {
        
        guard let response = self.responseInfo,
            let campaign = response.data.first
            else {
                //                self.showAlertError(rootViewController: rootViewController, title: "Campaign lỗi", message: "Xin vui lòng kiểm tra lại campaign")
                return }
        if let asset = campaign.assets.first  {
            //            self.showAlertError(rootViewController: rootViewController)
            
            
            let size = "\(asset.width)x\(asset.height)"
            smadAnalytics?.requestViewAd(campaign_id: campaign.campaign_id, size: size)
            
            let alert = UIAlertController(title: campaign.name, message: campaign.desc, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: titleSubmit, style: .default, handler: {action in
                success(true)
                self.getAppAction(fromRootViewController: rootViewController, content: self.responseInfo)
            }))
            alert.addAction(UIAlertAction(title: titleCancel, style: .cancel, handler: {action in
                success(false)
                alert.dismiss(animated: true, completion: nil)
            }))
            
            rootViewController.present(alert, animated: true)
            
        } else {
            let size = "no-banner"
            smadAnalytics?.requestViewAd(campaign_id: campaign.campaign_id, size: size)
            
            let alert = UIAlertController(title: campaign.name, message: campaign.desc, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: titleSubmit, style: .default, handler: {action in
                success(true)
                self.getAppAction(fromRootViewController: rootViewController, content: self.responseInfo)
            }))
            alert.addAction(UIAlertAction(title: titleCancel, style: .cancel, handler: {action in
                success(false)
                alert.dismiss(animated: true, completion: nil)
            }))
            
            rootViewController.present(alert, animated: true)
        }
        
        
    }
    
    public var isReady: Bool = false
    
    public var hasBeenUsed: Bool = false
    
    public var responseInfo: SMADResponseInfo?
    
    private func setResponseInfo(_ response: SMADResponseInfo) {
        self.responseInfo = response
    }
    
    public func getAppAction(fromRootViewController rootViewController: UIViewController, content: Any?) {
        
        guard let response = content as? SMADResponseInfo,
            let campaign = response.data.first
            else {
                return }
        guard let asset = campaign.assets.first else {
            let size = "no-banner"
            smadAnalytics?.requestClickAd(campaign_id: campaign.campaign_id, size: size)
            return }
        
        let size = "\(asset.width)x\(asset.height)"
        smadAnalytics?.requestClickAd(campaign_id: campaign.campaign_id, size: size)
        
        self.redirect(asset: asset, rootViewController: rootViewController)
    }
    
    public func redirect(asset: SMADAsset, rootViewController: UIViewController) {
        switch SMADCommon.shared.isDynamicURL(str: asset.link) {
        case .dynamic:
            log.debug("Deep link: \(asset.link)")
            SMADCommon.shared.openDeepLink(from: rootViewController, link: asset.link)
            break
        case .itune :
            log.debug("Appstore link: \(asset.link)")
            SMADCommon.shared.openAppStore(itms: asset.link)
            break
        default:
            log.debug("Không phải link hỗ trợ: \(asset.link)")
            SMADCommon.shared.showError(rootViewController: rootViewController)
            break
        }
    }
    
    public func showAlertError(rootViewController: UIViewController, title: String = "Lỗi không có asset", message: String = "Không có asset, hãy yêu cầu nhập campaign có asset") {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        rootViewController.present(alert, animated: true)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            alert.dismiss(animated: true, completion: nil)
        }))
    }
    
}
