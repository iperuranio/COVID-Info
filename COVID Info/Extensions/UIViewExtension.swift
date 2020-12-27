//
//  UIViewExtension.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 27/12/2020.
//

import UIKit

extension UIView {
    
    static func getBlurView(_ superView: UIView) -> UIView {
        let blurEffect = UIBlurEffect(style: .systemMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.tag = 1000 //enum?
        blurEffectView.frame = superView.bounds
        blurEffectView.layer.cornerCurve = superView.layer.cornerCurve
        blurEffectView.layer.cornerRadius = superView.layer.cornerRadius
        blurEffectView.clipsToBounds = true
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return blurEffectView
    }
    
    func blurScreen() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.tag = 1000 //enum?
        blurEffectView.frame = self.bounds
        blurEffectView.layer.cornerCurve = self.layer.cornerCurve
        blurEffectView.layer.cornerRadius = self.layer.cornerRadius
        blurEffectView.clipsToBounds = true
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
