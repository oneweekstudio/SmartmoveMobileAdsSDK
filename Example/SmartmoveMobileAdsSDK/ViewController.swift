//
//  ViewController.swift
//  SmartmoveMobileAdsSDK
//
//  Created by oneweekstudio on 10/18/2019.
//  Copyright (c) 2019 oneweekstudio. All rights reserved.
//

import UIKit
import SmartmoveMobileAdsSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Run")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        let smadInterstitial = SMADInterstitial.init()
        let request = SMADRequest()
        smadInterstitial.load(request)
        
    }
}

