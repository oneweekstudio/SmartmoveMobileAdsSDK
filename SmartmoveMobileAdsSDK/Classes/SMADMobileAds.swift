//
//  SMADMobileAds.swift
//  Pods
//
//  Created by Hintoro on 10/18/19.
//

import Foundation
@objc public protocol SMADMobileAdsProtocol {
    
  @objc optional  func load(_ request: SMADRequest)
    func present(fromRootViewController rootViewController: UIViewController)
    
    var isReady: Bool { get }
    var hasBeenUsed: Bool { get }
    var responseInfo: SMADResponse? { get }
}


public class SMADMobileAds : SMADMobileAdsProtocol {
    
}
