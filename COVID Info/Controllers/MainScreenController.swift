//
//  ViewController.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 21/12/2020.
//

import UIKit

class MainScreenController: UITabBarController {
    static var instance: MainScreenController?
    let storyboardUI = UIStoryboard(name: "Main", bundle: nil)
    @IBOutlet weak var tabBarUI: UITabBar!
    var fullscreenFrame = CGRect()
    
    var blurEffectView: UIVisualEffectView?
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        
        MainScreenController.instance = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullscreenFrame = UIScreen.main.bounds
        
        tabBarUI.backgroundColor = .clear

        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blur.frame = tabBarUI.correctBounds()
        blur.autoresizingMask = .flexibleWidth
        tabBarUI.insertSubview(blur, at: 0)
        
        
//        preview()
//        print("a")
//        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
//            print("b")
//            self.preview()
//        }
//        
//        print("c")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        blurScreen()
        self.performSegue(withIdentifier: "FIRST_APP_OPEN", sender: self)
    }
    
    func blurScreen() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView!)
    }
    
    func removeBlur() {
        blurEffectView!.removeFromSuperview()
    }
}

extension UITabBar {
    func correctBounds() -> CGRect {
        let X = bounds.maxX
        let Y = bounds.maxY
        let width = bounds.width
        let height = bounds.height
        
        return CGRect(x: X, y: Y, width: width, height: height)
    }
}

extension UIFont {
  static func euclidCircularBBold(size: CGFloat) -> UIFont {
    return UIFont(name: "EuclidCircularB-Bold", size: size)!
  }

  static func euclidCircularBMedium(size: CGFloat) -> UIFont {
    return UIFont(name: "EuclidCircularB-Medium", size: size)!
  }

  static func euclidCircularBSemibold(size: CGFloat) -> UIFont {
    return UIFont(name: "EuclidCircularB-Semibold", size: size)!
  }

  static func sourceCodeProBold(size: CGFloat) -> UIFont {
    return UIFont(name: "SourceCodePro-Bold", size: size)!
  }
}

extension UIImage {
    func tabBarImageWithCustomTint(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context: CGContext = UIGraphicsGetCurrentContext()!

        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)

        context.clip(to: rect, mask: self.cgImage!)

        tintColor.setFill()
        context.fill(rect)

        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        newImage = newImage.withRenderingMode(.alwaysOriginal)
        return newImage
    }
}

