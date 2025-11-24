//
//  Font.swift
//  ZakFit
//
//  Created by Anne Ferret on 24/11/2025.
//

import SwiftUI

extension Font {
    private static let regular = "Gabarito-Regular"
    private static let medium = "Gabarito-Regular_Medium"
    private static let semiBold = "Gabarito-Regular_SemiBold"
    private static let bold = "Gabarito-Regular_Bold"
    
    static var title: Font {
        .custom(bold, size: 32)
    }
    static var title2: Font {
        .custom(bold, size: 24)
    }
    static var smallTitle: Font {
        .custom(semiBold, size: 18)
    }
    static var callout: Font {
        .custom(semiBold, size: 14)
    }
    static var callout2: Font {
        .custom(regular, size: 12)
    }
    static var caption: Font {
        .custom(regular, size: 18)
    }
    static var buttonLabel: Font {
        .custom(medium, size: 17)
    }
    static var inputLabel: Font {
        .custom(medium, size: 17)
    }
    static var cardBigTitle: Font {
        .custom(semiBold, size: 24)
    }
    static var cardTitle: Font {
        .custom(semiBold, size: 16)
    }
    static var cardSubheader: Font {
        .custom(regular, size: 18)
    }
    static var cardCaption: Font {
        .custom(regular, size: 12)
    }
    static var cardCaption2: Font {
        .custom(regular, size: 11)
    }
    static var cardData: Font {
        .custom(bold, size: 32)
    }
    static var cardDataSmall: Font {
        .custom(bold, size: 24)
    }
    static var cardUnit: Font {
        .custom(regular, size: 14)
    }
    static var listLabel: Font {
        .custom(medium, size: 17)
    }
    static var listHeader: Font {
        .custom(semiBold, size: 17)
    }
    static var listHeaderProminent: Font {
        .custom(semiBold, size: 20)
    }
    static var listHeaderAction: Font {
        .custom(medium, size: 15)
    }
    static var listSubheader: Font {
        .custom(regular, size: 15)
    }
    static var listDetail: Font {
        .custom(semiBold, size: 17)
    }
}
