//
//  Colors.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 26/12/2020.
//

import UIKit

struct Colors {
    static let BAR_BUTTON = named("BarButtonColors")
    static let GRIGIO = named("Grigio")
    static let LIGHT_BLUE = named("Verdino-1")
    static let VERDINO = named("Verdino-2")
    static let ACCENT_COLOR = named("AccentColor")
    static let ACCENT_INTERFACE_COLOR = named("AccentInterfaceColor")
    static let SECOND_TEXT_COLOR = named("SecondTextColor")
    static let SELECTED_BUTTON = named("SelectedButton")
    
    
    static func named(_ name: String) -> UIColor {
        return UIColor(named: name)!
    }
}
