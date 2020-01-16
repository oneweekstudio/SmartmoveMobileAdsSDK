//
//  SMADNativeDelegate.swift
//  SmartmoveMobileAdsSDK
//
//  Created by OW01 on 1/16/20.
//

import Foundation

public protocol SMADNativeDelegate {
     func nativeDidReceiveAd(_ ad: SMADInterstitial)
     func native(_ ad: SMADNative, didFailToReceiveAdWithError error: Error)
     func nativeDidClose()
     func nativeDidClickAd()
}
