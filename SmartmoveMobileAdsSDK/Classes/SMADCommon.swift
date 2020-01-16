//
//  SMADCommon.swift
//  SmartmoveMobileAdsSDK
//
//  Created by Hintoro on 10/21/19.
//

import Foundation

public enum SMADSupportLink : String {
    case dynamic = "https"
    case itune = "itune"
    case other = "other"
}

public func getBundlePath() -> Bundle {
    let pathBundle = Bundle.main.path(forResource: "SmartmoveMobileAdsSDK", ofType: "bundle")
    let bundle = Bundle(path: pathBundle ?? "")!
    return bundle
}


public class SMADCommon : NSObject {
    
    
    public static let shared = SMADCommon()
    
    //Kiểm tra có phải dynamic link không
    public func isDynamicURL(str: String) -> SMADSupportLink {
        if str.contains("itms") {
            return .itune
        } else if str.contains("page.link") && str.contains("http") {
            return .dynamic
        } else {
            return .other
        }
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
    public func openDeepLink( from controller: UIViewController, link: String = "https://flyingfacev2.page.link/test", nativeDidCloseBlock: (() -> Void)? = nil) {
        let nativeViewController = UIStoryboard.init(name: "SMADNative", bundle: getBundlePath()).instantiateViewController(withIdentifier: "SMADNativeViewController") as! SMADNativeViewController
        nativeViewController.modalPresentationStyle = .overCurrentContext
        nativeViewController.dynamicLink = link
        nativeViewController.nativeDidCloseBlock = {
            nativeDidCloseBlock?()
        }
        controller.present( nativeViewController, animated: false)
    }
    
    public func showError(rootViewController: UIViewController, message: String = "Link truyền vào bị sai", completionHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Lỗi", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {action in
            alert.dismiss(animated: true, completion: nil)
            completionHandler?()
        }))
        
        rootViewController.present(alert, animated: true)
    }
    
    
}
