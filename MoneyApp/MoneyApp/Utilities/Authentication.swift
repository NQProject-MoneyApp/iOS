//
//  Authentication.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 19/08/2021.
//

import Foundation


class Authentication {
    
    static let shared = Authentication()
    
    func setToken(token: String) {
        
        assert(!token.isEmpty, "Setting empty token is not allowed. If you want to logout, use `logout()` instead")
        UserDefaults.set(token: token)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "login"), object: self)
    }
    
    /// Returns the current token
    func token() -> String? {
        
        return UserDefaults.token
    }
    
    func logout() {
        
        UserDefaults.set(token: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "logout"), object: self)
    }
    
    func isLoggedIn() -> Bool {
        
        return token() != nil
    }
}
