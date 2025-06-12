//
//  String+Extension.swift
//  Moises
//
//  Created by Gustavo Guimarães on 11/06/25.
//
import Foundation

extension String {
    func toURL() -> URL? {
        URL(string: self)
    }
}
