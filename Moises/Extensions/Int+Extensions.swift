//
//  Int+Extensions.swift
//  Moises
//
//  Created by Gustavo Guimarães on 12/06/25.
//

import Foundation

extension Optional where Wrapped == Int {
    var orZero: Int {
        return self ?? 0
    }
}

extension Int {
    var asDouble: Double {
        Double(self)
    }
    
    var asTimeString: String {
        let totalSeconds = self
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
