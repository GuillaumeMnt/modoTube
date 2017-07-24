//
//  Extensions.swift
//  modoTube
//
//  Created by Guillaume Monot on 7/24/17
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
