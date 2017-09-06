//
//  Length.swift
//  modoTube
//
//  Created by Guillaume on 25/07/2017.
//  Copyright © 2017 mobizel. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import SwiftyJSON
import PKHUD
import ObjectMapper
import AlamofireObjectMapper

class Length: Object, Mappable {

    // MARK: - Global

    // MARK: - Internal
    dynamic internal var identifier: String?
    dynamic internal var duration: String?
    
    // MARK: - Mappable
    convenience required init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        self.identifier <- map["id"]
        var tmpDuration: String = String()
        tmpDuration <- map["contentDetails.duration"]
        self.duration = tmpDuration.getYoutubeFormattedDuration()
    }

    // MARK: - Model meta informations
//    override class func primaryKey() -> String? {
//        return "identifier"
//    }

    override class func ignoredProperties() -> [String] {
        return []
    }
}

// MARK: - Length
extension Length {

    // MARK: - Network call
    func fetchVideoLengthInformation(videoId: String, responseHandler: ((Bool) -> Void)? = nil) {
        
//        print("videoId = \(videoId)")
        let parameters: Parameters = [
            "key": YoutubeAPI.Keys.secret,
            "part": "contentDetails",
            "id": videoId
        ]
        
        Alamofire.request(YoutubeAPI.baseURL + YoutubeAPI.detailVideo, method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
//            .responseJSON { response in
//                print("Request: \(response.request)")
//                print("Response: \(response.response)")
//                print("Error: \(response.error)")
//                if response.response?.statusCode == 200 {
//                    if let serverData = response.result.value {
//                        let json = JSON(serverData)
//                        logger.verbose(json)
//                    }
//                }
//            }
            .responseArray(keyPath: "items") { (response: DataResponse<[Length]>) in
                
                let videoArray = response.result.value
                if let newArrayOfVideo = videoArray {
                    for video in newArrayOfVideo {
//                      logger.verbose(video)
                        video.addToRealm()
                    }
                    responseHandler?(true)
                } else {
                    responseHandler?(false)
                }
        }
    }
    
    // MARK: - Privates Functions

    // MARK: - Public Functions
}
