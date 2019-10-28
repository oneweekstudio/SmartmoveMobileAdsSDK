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
    
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var webView: UIWebView!
    
    //Để vào trong thằng này 1 object, test thì để 1 cái string
    var dynamicLink: String?
    var countdown = 5
    var timer: Timer?

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.load()
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    @objc func willResignActive() {
        log.debug("UIApplicationDidEnterBackground: -> Ẩn controller xử lý deeplink ")
        log.debug("Đóng SMADNativeViewController")
        self.timer?.invalidate()
        self.dismiss(animated: false, completion: {
            NotificationCenter.default.post(name: NSNotification.Name.init("DidfinshLoad"), object: nil)
        })
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        
        log.debug("URL: = \(link)")
        let urlRequest = URLRequest.init(url: url)
        self.redirectLink(URLRequest: urlRequest)
        
    }
    
    func redirectLink( URLRequest request: URLRequest) {
        self.webView.delegate = self
        self.webView.loadRequest(request)
    }
    
}

extension SMADNativeViewController : UIWebViewDelegate {
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        log.debug("webViewDidStartLoad")

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
    }
    
    private func webViewDidFinishLoad(_ webView: UIWebView) {
        log.debug("webViewDidFinishLoad")
    }
    
    private func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        log.debug("didFailLoadWithError: \(error)")
    }
    
    @objc func updateCounter() {
        self.countdown -= 1
        log.debug("Time left: \(self.countdown)")
        self.lblTitle?.text = "Remaining \(self.countdown)"
        if countdown == 0 {
            self.timer?.invalidate()
            self.countdown = 5
            SMADCommon.shared.showError(rootViewController: self, message: "Deep link chưa được sử dụng") {
                self.willResignActive()
            }
        }
    }

}

