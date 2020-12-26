//
//  UIViewExtension.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 27/12/2020.
//

import UIKit

extension UIView {
    func blurScreen() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.tag = 1000 //enum?
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func removeBlur() {
        getViewFromTag(1000)?.removeFromSuperview()
//        blurEffectView!.removeFromSuperview()
    }
    
    func getViewFromTag(_ tag: Int) -> UIView? {
        for view in self.subviews {
            if view.tag == 1000 {
                return view
            }
        }
        
        return nil
    }
}
