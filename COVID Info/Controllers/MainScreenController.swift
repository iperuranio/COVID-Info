//
//  ViewController.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 21/12/2020.
//

import UIKit

class MainScreenController: UITabBarController {
    static var instance: MainScreenController?
//    let storyboardUI = UIStoryboard(name: "Main", bundle: nil)
    static var fullscreenFrame = CGRect()
    
    var isFirstOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [generateHomeViewController(), generateDatiViewController(), generateDecretiViewController(), generateSettingsViewController()]
        self.tabBar.tintColor = Colors.LIGHT_BLUE
        MainScreenController.fullscreenFrame = UIScreen.main.bounds
        
        if(isFirstOpen) {
            let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light)) //se è tema scuro mette scuro altrimenti chiaro
            blur.frame = MainScreenController.fullscreenFrame
            blur.autoresizingMask = .flexibleWidth
            view.insertSubview(blur, at: 0)
        }
        
        
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
        if(isFirstOpen) {
            self.present(FirstLaunchController(), animated: true)
        }
    }
    
    private func generateHomeViewController() -> UIViewController {
        return generateViewController(HomeViewController(), "Home", Images.HOUSE, Images.HOUSE)
    }
    
    private func generateDatiViewController() -> UIViewController {
        return generateViewController(DatiViewController(), "Dati", Images.HEART_TEXT, Images.HEART_TEXT)
    }
    private func generateDecretiViewController() -> UIViewController {
        return generateViewController(DecretiViewController(), "Disposizioni", Images.TEXT_BOOK_CLOSED, Images.TEXT_BOOK_CLOSED)
    }
    
    private func generateSettingsViewController() -> UIViewController {
        return generateViewController(SettingsViewController(), "Settings", Images.GEAR, Images.GEAR)
    }
    
    private func generateViewController(_ viewController: UIViewController, _ title: String, _ defaultImage: UIImage, _ selectedImage: UIImage) -> UIViewController {
        viewController.tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        return viewController
    }
}

//extension MainScreenController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("Selected \(viewController.title!)")
//    }
//
//}

extension UITabBar {
    func correctBounds() -> CGRect {
        let X = bounds.maxX
        let Y = bounds.maxY
        let width = bounds.width
        let height = bounds.height
        
        return CGRect(x: X, y: Y, width: width, height: height)
    }
}
