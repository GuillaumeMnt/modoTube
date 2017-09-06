//
//  Constants.swift
//  modoTube
//
//  Created by Guillaume Monot on 7/20/17
//  Copyright (c) 2017 mobizel. All rights reserved.
//

import UIKit

enum Constants {

    // MARK: - UITextField
    enum UITextField {
        static let padding: CGFloat = 16.0
    }
    
    enum Webservice {
        
        /// items limit = 300
        static let limit: Int = 300
        
        /// Test user connexion
        static let internetURL: URL? = URL(string: "https://encrypted.google.com")
    }
}
