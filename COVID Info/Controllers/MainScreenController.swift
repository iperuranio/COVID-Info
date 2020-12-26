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
    static var fullscreenFrame = CGRect()
    
    var blurEffectView: UIVisualEffectView?
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        
        MainScreenController.instance = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainScreenController.fullscreenFrame = UIScreen.main.bounds
        
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
