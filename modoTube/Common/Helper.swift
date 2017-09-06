//
//  Helper.swift
//  modoTube
//
//  Created by Guillaume on 29/08/2017.
//  Copyright © 2017 mobizel. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire
import SwiftyJSON

class Helper {

    /// Check internet connexion
    static func canAccessInternet(responseHandler: ((Bool) -> Void)? = nil) {
        if let url = Constants.Webservice.internetURL {
            Alamofire.request(url)
                .response(completionHandler: { response in
                    responseHandler?(!((response.response?.statusCode) == nil))
                })
        }
    }
}
    
