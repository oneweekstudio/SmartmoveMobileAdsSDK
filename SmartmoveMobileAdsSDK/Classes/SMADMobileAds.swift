//
//  SMADMobileAds.swift
//  Pods
//
//  Created by Hintoro on 10/18/19.
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

public class SMADMobileAds : NSObject {
    
    static var isDebug: Bool = false
    static let kSMADGetCampaign = "http://cpibe.appboom.net/api/v2/get_campaign"

    public class func setDebug(_ isDebug:Bool = true){
        self.isDebug = isDebug
        log.debug("Debug mode: \(isDebug)")
    }
    
    public class func config(_ enableDebug:Bool = true) {
        let console = ConsoleDestination()
        log.addDestination(console)
        self.isDebug = enableDebug
    }
    
}
