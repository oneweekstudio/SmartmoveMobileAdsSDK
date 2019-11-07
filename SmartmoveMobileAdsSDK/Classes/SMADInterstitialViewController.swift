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
    private var smadAnalytics = SMADAnalytics()
    open var delegate: SMADInterstitialDelegate?
    
    private var isViewAnimated = false
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.configUI()
        NotificationCenter.default.addObserver(self, selector: #selector(self.close), name: NSNotification.Name.init("DidfinshLoad"), object: nil)
    }
    
    @objc func close() {
        UIView.animate(withDuration: 0.2, animations: {
            guard let container = self.vContainer else { return }
            container.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) { (status) in
            log.debug("Đóng SMADIntersitialViewController")
            self.dismiss(animated: false, completion: {
                log.debug("Đóng quảng cáo full thành công")
                self.delegate?.interstitialDidCloseController()
            })
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isViewAnimated {
            guard let vContainer = self.vContainer else { return }
            self.isViewAnimated = true
            vContainer.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                vContainer.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { success in
            })
        }
    }
    
    @IBAction
    func actionTapClose(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            guard let container = self.vContainer else { return }
            container.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) { (status) in
            log.debug("Đóng SMADIntersitialViewController")
            self.dismiss(animated: false, completion: {
                log.debug("Đóng quảng cáo full thành công")
                 self.delegate?.interstitialDidCloseController()
            })
        }
    }
    
    @IBAction
    func actionTapGetApp(_ sender: Any) {
        //Request
        guard let response = model as? SMADResponseInfo,
            let campaign = response.data.first
            else {
                self.dismiss(animated: false, completion: nil)
                return }
        guard let asset = campaign.assets.first else {
            let size = "no-banner"
            smadAnalytics.requestClickAd(campaign_id: campaign.campaign_id, size: size)
            return }
        
        let size = "\(asset.width)x\(asset.height)"
        smadAnalytics.requestClickAd(campaign_id: campaign.campaign_id, size: size)
        
        self.redirect(asset: asset)
        
    }
    
    public func redirect(asset: SMADAsset) {
        switch SMADCommon.shared.isDynamicURL(str: asset.link) {
        case .dynamic:
            //            log.debug("Deep link: \(asset.link)")
            SMADCommon.shared.openDeepLink(from: self, link: asset.link)
            break
        case .itune :
            //            log.debug("Appstore link: \(asset.link)")
            SMADCommon.shared.openAppStore(itms: asset.link)
            break
        default:
            log.debug("Không phải link hỗ trợ: \(asset.link)")
            SMADCommon.shared.showError(rootViewController: self)
            break
        }
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
        
        guard let asset = campaign.assets.first else {
            let size = "no-banner"
            smadAnalytics.requestViewAd(campaign_id: campaign.campaign_id, size: size)
            return }
        let backgroundImageURL = URL.init(string: asset.url)
        self.imvBackground?.sd_setImage(with: backgroundImageURL, completed: nil)
        
        let size = "\(asset.width)x\(asset.height)"
        smadAnalytics.requestViewAd(campaign_id: campaign.campaign_id, size: size)
        
    }
    
}
