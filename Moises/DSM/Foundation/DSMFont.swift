//
//  DSMFont.swift
//  Moises
//
//  Created by Gustavo Guimarães on 07/06/25.
//

import SwiftUI

public enum DSMFontSize: CGFloat {
    case xSmall = 12
    case small = 14
    case medium = 16
    case large = 20
    case xLarge = 24
    case xxLarge = 32
}

public enum DSMFontWeight {
    case regular
    case medium
    case semibold
    case bold

    var swiftUIWeight: Font.Weight {
        switch self {
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        }
    }
}

public enum DSMFont {
    
    public static func sfProDisplay(size: DSMFontSize, weight: DSMFontWeight = .regular) -> Font {
        Font.custom("SF Pro Display", size: size.rawValue)
            .weight(weight.swiftUIWeight)
    }

    public static func montserrat(size: DSMFontSize, weight: DSMFontWeight = .regular) -> Font {
        Font.custom("Montserrat", size: size.rawValue)
            .weight(weight.swiftUIWeight)
    }

    public static func articulatCF(size: DSMFontSize, weight: DSMFontWeight = .regular) -> Font {
        Font.custom("Articulat CF", size: size.rawValue)
            .weight(weight.swiftUIWeight)
    }
}
