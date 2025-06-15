//
//  String+Localization+Extensions.swift
//  Moises
//
//  Created by Gustavo Guimarães on 14/06/25.
//

import Foundation

protocol LocalizableKey {
    var localized: String { get }
}

extension LocalizableKey where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
