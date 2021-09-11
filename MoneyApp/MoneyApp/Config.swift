//
//  Config.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 05/06/2021.
//

import Foundation

class Config {
    
    static let APP_NAME = "Money App"
    
    static private(set) var MoneyAppAPIEndpoint = "api"
    static private(set) var MoneyAppAPIBaseURL = "\(MoneyAppAPIRemoteURL)/\(MoneyAppAPIEndpoint)"
    
    #if DEBUG
    static private(set) var MoneyAppAPIRemoteURL = "https://money-app-nqproject-staging.herokuapp.com"
    #else
    static private(set) var MoneyAppAPIRemoteURL = "https://money-app-nqproject-staging.herokuapp.com"
    #endif

}
