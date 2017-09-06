//
//  Environment.swift
//  modoTube
//
//  Created by Guillaume on 20/07/2017.
//  Copyright © 2017 mobizel. All rights reserved.
//

import UIKit

/*
 ** Get your API ID by clicking that link, it will give you your id, you only need a Google account.
 ** Your key is private
 ** https://console.developers.google.com/projectselector/apis/credentials
 */
 
enum YoutubeAPI {
    static let baseURL: String = "https://www.googleapis.com/youtube/v3/"
    
    static let search: String = "search"

    static let detailVideo: String = "videos"
    
    enum Keys {
        static let secret: String = "" // TODO: 📝 Get your Youtube API Key

    }
    
    enum Url {
        static let video: String = "http://www.youtube.com/video/"
        
        static let channel: String = "http://www.youtube.com/channel/"
        
        static let playlist: String = "http://www.youtube.com/playlist/"
    }
}
