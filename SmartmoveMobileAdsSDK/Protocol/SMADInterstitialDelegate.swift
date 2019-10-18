//
//  SMADInterstitialDelegate.swift
//  Pods
//
//  Created by Hintoro on 10/18/19.
//

import Foundation
@objc public protocol SMADInterstitialDelegate {
    @objc optional func interstitialDidReceiveAd(_ ad: SMADInterstitial)
}
