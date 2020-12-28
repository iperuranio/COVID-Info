//
//  UIButtonExtension.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 27/12/2020.
//

import UIKit

extension UIButton {
    func centerButtonAndImageWithSpacing(spacing: CGFloat) {
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing);
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0);
    }
//    open override var isHighlighted: Bool {
//        didSet {
//            UIView.animate(withDuration: 0.25, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
//                self.alpha = self.isHighlighted ? 0.5 : 1
//            }, completion: nil)
//        }
//    }
}
