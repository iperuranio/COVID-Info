//
//  ViewController.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 21/12/2020.
//

import UIKit

class MainScreenController: UIViewController {
    static var instance: MainScreenController?
    let storyboardUI = UIStoryboard(name: "Main", bundle: nil)
    var fullscreenFrame = CGRect()
    
    var blurEffectView: UIVisualEffectView?
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        
        MainScreenController.instance = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fullscreenFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
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
        blur()
        self.performSegue(withIdentifier: "FIRST_APP_OPEN", sender: self)
    }
    
    func blur() {
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

