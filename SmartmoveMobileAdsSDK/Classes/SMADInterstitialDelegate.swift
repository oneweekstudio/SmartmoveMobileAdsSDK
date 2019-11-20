//
//  SMADInterstitialDelegate.swift
//  Pods
//
//  Created by Hintoro on 10/18/19.
//

import Foundation
public protocol SMADInterstitialDelegate {
    
    //Called when an interstitial ad request succeeded. Show it at the next transition point in your application such as when transitioning between view controllers.

    func interstitialDidReceiveAd(_ ad: SMADInterstitial)
    
    
    //Called when an interstitial ad request completed without an interstitial to show. This is common since interstitials are shown sparingly to users.


    func interstitial(_ ad: SMADInterstitial, didFailToReceiveAdWithError error: Error)
    
    func interstitialDidClose()
    func interstitialDidClickAd()

}
