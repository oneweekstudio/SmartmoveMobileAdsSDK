//
//  SMADInterstitialViewController.swift
//  SmartmoveMobileAdsSDK
//
//  Created by Hintoro on 10/21/19.
//

import Foundation
import UIKit
import SDWebImage

public class SMADIntersitialViewController : UIViewController {
    
    @IBOutlet weak var imvIcon: UIImageView?
    @IBOutlet weak var imvBackground: UIImageView?
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblDes: UILabel?
    
    public var model: Any?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    @IBAction
    func actionTapClose(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
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
        
        let iconURL = URL.init(string: campaign.icon)
        self.imvIcon?.sd_setImage(with: iconURL, completed: nil)
        
        guard let asset = campaign.assets.first else { return }
        let backgroundImageURL = URL.init(string: asset.url)
        self.imvBackground?.sd_setImage(with: backgroundImageURL, completed: nil)
    }
    
}
