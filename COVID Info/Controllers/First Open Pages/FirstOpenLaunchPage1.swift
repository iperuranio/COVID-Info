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
    
    @IBOutlet weak var imageCenter: UIImageView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var botView: UIView!
    
    var frame = CGRect()
    var midFrame = CGRect()
    
    var initialized: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //titleLabel.font = UIFont.sourceCodeProBold(size: 30)
//        print("called")
//        view.addSubview(storyboardUI.instantiateViewController(withIdentifier: "FIRST_OPEN_PAGE_1").view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(initialized) { //ricordarsi sta roba
            return
        }
        
        frame = CGRect(x: 0, y: 0, width: mainView.frame.width, height: mainView.frame.height)
        
        let _ = GeneralPageUI(topView, midView, botView, false) //debug mode con true
        midFrame = midView.frame
        
        setupTitle()
        setupSubtitle()
        setupImage()
        setupBottomTitle()
        
        initialized = true
//        titleLabel.frame =
        
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
    
    func setupTitle() {
        let viewEditor = ViewEditor(titleLabel, midView)
        let text = "COVID-Info" //prendere dal file translate
        
        viewEditor.percentageFrameMaxX(0)
            .percentageFrameRelativeY(0)
            .percentageFrameWidth(0.65)
            .percentageFrameHeight(0.25)
            .centerX()
            .labelEditor()
            .text("")
            .textAlignment(.center)
            .transitionText(0.10, false, 0.40, .transitionFlipFromBottom, text)
            .upperEditor()
            .voidBuild()
    }
    
    func setupSubtitle() {
        let viewEditor = ViewEditor(text1, midView)
        let text = "Benvenuto in COVID Info!"
        
        viewEditor.percentageFrameRelativeY(0.17)
            .percentageFrameWidth(0.58)
            .percentageFrameHeight(0.05)
            .centerX()
            .labelEditor()
            .text("")
            .textAlignment(.center)
            .transitionText(0.10, false, 0.40, .transitionFlipFromBottom, text)
            .upperEditor()
            .voidBuild()
    }
    
    func setupImage() {
        let viewEditor = ViewEditor(imageCenter, midView)
        
        viewEditor.percentageFrameRelativeY(0.285)
            .percentageFrameWidth(0.6)
            .percentageFrameHeight(0.2)
            .centerX()
            .voidBuild()
    }
    
    func setupBottomTitle() {
        let viewEditor = ViewEditor(text2, midView)
        let text = "All'interno dell'app troverai tutto il necessario per rimanere informato riguardo la malattia da coronavirus (COVID-19)."
        
        viewEditor.percentageFrameRelativeY(0.57)
            .percentageFrameWidth(0.9)
            .percentageFrameHeight(0.30)
            .centerX()
            .labelEditor()
            .text("")
            .textAlignment(.center)
            .transitionText(0.10, false, 0.40, .transitionFlipFromBottom, text)
            .upperEditor()
            .voidBuild()
    }
    
    //fare un configuratore a cascata
}
