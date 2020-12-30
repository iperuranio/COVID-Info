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
    var squareMainPhantomView = UIView()
    
    var nationalSquareView = UIView()
    var regionSquareView = UIView()
    
    var nationalSquareInsideView = UIView()
    var nationalSquareInsideView_ImageView = UIView()
    var nationalSquareInsideView_TopBarView = UIView()
    var nationalSquareInsideView_BottomBarView = UIView()
    var nationalSquareInsideView_Image = UIImageView()
    var nationalSquareInsideView_TopTitle = UILabel()
    var nationalSquareInsideView_TopSquare = UIView()
    var nationalSquareInsideView_TopSquareTitle = UILabel()
    var nationalSquareInsideView_TopSquareValue = UILabel()
    var nationalSquareInsideView_BotSquareLeft = UIView()
    var nationalSquareInsideView_BotSquareLeftTitle = UILabel()
    var nationalSquareInsideView_BotSquareLeftValue = UILabel()
    var nationalSquareInsideView_BotSquareRight = UIView()
    var nationalSquareInsideView_BotSquareRightTitle = UILabel()
    var nationalSquareInsideView_BotSquareRightValue = UILabel()
    
    var nationalArrayElements: [UIView] = []
    
    var regionSquareInsideView = UIView()
    var regionSquareInsideView_ImageView = UIView()
    var regionSquareInsideView_TopBarView = UIView()
    var regionSquareInsideView_BottomBarView = UIView()
    var regionSquareInsideView_Image = UIImageView()
    var regionSquareInsideView_TopTitle = UILabel()
    var regionSquareInsideView_TopSquare = UIView()
    var regionSquareInsideView_TopSquareTitle = UILabel()
    var regionSquareInsideView_TopSquareValue = UILabel()
    var regionSquareInsideView_BotSquareLeft = UIView()
    var regionSquareInsideView_BotSquareLeftTitle = UILabel()
    var regionSquareInsideView_BotSquareLeftValue = UILabel()
    var regionSquareInsideView_BotSquareRight = UIView()
    var regionSquareInsideView_BotSquareRightTitle = UILabel()
    var regionSquareInsideView_BotSquareRightValue = UILabel()
    
    var regionArrayElements: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nationalArrayElements = [nationalSquareView,
                                 nationalSquareInsideView,
                                 nationalSquareInsideView_ImageView,
                                 nationalSquareInsideView_TopBarView,
                                 nationalSquareInsideView_BottomBarView,
                                 nationalSquareInsideView_Image,
                                 nationalSquareInsideView_TopTitle,
                                 nationalSquareInsideView_TopSquare,
                                 nationalSquareInsideView_BotSquareLeft,
                                 nationalSquareInsideView_BotSquareRight,
                                 nationalSquareInsideView_TopSquareTitle,
                                 nationalSquareInsideView_TopSquareValue,
                                 nationalSquareInsideView_BotSquareLeftTitle,
                                 nationalSquareInsideView_BotSquareLeftValue,
                                 nationalSquareInsideView_BotSquareRightTitle,
                                 nationalSquareInsideView_BotSquareRightValue]
        
        regionArrayElements = [regionSquareView,
                               regionSquareInsideView,
                               regionSquareInsideView_ImageView,
                               regionSquareInsideView_TopBarView,
                               regionSquareInsideView_BottomBarView,
                               regionSquareInsideView_Image,
                               regionSquareInsideView_TopTitle,
                               regionSquareInsideView_TopSquare,
                               regionSquareInsideView_BotSquareLeft,
                               regionSquareInsideView_BotSquareRight,
                               regionSquareInsideView_TopSquareTitle,
                               regionSquareInsideView_TopSquareValue,
                               regionSquareInsideView_BotSquareLeftTitle,
                               regionSquareInsideView_BotSquareLeftValue,
                               regionSquareInsideView_BotSquareRightTitle,
                               regionSquareInsideView_BotSquareRightValue]
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
        loadRegionSquare()
    }
    
    func loadSquareView() {
        let squareMainViewEditor = ViewEditor(squareMainView(squareMainView), mainView)
        squareMainViewEditor
            .layerEditor()
            .cornerRadius(30)
            .cornerCurve(.continuous)
            .upperEditor()
            .clipToBounds()
            .imageEditor()
            .image(Images.BACKGROUND_DARK_1)
            .upperEditor()
            .void()
        
        let views = UIView.getVibrancyAndBlurView(squareMainView)
        let blurView = views[0]
        let vibranceView = views[1]
        mainView.addSubview(blurView)
        mainView.addSubview(vibranceView)
//        vibranceView.backgroundColor = .red
        
        squareMainPhantomView = squareMainView(squareMainPhantomView)

//        let spacing = 1.5
        
        loadMainViewsInsideSquare(nationalSquareView)
        loadMainViewsInsideSquare(regionSquareView, true)
    }
    
    private func squareMainView(_ view: UIView) -> UIView {
        let squareMainViewEditor = ViewEditor(view, mainView)
        return squareMainViewEditor
            .clearBackground()
            .percentageFrameRelativeX(0)
            .percentageFrameRelativeY(0.170)
            .percentageFrameWidth(0.94)
            .percentageFrameHeight(0.800)
            .centerX()
            .attachToSuperviewAndBuild()
    }
    
    private func loadMainViewsInsideSquare(_ view: UIView, _ secondView: Bool = false) {
        let nationalSquareViewEditor = ViewEditor(view, squareMainPhantomView)
        nationalSquareViewEditor
            .centerX()
            .percentageFrameWidth(1)
            .percentageFrameHeight(0.5)
            .attachToSuperviewAndVoidBuild()
        
        if(secondView) {
            nationalSquareViewEditor.percentageFrameRelativeY(0.5).voidBuild()
        }
    }
    
    func loadNationalSquare() {
        loadRawTopSquare(nationalArrayElements)
        nationalSquareInsideView_Image.image = Images.ITALY
        nationalSquareInsideView_Image.tintColor = .cyan
        
        nationalSquareInsideView_TopTitle.text = "Dati nazionali"
//        viewEditor.attachToSuperView().void()
        
        
    }
    
    func loadRegionSquare() {
        loadRawTopSquare(regionArrayElements)
        
        regionSquareInsideView_TopTitle.text = "Dati regionali"
//        viewEditor.attachToSuperView().void()
        
        
    }
    
    //Index 0: mainView (la view di base del national o del region)
    //Index 1: baseView (la view del quadrato del national o del region)
    //Index 2: imageViewInside (la view dentro la baseView per l'immagine, non è UIImageView)
    //Index 3: topViewInside (la view dentro la baseView per il rettangolo superiore)
    //Index 4: botViewInside (la view dentro la baseView per il rettangolo inferiore)
    //Index 5: image (l'immagine dentro la imageViewInside)
    //Index 6: topTitle (il titolo della view topViewInside)
    //Index 7: topSquare (la view che contiene i dati dentro topViewInside)
    //Index 8: botSquareLeft (la view che contiene i dati dentro botViewInside a sinistra)
    //Index 9: botSquareRight (la view che contiene i dati dentro botViewInside a destra)
    //Index 10: topSquareTitle (label del titolo di topSquare)
    //Index 11: topSquareValue (label del valore di topSquare)
    //Index 12: botLeftSquareTitle (label del titolo di botLeftSquare)
    //Index 13: botLeftSquareValue (label del valore di botLeftSquare)
    //Index 14: botRightSquareTitle (label del titolo di botRightSquare)
    //Index 15: botRightSquareValue (label del valore di botRightSquare)
    func loadRawTopSquare(_ view: [UIView]) {
        let mainView = view[0]
        let baseView = view[1]
        let baseViewEditor = ViewEditor(baseView, mainView)
        baseViewEditor.debug() //DEBUG
            .centerX()
            .centerY()
            .percentageFrameHeight(0.93)
            .chainBuild()
            .percentageFrameWidth(baseView.frame.height / (mainView.frame.height))
            .layerEditor()
            .cornerCurve(.continuous)
            .cornerRadius(30)
            .upperEditor()
            .clipToBounds()
            .attachToSuperviewAndVoidBuild()
        
        let imageViewInsideEditor = ViewEditor(view[2], baseView)
        let imageView = imageViewInsideEditor.debug() //DEBUG
            .percentageFrameWidth(0.30)
            .percentageFrameHeight(0.5)
            .clipToBounds()
            .attachToSuperviewAndBuild()
        
        let topViewInsideEditor = ViewEditor(view[3], baseView)
        let topView = topViewInsideEditor.backgroundColor(.blue) //DEBUG
            .asViewBackground()
            .percentageFrameRelativeX(0.3)
            .percentageFrameWidth(0.7)
            .percentageFrameHeight(0.5)
            .clipToBounds()
            .attachToSuperviewAndBuild()
        
        let botViewInsideEditor = ViewEditor(view[4], baseView)
        let botView = botViewInsideEditor.backgroundColor(.blue) //DEBUG
            .asViewBackground()
            .percentageFrameRelativeY(0.5)
            .percentageFrameHeight(0.5)
            .percentageFrameWidth(1)
            .clipToBounds()
            .attachToSuperviewAndBuild()
        
        let image = view[5]
        let imageInsideEditor = ViewEditor(image, imageView)
        imageInsideEditor.debug() //DEBUG
            .asViewBackground()
            .centerY()
            .centerX()
            .percentageFrameHeight(imageView.frame.width / imageView.frame.height) //cerchio
            .contentMode(.scaleAspectFit)
            .clipToBounds()
            .layerEditor()
            .cornerCurve(.continuous)
            .cornerRadius(50)
            .upperEditor()
            .attachToSuperviewAndVoidBuild()
        
        let titleTopEditor = ViewEditor(view[6], topView)
        titleTopEditor
            .percentageFrameRelativeY(0.05)
            .centerX()
            .percentageFrameWidth(0.75)
            .percentageFrameHeight(0.21)
            .labelEditor()
            .lines(0)
            .centerText()
            .textColor(Colors.GRIGIO)
            .font(Fonts.EUCLID_CIRCULAR_B_Semibold, 30)
            .adjustsFontSizeToFitWidth(true)
            .upperEditor()
            .attachToSuperviewAndVoidBuild()
        
        let squareTopInsideTopEditor = ViewEditor(view[7], topView)
        let squareTopInsideTop = squareTopInsideTopEditor.debug()
            .percentageFrameRelativeY(0.32)
            .centerX()
            .percentageFrameWidth(0.92)
            .percentageFrameHeight(0.62)
            .layerEditor()
            .cornerRadius(25)
            .cornerCurve(.continuous)
            .upperEditor()
            .attachToSuperviewAndBuild()
        
        let botViewInsideLeftEditor = ViewEditor(UIView(), botView)
        let botViewInsideLeft = botViewInsideLeftEditor
            .percentageFrameWidth(0.5)
            .percentageFrameHeight(1)
            .attachToSuperviewAndBuild()
        
        let botViewInsideRightEditor = ViewEditor(UIView(), botView)
        let botViewInsideRight = botViewInsideRightEditor
            .percentageFrameRelativeX(0.5)
            .percentageFrameWidth(0.5)
            .percentageFrameHeight(1)
            .attachToSuperviewAndBuild()
        
        let botViewInsideInnerLeftEditor = ViewEditor(view[8], botViewInsideLeft)
        botViewInsideInnerLeftEditor.debug()
            .asViewBackground()
            .centerX()
            .centerY()
            .percentageFrameHeight(0.92)
            .percentageFrameWidth(0.92)
            .layerEditor()
            .cornerRadius(30)
            .cornerCurve(.continuous)
            .upperEditor()
            .attachToSuperviewAndVoidBuild()
        
        let botViewInsideInnerRightEditor = ViewEditor(view[9], botViewInsideRight)
        botViewInsideInnerRightEditor.debug()
            .asViewBackground()
            .centerX()
            .centerY()
            .percentageFrameHeight(0.92)
            .percentageFrameWidth(0.92)
            .layerEditor()
            .cornerRadius(30)
            .cornerCurve(.continuous)
            .upperEditor()
            .attachToSuperviewAndVoidBuild()
        
        let topViewInnerTitleEditor = ViewEditor(view[10], squareTopInsideTop)
        topViewInnerTitleEditor.debug()
            .asViewBackground()
            .percentageFrameRelativeY(0.05)
            .percentageFrameRelativeX(0.25)
            .percentageFrameHeight(0.3)
            .percentageFrameWidth(0.7)
            .attachToSuperviewAndVoidBuild()
        
        let topViewInnerValueEditor = ViewEditor(view[11], squareTopInsideTop)
        topViewInnerValueEditor.debug()
            .asViewBackground()
            .percentageFrameRelativeY(0.5)
            .percentageFrameRelativeX(0.25)
            .percentageFrameHeight(0.4)
            .percentageFrameWidth(0.7)
            .attachToSuperviewAndVoidBuild()
    }
    
    
    
    func loadRegion() {
        let regionErrorEditor = ViewEditor(regionErrorView, mainView)
        regionErrorEditor
            .percentageFrameRelativeX(0)
            .percentageFrameRelativeY(0.009)
            .percentageFrameWidth(0.94)
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
