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

open class SMADRequest: NSObject {
    
    private var orientation = ""
    private var device_type = "iphone"
    open var baseParam:[String:Any] = [:]
    
    private var bundleID:String = "alex.test.packagename"
    open var urlRequest:String = ""
    
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
        
        baseParam = ["package_name":bundleID,
                     "lang":NSLocale.preferredLanguages[0],
                     "location":(Locale.current as NSLocale).object(forKey: .countryCode) as? String ?? "",
                     "orientation":orientation,
                     "device_type":device_type,
                     "ios_version":"\(UIDevice.current.systemVersion)",
            "ifa":"\(ASIdentifierManager.shared().advertisingIdentifier.uuidString)",
            "uuid":"\((UIDevice.current.identifierForVendor?.uuidString)!)",
            "system":"ios",
            "sdk_version":"1.0"]
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
