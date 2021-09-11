//
//  MoneyAppError.swift
//  MoneyApp
//
//  Created by Szymon Gęsicki on 11/09/2021.
//

import Foundation

struct MoneyAppError: Error {

    var localizedDescription: String { return _description }

    private var _description: String

    init(description: String) {
        self._description = description
    }
}
