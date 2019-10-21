//
//  SMADCommon.swift
//  SmartmoveMobileAdsSDK
//
//  Created by Hintoro on 10/21/19.
//

import Foundation


public func getBundlePath() -> Bundle {
    let pathBundle = Bundle.main.path(forResource: "SmartmoveMobileAdsSDK", ofType: "bundle")
    let bundle = Bundle(path: pathBundle ?? "")!
    return bundle
}
