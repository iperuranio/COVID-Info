//
//  Fonts.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 26/12/2020.
//

import UIKit

enum Fonts: String {
    case EUCLID_CIRCULAR_B_LIGHT = "EuclidCircularB-Light"
    case EUCLID_CIRCULAR_B_BOLD = "EuclidCircularB-Bold"
    case EUCLID_CIRCULAR_B_Medium = "EuclidCircularB-Medium"
    case EUCLID_CIRCULAR_B_Semibold = "EuclidCircularB-Semibold"
    case SOURCE_CODE_PRO_BOLD = "SourceCodePro-Bold"
    
    func font(_ size: CGFloat) -> UIFont {
        return named(self.rawValue, size)
    }
    
    private func named(_ name: String, _ size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size)!
    }
    
}
