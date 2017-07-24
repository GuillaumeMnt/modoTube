//
//  MTubeAPI.swift
//  modoTube
//
//  Created by Guillaume Monot on 24/7/17
//  Copyright (c) 2017 mobizel. All rights reserved.
//

import Foundation

// TODO: 📝 Fill modoTube's API URL

/*
** ⚠️ Supprimer la configuration ATS dans `info.plist` ⚠️
*/

/// modoTube's API
enum modoTubeAPI {

    /**
     API base URL
     - URL = https://
     */
    static let baseURL: String = "https://"

    ///
    static let test: String = "/test"
}

/// modoTube's URL
enum modoTubeURL {

    /// Facebook
    static let facebook: URL? = URL(string: "https://facebook.com/modoTube")
}

// MARK: - modoTube's API Debug
enum modoTubeAPIDebug {

    /// Test account
    enum Account {
        static let username: String = ""
        static let password: String = ""
    }
}
