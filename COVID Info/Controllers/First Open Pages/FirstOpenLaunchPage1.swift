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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //titleLabel.font = UIFont.sourceCodeProBold(size: 30)
//        print("called")
//        view.addSubview(storyboardUI.instantiateViewController(withIdentifier: "FIRST_OPEN_PAGE_1").view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let topFrame = topView.frame
        frame = CGRect(x: 0, y: 0, width: mainView.frame.width, height: mainView.frame.height)
        
        let _ = GeneralPageUI(topView, midView, botView, true) //debug mode con true
        midFrame = midView.frame
        
        setupTitle()
        setupSubtitle()
        setupImage()
        setupBottomTitle()
        
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
        
        viewEditor.percentageFrameMaxX(0)
            .percentageFrameRelativeY(0)
            .percentageFrameWidth(0.65)
            .percentageFrameHeight(0.25)
            .centerX()
            .labelEditor()
            .textAlignment(.center)
            .upperEditor()
            .voidBuild()
    }
    
    func setupSubtitle() {
        let viewEditor = ViewEditor(text1, midView)
        viewEditor.percentageFrameRelativeY(0.16)
            .percentageFrameWidth(0.6)
            .percentageFrameHeight(0.05)
            .centerX()
            .labelEditor()
            .textAlignment(.center)
            .upperEditor()
            .voidBuild()
    }
    
    func setupImage() {
        let y = (0.285 * midFrame.height)
        let width = 0.6 * midFrame.width
        let height = (0.2 * midFrame.height)

        imageCenter.frame = CGRect(x: 0, y: y, width: width, height: height)
        imageCenter.center.x = self.view.center.x
    }
    
    func setupBottomTitle() {
        let y = (0.57 * midFrame.height)
        let width = 0.9 * midFrame.width
        let height = (0.30 * midFrame.height)

        text2.frame = CGRect(x: 0, y: y, width: width, height: height)
        text2.center.x = self.view.center.x
        text2.textAlignment = .center
    }
    
    //fare un configuratore a cascata
    
}
