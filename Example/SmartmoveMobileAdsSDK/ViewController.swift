//
//  ViewController.swift
//  SmartmoveMobileAdsSDK
//
//  Created by oneweekstudio on 10/18/2019.
//  Copyright (c) 2019 oneweekstudio. All rights reserved.
//

import UIKit
import SmartmoveMobileAdsSDK
import PKHUD

class ViewController: UIViewController, SMADInterstitialDelegate {
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDes:UILabel!
    
    var campaign: SMADCampaign! {
        didSet {
            
        }
        
    }
    
    let smadInterstitial = SMADInterstitial.init()
    let smadNative = SMADNative()
    
    func interstitialDidReceiveAd(_ ad: SMADInterstitial) {
        if let cam = ad.responseInfo?.data.first {
            self.campaign = cam
            self.lblTitle.text = self.campaign.name
            self.lblDes.text = self.campaign.desc
        } else {
            print("Error")
        }
        
        
    }
    
    func interstitial(_ ad: SMADInterstitial, didFailToReceiveAdWithError error: Error) {
        print(error)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Run")
        self.load()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    @IBAction
    func loadIntersitial(_ sender: Any) {
        self.smadInterstitial.present(fromRootViewController: self)
    }
    
    @IBAction
    func reloadSMADIntersitial(_ sender: Any) {
        HUD.show(.labeledProgress(title: nil, subtitle: "Please wait ..."), onView: self.view)
        let request = SMADRequest()
        smadInterstitial.delegate = self
        smadInterstitial.load(request, completionHandler: {
            print("Reload success")
            HUD.hide()
        }) {
            print("Reload faillure")
            HUD.hide()
        }
    }
    
    @IBAction
    func loadNative(_ sender: Any) {
        HUD.show(.labeledProgress(title: nil, subtitle: "Please wait ..."), onView: self.view)
        let request = SMADRequest()
        smadNative.load(request, completionHandler: {
            HUD.hide()
            self.smadNative.showDialog(fromRootViewController: self) { (success) in
            }
        }) {
            HUD.hide()
        }
    }
    
    func load() {
        let request = SMADRequest()
        smadInterstitial.delegate = self
        smadInterstitial.load(request)
    }
}


