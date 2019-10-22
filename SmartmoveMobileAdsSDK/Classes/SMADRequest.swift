//
//  SMADRequest.swift
//  Pods
//
//  Created by Hintoro on 10/18/19.
//

import Foundation
import Alamofire
import MagicMapper
import AdSupport


public enum SMADRequestOption : String {
    case random = "random"
    case quota = "quota"
}

public enum SMADFormat : String {
    case full = "full"
    case banner = "banner"
    case native = "native"
}


open class SMADRequest: NSObject {
    
    private var orientation = ""
    private var device_type = "iphone"
    private var bundleID:String = "alex.test.packagename"
    
    open  var adFormat: SMADFormat = .full
    
    open var baseParam:[String:Any] = [:]

    open var urlRequest:String = ""
    
    open var adRequestOption:SMADRequestOption = .random
    
    public override init() {
        super.init()
        if UIDevice.current.orientation.isLandscape {
            orientation = "landscape"
        }else{
            orientation = "portrait"
        }
        if UIDevice.current.userInterfaceIdiom == .pad{
            device_type = "ipad"
        }else{
            device_type = "iphone"
        }
        
        bundleID = SMADMobileAds.isDebug ? "alex.test.packagename" : Bundle.main.bundleIdentifier!
        log.debug("Debug mode = \(SMADMobileAds.isDebug) : \(bundleID)")
        baseParam = ["package_name":bundleID,
                     "lang":NSLocale.preferredLanguages[0],
                     "location":(Locale.current as NSLocale).object(forKey: .countryCode) as? String ?? "",
                     "orientation":orientation,
                     "device_type":device_type,
                     "ios_version":"\(UIDevice.current.systemVersion)",
            "ifa":"\(ASIdentifierManager.shared().advertisingIdentifier.uuidString)",
            "uuid":"\((UIDevice.current.identifierForVendor?.uuidString)!)",
            "system":"ios",
            "sdk_version":"1.0",
            "option":"\(adRequestOption.rawValue)",
            "format":"\(adFormat.rawValue)"
            ]
    }
    
    func load(completionHandler: ((Any) -> Void)? = nil , failureHandler: ((Error) -> Void)? = nil ){
        Alamofire.request(self.urlRequest, method: .get, parameters: self.baseParam)
            .responseJSON {response in
                switch (response.result){
                case.success(let data):
                    completionHandler?(data)
                    break
                case .failure(let error):
                    log.debug(error)
                    failureHandler?(error)
                    break
                }
        }
    }
}
