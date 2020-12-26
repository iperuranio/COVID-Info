//
//  FirstOpenLaunchPage1.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 23/12/2020.
//

import UIKit

class FirstOpenLaunchPage1: UIViewController {
    let currentPage = Pages.pageOne
    
    var mainView = UIView()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    var bigLabel = UILabel()
    
    var imageCenter = UIImageView()
    var background = UIImageView()
    
    var topView: UIView = UIView()
    var midView: UIView = UIView()
    var botView: UIView = UIView()
    
    var blurView: UIView = UIView()
    
    var initialized: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) { //in questa funzione perché la dimensione del frame si aggiorna qui
        if(initialized) { //ricordarsi sta roba
            return
        }
        
        mainView = self.view
        
        let generalPage = GeneralPageUI(topView, midView, botView, false) //debug mode con true
        setupBackground()
        
        generalPage.attachSuperView(mainView)
        
        setupBlurView()
        
        setupTitle()
        setupSubtitle()
        setupImage()
        setupBottomTitle()
        
        initialized = true
    }
    
    func setupBlurView() {
        let viewEditor = ViewEditor(blurView, midView)
        viewEditor
            .debug()
            .asViewBackground()
            .attachToSuperviewAndVoidBuild()
    }
    
    func setupBackground() {
        let viewEditor = ViewEditor(background, mainView)
        viewEditor.imageEditor()
            .image(Images.BACKGROUND_BLUE_1)
            .upperEditor()
            .asViewBackground()
            .attachToSuperviewAndVoidBuild()
    }
    
    func setupTitle() {
        let viewEditor = ViewEditor(titleLabel, midView)
        let text = "COVID-Info" //prendere dal file translate
        
        viewEditor.clearBackground()
            .percentageFrameMaxX(0)
            .percentageFrameRelativeY(0)
            .percentageFrameWidth(0.65)
            .percentageFrameHeight(0.25)
            .centerX()
            .labelEditor()
            .emptyText()
            .centerText()
            .adjustsFontSizeToFitWidth(true)
            .baselineAdjustment(UIBaselineAdjustment.alignBaselines)
            .blackText()
            .font(Fonts.EUCLID_CIRCULAR_B_BOLD, 32)
            .transitionText(0.10, false, 0.40, .transitionFlipFromBottom, text)
            .upperEditor()
            .attachToSuperviewAndVoidBuild()
    }
    
    func setupSubtitle() {
        let viewEditor = ViewEditor(subTitleLabel, midView)
        let text = "Benvenuto in COVID Info!"
        
        viewEditor.clearBackground()
            .percentageFrameRelativeY(0.16)
            .percentageFrameWidth(0.58)
            .percentageFrameHeight(0.05)
            .centerX()
            .labelEditor()
            .emptyText()
            .centerText()
            .textColor(Colors.SECOND_TEXT_COLOR)
            .adjustsFontSizeToFitWidth(true)
            .baselineAdjustment(UIBaselineAdjustment.alignBaselines)
            .font(Fonts.EUCLID_CIRCULAR_B_LIGHT, 18)
            .transitionText(0.10, false, 0.40, .transitionFlipFromBottom, text)
            .upperEditor()
            .attachToSuperviewAndVoidBuild()
    }
    
    func setupImage() {
        let viewEditor = ViewEditor(imageCenter, midView)
        
        viewEditor.percentageFrameRelativeY(0.285)
            .imageEditor()
            .contentMode(.scaleAspectFit)
            .image(Images.GIRL_WITH_MASK)
            .upperEditor()
            .percentageFrameWidth(0.6)
            .percentageFrameHeight(0.2)
            .centerX()
            .attachToSuperviewAndVoidBuild()
    }
    
    func setupBottomTitle() {
        let viewEditor = ViewEditor(bigLabel, midView)
        let text = "All'interno dell'app troverai tutto il necessario per rimanere informato riguardo la malattia da coronavirus (COVID-19)."
        
        viewEditor.clearBackground()
            .percentageFrameRelativeY(0.57)
            .percentageFrameWidth(0.9)
            .percentageFrameHeight(0.30)
            .centerX()
            .labelEditor()
            .emptyText()
            .textColor(Colors.SECOND_TEXT_COLOR)
            .centerText()
            .adjustsFontSizeToFitWidth(true)
            .lines(0)
            .baselineAdjustment(UIBaselineAdjustment.alignBaselines)
            .font(Fonts.EUCLID_CIRCULAR_B_LIGHT, 22)
            .transitionText(0.10, false, 0.40, .transitionFlipFromBottom, text)
            .upperEditor()
            .attachToSuperviewAndVoidBuild()
    }
}
