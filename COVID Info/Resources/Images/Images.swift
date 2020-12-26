//
//  Images.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 26/12/2020.
//

import UIKit

struct Images {
    static let BACKGROUND_BLUE_1 = #imageLiteral(resourceName: "bg-blue")
    static let GIRL_WITH_MASK = #imageLiteral(resourceName: "mask2")
    
    
    static func named(_ name: String) -> UIImage {
        return UIImage(named: name)!
    }
}
