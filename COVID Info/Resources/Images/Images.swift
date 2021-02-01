//
//  Images.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 26/12/2020.
//

import UIKit

struct Images {
    static let BACKGROUND_BLUE_1 = named("bg-blue")
    static let GIRL_WITH_MASK = named("mask2")
    static let ARROW = named("arrow.right.circle")
    static let ARROW_WHITE = named("arrow.right.circle-white")
    static let XMARK = named("xmark.circle")
    static let BACKGROUND_BLUE_2 = named("bg-azzurro")
    static let BACKGROUND_GREEN_1 = named("bg-verdino")
    static let BACKGROUND_GREEN_2 = named("Gradient1")
    static let BACKGROUND_GREEN_3 = named("Gradient2")
    static let LAW_BOOK = named("foglio")
    static let PISA_TOWER = named("pisa")
    static let NOTIFY_BELL = named("campana")
    static let LAW = named("legge")
    static let TRIANGLE_ERROR = named("exclamationmark.triangle")
    static let CHEVRON_RIGHT = named("chevron.right")
    static let MAP = named("map")
    static let BACKGROUND_DARK_1 = named("DarkBlueGradient")
    static let ITALY = named("italy")
    static let ITALY_COLORED = named("italy_colored")
    static let HOUSE = named("house.fill")
    static let GEAR = named("gearshape.fill")
    static let TEXT_BOOK_CLOSED = named("text.book.closed.fill")
    static let HEART_TEXT = named("heart.text.square.fill")
    static let ERROR = named("error")
    static let INFO = named("info")
    static let MAIL = named("mail")
    static let POLICY = named("policy")
    static let SHARE = named("share")
    static let STAR = named("star")
    static let TOS = named("tos")
    
    
    static func named(_ name: String) -> UIImage {
        return UIImage(named: name)!
    }
}
