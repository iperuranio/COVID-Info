//
//  FirstOpenLaunchPage1.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 23/12/2020.
//

import UIKit

class FirstOpenLaunchPage1: UIViewController {
    let currentPage = Pages.pageOne
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var botView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //titleLabel.font = UIFont.sourceCodeProBold(size: 30)
//        print("called")
//        view.addSubview(storyboardUI.instantiateViewController(withIdentifier: "FIRST_OPEN_PAGE_1").view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let topFrame = topView.frame
        GeneralPageUI(topView, midView, botView) //debug mode con true
        
        
        
//        print(startingBotPoint + startingMidPoint + startingTopPoint)
//        print(UIScreen.main.bounds.height)
//        print(view.frame.size.height)
//        print(view.frame.height)
//        print(FirstLaunchController.frame?.height)
        
//        print("\(startingTopPoint) \(0.165 * UIScreen.main.bounds.height)")
//        print("\(startingBotPoint) \(0.235 * UIScreen.main.bounds.height)")
//        print("\(startingMidPoint) \(0.6 * UIScreen.main.bounds.height)")
//        print("\(topView.frame.maxY) \(midView.frame.maxY) \(botView.frame.maxY)")
    }
    
    
}
