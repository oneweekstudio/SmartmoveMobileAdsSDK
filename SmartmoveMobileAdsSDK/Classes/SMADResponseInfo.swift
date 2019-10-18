//
//  SMADResponseInfo.swift
//  Pods
//
//  Created by Hintoro on 10/18/19.
//

import Foundation
import Alamofire
import MagicMapper
import AdSupport


/*
 {
     "error": 0,
     "data": [
         {
             "icon": "http://cpibe.appboom.net/uploads/cpi/avatar/1563430684.jpg",
             "campaign_id": 21675,
             "name": "Ringtones for iPhone",
             "assets": [
                 {
                     "url": "http://cpibe.appboom.net/api/v2/get_image?id=21675&size=300x250&country_code=US&system=ios&ios_version=12.4",
                     "width": "300",
                     "height": "250",
                     "link": "http://cpibe.appboom.net/api/v2/click_campaign?campaign=21675&package_name=alex.test.packagename&country_code=US&system=ios&ios_version=12.4&size=300x250"
                 }
             ],
             "desc": "Get 1000+ free music ringtones for your phone"
         }
     ]
 }**/


@objcMembers
open class SMADResponseInfo : NSObject, Mappable{
    public var error: Int = 0
    public var data: [SMADCampaign] = []
}

@objcMembers
open class SMADCampaign : NSObject, Mappable {
    public var icon: String = ""
    public var campaign_id: Int = 0
    public var name: String = ""
    public var assets: [SMADAsset] = []
    public var desc: String = ""
}

@objcMembers
open class SMADAsset : NSObject, Mappable {
    public var url: String = ""
    public var width: String = ""
    public var height: String = ""
    public var link: String = ""
}
