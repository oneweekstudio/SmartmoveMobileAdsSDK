//
//  SMADInterstitialViewController.swift
//  SmartmoveMobileAdsSDK
//
//  Created by Hintoro on 10/21/19.
//

import Foundation
import UIKit

public class SMADIntersitialViewController : UIViewController {
    
    @IBOutlet weak var imvIcon: UIImageView?
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblDes: UILabel?
    
    public var model: Any?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction
    func actionTapClose(_ sender: Any) {
        
    }
    
    @IBAction
    func actionTapGetApp(_ sender: Any) {
        
    }
    
}


extension SMADIntersitialViewController {
    
    private func loadData() {
        guard let response = model as? SMADResponseInfo,
            let campaign = response.data.first
        else {
            self.dismiss(animated: false, completion: nil)
            return }
        
        self.lblTitle?.text = campaign.name
        self.lblDes?.text = campaign.desc
        
        
    }
    
}
