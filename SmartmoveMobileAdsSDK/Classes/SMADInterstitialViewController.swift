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
    
    @IBOutlet weak var vContainer: UIView?
    @IBOutlet weak var btnGetApp: UIButton?
    
    public var model: Any?
    private var smadAnalytics:SMADAnalytics?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.configUI()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction
    func actionTapClose(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction
    func actionTapGetApp(_ sender: Any) {
        //Request
        self.smadAnalytics?.request({ (str) in
            log.debug("URL Analytics : \(str)")
        }, failureHandler: { (error) in
            log.debug("Error : \(error)")
        })
        
    }
    
    func configUI() {
        self.imvIcon?.layer.cornerRadius = 8 * 2
        self.imvIcon?.clipsToBounds = true
        
        self.vContainer?.layer.cornerRadius = 8
        self.vContainer?.clipsToBounds = true
        
        self.btnGetApp?.layer.cornerRadius = 15
        self.btnGetApp?.clipsToBounds = true
        
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
        
        self.smadAnalytics = SMADAnalytics.init(url: asset.link)
    }
    
}
