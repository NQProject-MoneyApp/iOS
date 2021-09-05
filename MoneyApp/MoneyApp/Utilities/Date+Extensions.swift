//
//  Date+Extensions.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 05/09/2021.
//

import Foundation

extension Date {
    
    static func fromISO(stringDate: String) -> Date {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)

        return formatter.date(from: stringDate) ?? Date()
    }
}
