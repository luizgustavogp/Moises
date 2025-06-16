//
//  String+Extensions.swift
//  Moises
//
//  Created by Gustavo Guimarães on 11/06/25.
//
import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}

extension String {
    func toURL() -> URL? {
        guard let url = URL(string: self),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              components.scheme != nil || components.host != nil else {
            return nil
        }
        return url
    }
}
