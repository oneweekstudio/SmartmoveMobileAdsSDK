//
//  SMADCommon.swift
//  SmartmoveMobileAdsSDK
//
//  Created by Hintoro on 10/21/19.
//

import Foundation


public func getBundlePath() -> Bundle {
    let pathBundle = Bundle.main.path(forResource: "SmartmoveMobileAdsSDK", ofType: "bundle")
    let bundle = Bundle(path: pathBundle ?? "")!
    return bundle
}


public class SMADCommon : NSObject {
    
    
    public static let shared = SMADCommon()
    
    //Kiểm tra có phải dynamic link không
    public func isDynamicURL(str: String) -> Bool {
        return !str.contains("itms")
    }
    
    //Khi link nhận được từ campaign là một link "itms" -> Chuyển sang appstore
    public func openAppStore(itms: String) {
        if let url = URL(string: itms),
            UIApplication.shared.canOpenURL(url){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:]) { (opened) in
                    if(opened){
                        print("App Store Opened")
                    }
                }
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
            }
        } else {
            print("Can't Open URL on Simulator")
        }
    }
    
    
    //Khi link nhận được từ campaign là một link dạng "dynamic link" -> Chuyển đến controller SMNativeController để xử lý deeplink
    public func openDeepLink( UIController controller: UIViewController, link: String = "https://flyingfacev2.page.link/test") {
        let nativeViewController = UIStoryboard.init(name: "SMADNative", bundle: getBundlePath()).instantiateViewController(withIdentifier: "SMADNativeViewController") as! SMADNativeViewController
        nativeViewController.modalPresentationStyle = .overCurrentContext
        controller.present( nativeViewController, animated: false)
    }


    
}
