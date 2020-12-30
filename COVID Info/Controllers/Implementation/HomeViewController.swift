//
//  HomeViewController.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 24/12/2020.
//

import UIKit

class HomeViewController: UIViewController {

    var mainView = UIView()
    var regionButton = UIButton()
    var regionErrorView = UIView()
    var regionErrorButtonEditor: ViewEditor? = nil
    var buttonIcon = UIImageView()
    var regionErrorIconEditor: ViewEditor? = nil
    var regionErrorTitleEditor: ViewEditor? = nil
    var regionTitleLabel = UILabel()
    var squareMainView = UIImageView()
    var nationalSquareView = UIView()
    var regionSquareView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewSafeAreaInsetsDidChange() { //qui perché view.safeAreaInsets ha dei valori
        let safeArea = view.safeAreaInsets
        let safeAreaFrame = CGRect(x: 0, y: safeArea.top, width: view.frame.width, height: view.frame.height - (safeArea.top + safeArea.bottom))
        let safeAreaView = UIView(frame: safeAreaFrame)

        mainView = safeAreaView
        
        view.backgroundColor = Colors.ACCENT_INTERFACE_COLOR
        view.addSubview(mainView)
        
        let hasRegion = false //se ha selezionato la regione
        loadRegion()
        
        if(!hasRegion) {
            loadRegionError()
        } else {
            loadRegionChange()
        }
        
        loadSquareView()
        
        loadNationalSquare()
    }
    
    func loadSquareView() {
        let squareMainViewEditor = ViewEditor(squareMainView, mainView)
        squareMainViewEditor
            .clearBackground()
            .percentageFrameRelativeX(0)
            .percentageFrameRelativeY(0.170)
            .percentageFrameWidth(0.9)
            .percentageFrameHeight(0.800)
            .centerX()
            .layerEditor()
            .cornerRadius(20)
            .cornerCurve(.continuous)
            .upperEditor()
            .clipToBounds()
            .imageEditor()
            .image(Images.BACKGROUND_DARK_1)
            .upperEditor()
            .attachToSuperviewAndVoidBuild()
        
        let views = UIView.getVibrancyAndBlurView(squareMainView)
        let blurView = views[0]
        let vibranceView = views[1]
        mainView.addSubview(blurView)
//        mainView.addSubview(vibranceView)
        
        let spacing = 1.5
        
        let nationalSquareViewEditor = ViewEditor(nationalSquareView, squareMainView)
        nationalSquareViewEditor
            .asViewBackground().debug()
            .centerX()
            .percentageFrameWidth(0.98)
            .percentageFrameHeight(0.5)
            .attachToSuperviewAndVoidBuild()
    }
    
    func loadNationalSquare() {
        
    }
    
    
    
    func loadRegion() {
        let regionErrorEditor = ViewEditor(regionErrorView, mainView)
        regionErrorEditor
            .percentageFrameRelativeX(0)
            .percentageFrameRelativeY(0.009)
            .percentageFrameWidth(0.9)
            .percentageFrameHeight(0.130)
            .centerX()
            .attachToSuperviewAndVoidBuild()
        
        regionErrorButtonEditor = ViewEditor(regionButton, regionErrorView)
        regionErrorButtonEditor!
            .asViewBackground()
            .tintColor(Colors.BUTTON_TINT_COLOR)
            .buttonEditor()
            .image(Images.CHEVRON_RIGHT)
            .backgroundColor(Colors.ACCENT_BUTTONS_COLOR_1)
            .upperEditor()
            .layerEditor()
            .cornerCurve(.continuous)
            .cornerRadius(30)
            .upperEditor()
            .attachToSuperviewAndVoidBuild()
        
        let width = regionErrorView.frame.width
        regionErrorIconEditor = ViewEditor(buttonIcon, regionButton)
        regionErrorIconEditor!
            .centerY()
            .percentageFrameRelativeX(0.075)
            .percentageFrameHeight(0.2)
            .percentageFrameWidth(0.09)
            .contentMode(.scaleAspectFit)
            .isUserInteractionEnabled(false)
            .attachToSuperviewAndVoidBuild()
        regionErrorButtonEditor!
            .buttonEditor()
            .imageEdge(0, width * 0.78, 0, 0)
            .buttonImageViewEditor().isUserInteractionEnabled(false)
            .voidBuild()
        
        regionErrorTitleEditor = ViewEditor(regionTitleLabel, regionButton)
        regionErrorTitleEditor!
            .centerX()
            .centerY()
            .percentageFrameHeight(0.25)
            .percentageFrameWidth(0.5)
            .labelEditor()
            .centerText()
            .lines(0)
            .baselineAdjustment(.alignCenters)
            .adjustsFontSizeToFitWidth(true)
            .lineBreak(.byClipping)
            .font(Fonts.EUCLID_CIRCULAR_B_LIGHT, 18)
            .upperEditor()
            .attachToSuperviewAndVoidBuild()
    }
    
    func loadRegionChange() {
        regionErrorIconEditor!
            .tintColor(.cyan)
            .imageEditor()
            .image(Images.MAP)
            .upperEditor()
            .voidBuild()
        
        let title = "Cambia la regione"
        regionErrorTitleEditor?
            .labelEditor()
            .text(title)
            .upperEditor()
            .voidBuild()
    }
    
    func loadRegionError() {
        regionErrorIconEditor!
            .tintColor(.systemYellow)
            .imageEditor()
            .image(Images.TRIANGLE_ERROR)
            .upperEditor()
            .voidBuild()
        
        let title = "Imposta la regione"
        regionErrorTitleEditor?
            .labelEditor()
            .text(title)
            .upperEditor()
            .voidBuild()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
}
