//
//  Extensions.swift
//  modoTube
//
//  Created by Guillaume Monot on 7/20/17
//  Copyright (c) 2017 mobizel. All rights reserved.
//

import UIKit
import Foundation
import KeychainSwift
import SafariServices

// MARK: UITextField
extension UIViewController {
    
    /// change root viewController
    func changeRootViewControllerTo(_ newRootViewController: UIViewController) {
        navigationController?.viewControllers = [newRootViewController]
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    /// Keychain functions
    final func saveDataToKeychain(_ value: String, forKey key: String) {
        let keychain = KeychainSwift()
        
        keychain.set(value, forKey: key, withAccess: .accessibleWhenUnlockedThisDeviceOnly)
    }
    
    final func getDataFromKeychain(forKey key: String) -> String? {
        let keychain = KeychainSwift()
        
        return keychain.get(key)
    }
    
    final func removeDataFromKeychain(forKey key: String) -> Bool {
        let keychain = KeychainSwift()
        
        return keychain.delete(key)
    }
    
    /// Load web page
    func loadWebPage(_ url: URL?) {
        if let url = url,
            UIApplication.shared.canOpenURL(url) {
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    }
}

// MARK: UITextField
extension UITextField {
    
    /// addPadding
    final func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.always
    }
}

// MARK: String
extension String {
    
    /// Check correct email
    func validateEmail() -> Bool {
        /* Taken from [Stackoverflow](http://stackoverflow.com/a/1149894/78336) */
        let emailRegularExpression =
            "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}" +
                "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
                "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
                "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
                "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
                "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        return NSPredicate(format: "SELF MATCHES %@", emailRegularExpression).evaluate(with: self)
    }
    
    /// Capitalize first letter
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    /// Get string length
    func length() -> Int {
        return self.utf16.count
    }
    
    /// Replace string with an other
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}

// MARK: UITableView
extension UITableView {
    
    /// Register custom UITableViewCell from Nib file
    func registerNib(nibName: String, reuseIdentifier: String) {
        let nibName = UINib(nibName: nibName, bundle: nil)
        self.register(nibName, forCellReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - UICollectionView
extension UICollectionView {
    
    /// Register custom UICollectionViewCell from Nib file
    func registerNib(nibName: String, reuseIdentifier: String) {
        let nibName = UINib(nibName: nibName, bundle: nil)
        self.register(nibName, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - YouTube
extension String {
    func formatDurationsFromYoutubeAPItoNormalTime() -> String {
        let targetString = self
        var timeDuration: NSString!
        let string: NSString = targetString as NSString
        if string.range(of: "H").location == NSNotFound && string.range(of: "M").location == NSNotFound {
            
            if string.range(of: "S").location == NSNotFound {
                timeDuration = NSString(format: "00:00")
            } else {
                var secs: NSString = targetString as NSString
                secs = secs.substring(from: secs.range(of: "PT").location + "PT".characters.count)  as NSString
                secs = secs.substring(to: secs.range(of: "S").location) as NSString
                
                timeDuration = NSString(format: "00:%02d", secs.integerValue)
            }
        } else if string.range(of: "H").location == NSNotFound {
            var mins: NSString = targetString as NSString
            mins = mins.substring(from: mins.range(of: "PT").location + "PT".characters.count)  as NSString
            mins = mins.substring(to: mins.range(of: "M").location) as NSString
            
            if string.range(of: "S").location == NSNotFound {
                timeDuration = NSString(format: "%02d:00", mins.integerValue)
            } else {
                var secs: NSString = targetString as NSString
                secs = secs.substring(from: secs.range(of: "M").location + "M".characters.count)  as NSString
                secs = secs.substring(to: secs.range(of: "S").location) as NSString
                
                timeDuration = NSString(format: "%02d:%02d", mins.integerValue, secs.integerValue)
            }
        } else {
            var hours: NSString = targetString as NSString
            hours = hours.substring(from: hours.range(of: "PT").location + "PT".characters.count)  as NSString
            hours = hours.substring(to: hours.range(of: "H").location) as NSString
            
            if string.range(of: "M").location == NSNotFound && string.range(of: "S").location == NSNotFound {
                timeDuration = NSString(format: "%02d:00:00", hours.integerValue)
            } else if string.range(of: "M").location == NSNotFound {
                var secs: NSString = targetString as NSString
                secs = secs.substring(from: secs.range(of: "H").location + "H".characters.count)  as NSString
                secs = secs.substring(to: secs.range(of: "S").location) as NSString
                
                timeDuration = NSString(format: "%02d:00:%02d", hours.integerValue, secs.integerValue)
            } else if string.range(of: "S").location == NSNotFound {
                var mins: NSString = targetString as NSString
                mins = mins.substring(from: mins.range(of: "H").location + "H".characters.count)  as NSString
                mins = mins.substring(to: mins.range(of: "M").location) as NSString
                
                timeDuration = NSString(format: "%02d:%02d:00", hours.integerValue, mins.integerValue)
            } else {
                var secs: NSString = targetString as NSString
                secs = secs.substring(from: secs.range(of: "M").location + "M".characters.count)  as NSString
                secs = secs.substring(to: secs.range(of: "S").location) as NSString
                var mins: NSString = targetString as NSString
                mins = mins.substring(from: mins.range(of: "H").location + "H".characters.count)  as NSString
                mins = mins.substring(to: mins.range(of: "M").location) as NSString
                
                timeDuration = NSString(format: "%02d:%02d:%02d", hours.integerValue, mins.integerValue, secs.integerValue)
            }
        }
        return timeDuration as String
    }
    
    func getYoutubeFormattedDuration() -> String {
        
        let formattedDuration = self.replacingOccurrences(of: "PT", with: "").replacingOccurrences(of: "H", with:":").replacingOccurrences(of: "M", with: ":").replacingOccurrences(of: "S", with: "")
        
        let components = formattedDuration.components(separatedBy: ":")
        var duration = ""
        for component in components {
            duration = !duration.characters.isEmpty ? duration + ":" : duration
            if component.characters.count < 2 {
                duration += "0" + component
                continue
            }
            duration += component
        }
        
        return duration
        
    }
}
