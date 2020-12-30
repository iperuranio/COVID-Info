//
//  UIViewExtension.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 27/12/2020.
//

import UIKit

extension UIView {
    
    static func getVibrancyAndBlurView(_ superView: UIView) -> [UIView] {
        let blur = getBlurEffect(.regular)
        let blurView = getBlurView(superView, blur)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blur)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        
        vibrancyEffectView.bounds = superView.bounds
        vibrancyEffectView.tag = 900 //enum?
        vibrancyEffectView.clipsToBounds = true
        vibrancyEffectView.layer.cornerCurve = superView.layer.cornerCurve
        vibrancyEffectView.layer.cornerRadius = superView.layer.cornerRadius
        vibrancyEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
//        vibrancyEffectView.contentView.addSubview(superView)
        blurView.contentView.addSubview(vibrancyEffectView)
        
        return [vibrancyEffectView, blurView]
    }
    
    static func getBlurEffect(_ type: UIBlurEffect.Style) -> UIBlurEffect {
        return UIBlurEffect(style: type)
    }
    
    static func getMaterialLightBlurView(_ superView: UIView) -> UIView {
        return getBlurView(superView, getBlurEffect(.systemMaterialLight))
    }
    
    static func getBlurView(_ superView: UIView, _ blurEffect: UIBlurEffect) -> UIVisualEffectView {
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.tag = 1000 //enum?
        blurEffectView.frame = superView.frame
        blurEffectView.layer.cornerCurve = superView.layer.cornerCurve
        blurEffectView.layer.cornerRadius = superView.layer.cornerRadius
        blurEffectView.clipsToBounds = true
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return blurEffectView
    }
    
    func blurScreen() { //deprecato
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
