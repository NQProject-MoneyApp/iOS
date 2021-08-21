//
//  UserDefaultsKeys.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 19/08/2021.
//

import Foundation

extension UserDefaults {
    
    enum Keys: String {
                
        case token
                        
        var defaultValue: Any? {
            switch self {
            case .token: return nil
            }
        }
    }
    
    class var appDefaults: [String: Any] {
        return [UserDefaults.Keys.token.rawValue: UserDefaults.Keys.token.defaultValue as Any]
    }
    
    class var token: String? {
        return standard.string(forKey: Keys.token.rawValue)
    }
    
    class func set(token: String?) {
        standard.set(token, forKey: Keys.token.rawValue)
    }
}
