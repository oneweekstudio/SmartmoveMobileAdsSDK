//
//  SMNativeViewController.swift
//  SmartmoveMobileAdsSDK
//
//  Created by Hintoro on 10/22/19.
//


import Foundation
import UIKit
import SafariServices


/*
    - Chú ý: Controller này chỉ xử lý deeplink
 
 */
public class SMADNativeViewController : UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    //Để vào trong thằng này 1 object, test thì để 1 cái string
    var dynamicLink: String?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.load()
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}


//Function
extension SMADNativeViewController : SFSafariViewControllerDelegate     {
    
    func load() {
        
        if SMADMobileAds.isDebug {
            self.dynamicLink = "https://flyingfacev2.page.link/test"
        }
        
        guard
            let link = self.dynamicLink,
            let url = URL.init(string: link)
            else { return }
        
        let urlRequest = URLRequest.init(url: url)
        self.redirectLink(URLRequest: urlRequest)
        
    }
    
    func redirectLink( URLRequest request: URLRequest) {
        self.webView.delegate = self
        self.webView.loadRequest(request)
    }
    
}

extension SMADNativeViewController : UIWebViewDelegate {
    private func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Load success")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    private func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("webView : \(error)")
    }
}

