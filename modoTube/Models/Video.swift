//
//  MTubeVideo.swift
//  modoTube
//
//  Created by Guillaume on 20/07/2017.
//  Copyright © 2017 mobizel. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire
import RealmSwift
import ObjectMapper
import AlamofireObjectMapper

class Video: Object, Mappable {
    
    // MARK: - Global
    
    // MARK: - Internal
    dynamic internal var identifier: String = ""
    dynamic internal var title: String?
    dynamic internal var subtitle: String?
    dynamic internal var imageURL: String?
    dynamic internal var isChannel: Bool = false
    dynamic internal var isPlaylist: Bool = false
    dynamic internal var detailVideo: Length?
    
    // MARK: - Mappable
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.title          <- map["snippet.title"]
        self.subtitle       <- map["snippet.description"]
        self.imageURL       <- map["snippet.thumbnails.default.url"]
        if map["id.channelId"].isKeyPresent {
            self.isChannel = true
            self.identifier <- map["id.channelId"]
        } else if map["id.videoId"].isKeyPresent {
            self.identifier <- map["id.videoId"]
        } else if map["id.playlistId"].isKeyPresent {
            self.isPlaylist = true
            self.identifier <- map["id.playlistId"]
        }
    }
    
    // MARK: - Model meta informations
    override class func primaryKey() -> String? {
        return "identifier"
    }
    
    override class func ignoredProperties() -> [String] {
        return []
    }
}

// MARK: - MTubeVideo
extension Video {
    
    // MARK: - Network call
    func fetchDuration() {
        
        let duration: Length = Length()
        logger.verbose(self.identifier)
        duration.fetchVideoLengthInformation(videoId: self.identifier, responseHandler: { (status) in
            if status {
                duration.addToRealm()
            }
        })
    }
    
    // MARK: - Privates Functions
    
    // MARK: - Public Functions
}
