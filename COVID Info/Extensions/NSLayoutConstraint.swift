//
//  NSLayoutConstraint.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 20/01/2021.
//

import UIKit

extension NSLayoutConstraint {
    func toString() -> String {
        let identifier = self.identifier == nil ? "NO" : self.identifier!
        return "Identifier: \(identifier), Type: \(self.firstAnchor), Constant: \(self.constant)"
    }
}
