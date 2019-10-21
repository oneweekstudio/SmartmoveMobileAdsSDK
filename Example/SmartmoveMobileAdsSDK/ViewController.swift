//
//  ViewController.swift
//  SmartmoveMobileAdsSDK
//
//  Created by oneweekstudio on 10/18/2019.
//  Copyright (c) 2019 oneweekstudio. All rights reserved.
//

import UIKit
import SmartmoveMobileAdsSDK

class ViewController: UIViewController, SMADInterstitialDelegate {
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDes:UILabel!
    
    var campaign: SMADCampaign! {
        didSet {
            self.lblTitle.text = self.campaign.name
            self.lblDes.text = self.campaign.desc
        }
        
    }
    
    let smadInterstitial = SMADInterstitial.init()
    
    
    func interstitialDidReceiveAd(_ ad: SMADInterstitial) {
        
        if let cam = ad.responseInfo?.data.first {
            self.campaign = cam
        }
        
        
    }
    
    func interstitial(_ ad: SMADInterstitial, didFailToReceiveAdWithError error: Error) {
        
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
        
    }
    
    @IBAction
    func loadIntersitial(_ sender: Any) {
        self.smadInterstitial.present(fromRootViewController: self)
    }
    
    func load() {
        let request = SMADRequest()
        smadInterstitial.delegate = self
        smadInterstitial.load(request)
    }
}


