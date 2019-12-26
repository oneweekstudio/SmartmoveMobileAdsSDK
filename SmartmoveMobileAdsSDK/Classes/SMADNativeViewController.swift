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

class TimerManager : NSObject {
    
    static let `default` = TimerManager()
    
    var updateBlock: ((String) -> Void)?
    var finishBlock: (() -> Void)?
    
    private var countdown = 5
    private var timer: Timer? = nil
    
    private var isLoaded: Bool = false
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func startTimer() {
        if isLoaded == false {
            print("Start timer")
            DispatchQueue.main.async {
                self.stopTimer()
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
            }
            isLoaded = true
        }

    }
    
    @objc private func updateCounter() {
        DispatchQueue.main.async {
            self.countdown -= 1
            print("Shot : \(self.countdown)")
            self.updateBlock?("Remaining \(self.countdown)")
            if self.countdown <= 0 {
                self.timer?.invalidate()
                self.timer = nil
                self.countdown = 5
                self.finishBlock?()
                self.isLoaded = false
                print("Kill timer")
            }
        }
    }
    
}


public class SMADNativeViewController : UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var webView: UIWebView!
    
    //Để vào trong thằng này 1 object, test thì để 1 cái string
    var dynamicLink: String?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.load()
        TimerManager.default.stopTimer()
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        TimerManager.default.updateBlock = { [weak self] str in
            guard let `self` = self else { return }
            self.lblTitle?.text = str
        }
        
        TimerManager.default.finishBlock = {
            if self.webView != nil {
                self.webView.removeFromSuperview()
            }
            self.willResignActive()
        }
        
    }
    
    @objc func willResignActive() {
        print("UIApplicationDidEnterBackground: -> Ẩn controller xử lý deeplink ")
        print("Đóng SMADNativeViewController")
        TimerManager.default.stopTimer()
        self.dismiss(animated: false, completion: {
            
            NotificationCenter.default.post(name: NSNotification.Name.init("DidfinshLoad"), object: nil)
        })
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        TimerManager.default.stopTimer()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.webView != nil {
            self.webView.removeFromSuperview()
        }
        TimerManager.default.stopTimer()
    }
}


//Function
extension SMADNativeViewController : SFSafariViewControllerDelegate     {
    
    func load() {
        
        //        if SMADMobileAds.isDebug {
        //            self.dynamicLink = "https://flyingfacev2.page.link/test"
        //        }
        
        guard
            let link = self.dynamicLink,
            let url = URL.init(string: link)
            else { return }
        
        print("URL: = \(link)")
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
        // print("webViewDidStartLoad")
        TimerManager.default.startTimer()
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        // print("webViewDidFinishLoad")
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        //print("didFailLoadWithError: \(error)")
    }
    
    
    
}
