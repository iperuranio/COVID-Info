//
//  GeneralPageUI.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 25/12/2020.
//

import UIKit

class GeneralPageUI {
    var topView: UIView = UIView()
    var midView: UIView = UIView()
    var botView: UIView = UIView()
    
    var mainView = UIView()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    var bigLabel = UILabel()
    var forwardButton = CustomBlueButton()
    
    var imageCenter = UIImageView()
    var background = UIImageView()
    
    var blurView: UIView = UIView()
    
    var debug: Bool
    
    convenience init(_ mainView: UIView, _ topView: UIView, _ midView: UIView, _ botView: UIView) {
        self.init(mainView, topView, midView, botView, false)
    }
    
    init(_ mainView: UIView, _ topView: UIView, _ midView: UIView, _ botView: UIView, _ debug: Bool) {
        self.mainView = mainView
        self.topView = topView
        self.midView = midView
        self.botView = botView
        self.debug = debug
        
        prepareFrames()
    }
    
    func attachSuperView() {
        mainView.addSubview(topView)
        mainView.addSubview(midView)
        mainView.addSubview(botView)
    }
    
    func prepareFrames() {
        topView.frame = FrameEditor.correctFrameWithCustomHeight(FrameEditor.maxScreenWidthSizeFrame(0, 0), 0.165)
        topView.bounds = topView.frame
        let startingTopPoint = topView.frame.height

        midView.frame = FrameEditor.correctFrameWithCustomHeight(FrameEditor.maxScreenWidthSizeFrame(0, startingTopPoint), 0.6)
        midView.bounds = midView.bounds
        let startingMidPoint = midView.frame.height

        botView.frame = FrameEditor.correctFrameWithCustomHeight(FrameEditor.maxScreenWidthSizeFrame(0, startingMidPoint + startingTopPoint), 0.235)
        botView.bounds = botView.frame
        let _ = botView.frame.height
    }
    
    func setupBlurView() -> UIView {
//        let subViewEditor = ViewEditor(blurView, midView)
//        let subView = subViewEditor.backgroundColor(Colors.ACCENT_COLOR)
//            .cornerCurve(.continuous)
//            .cornerRadius(40)
//            .asViewBackground()
//            .percentageFrameWidth(0.92)
//            .centerX()
//            .attachToSuperviewAndBuild()
        
        let blurViewEditor = ViewEditor(blurView, midView)
        blurViewEditor.clearBackground()
            .layerEditor()
            .cornerCurve(.continuous)
            .cornerRadius(40)
            .upperEditor()
            .asViewBackground()
            .clipToBounds()
            .percentageFrameWidth(0.92)
            .centerX()
            .chainBuild()
            .blur(withEffect: .systemMaterialLight)
//            .layerEditor()
//            .shadowColor(Colors.GRIGIO)
//            .shadowOffset(0, 2)
//            .shadowOpacity(1)
//            .maskToBounds(false)
//            .upperEditor()
            .attachToSuperviewAndVoidBuild()
        
        return blurView
    }
    
    func setupBackground(_ image: UIImage) -> UIImageView {
        let viewEditor = ViewEditor(background, mainView)
        viewEditor
            .imageEditor()
            .image(image)
            .upperEditor()
            .asViewBackground()
//            .blur()
            .attachToSuperviewAndVoidBuild()
        
        return background
    }
    
    func setupTitle(_ text: String, _ animated: Bool) -> UILabel {
        var viewEditor = ViewEditor(titleLabel, midView)
        
        viewEditor = viewEditor.clearBackground()
            .clipToBounds()
            .percentageFrameMaxX(0)
            .percentageFrameRelativeY(0.03)
            .percentageFrameWidth(0.65)
            .percentageFrameHeight(0.15)
            .centerX()
            .labelEditor()
            .emptyText()
            .centerText()
            .lines(1)
            .adjustsFontSizeToFitWidth(true)
            .baselineAdjustment(UIBaselineAdjustment.alignCenters)
            .blackText()
            .font(Fonts.EUCLID_CIRCULAR_B_BOLD, 50)
            .upperEditor()
            .attachToSuperView().chainBuild()
        
        if(animated) {
            let _ = viewEditor.labelEditor().classicFlipBottomTransitionText(text)
        } else {
            let _ = viewEditor.labelEditor().text(text)
        }
        
        return titleLabel
    }
    
    func setupSubtitle(_ text: String, _ animated: Bool) -> UILabel {
        var viewEditor = ViewEditor(subTitleLabel, midView)
        
        viewEditor = viewEditor.clearBackground()
            .percentageFrameRelativeY(0.15)
            .percentageFrameWidth(0.65)
            .percentageFrameHeight(0.05)
            .centerX()
            .labelEditor()
            .emptyText()
            .centerText()
            .lines(1)
            .textColor(Colors.SECOND_TEXT_COLOR)
            .adjustsFontSizeToFitWidth(true)
            .baselineAdjustment(UIBaselineAdjustment.alignBaselines)
            .font(Fonts.EUCLID_CIRCULAR_B_LIGHT, 18)
            .upperEditor()
            .attachToSuperView().chainBuild()
        
        if(animated) {
            let _ = viewEditor.labelEditor().classicFlipBottomTransitionText(text)
        } else {
            let _ = viewEditor.labelEditor().text(text)
        }
        return subTitleLabel
    }
    
    func setupImage(_ image: UIImage) -> UIImageView {
        let viewEditor = ViewEditor(imageCenter, midView)
        
        viewEditor.percentageFrameRelativeY(0.260)
            .contentMode(.scaleAspectFit)
            .imageEditor()
            .image(image)
            .upperEditor()
            .percentageFrameWidth(0.6)
            .percentageFrameHeight(0.2)
            .centerX()
            .attachToSuperviewAndVoidBuild()
        
        return imageCenter
    }
    
    func setupBottomTitle(_ text: String, _ animated: Bool) -> UILabel {
        var viewEditor = ViewEditor(bigLabel, midView)

        viewEditor = viewEditor.clearBackground()
            .percentageFrameRelativeY(0.525)
            .percentageFrameWidth(0.87)
            .percentageFrameHeight(0.25)
            .centerX()
            .labelEditor()
            .emptyText()
            .textColor(Colors.SECOND_TEXT_COLOR)
            .centerText()
            .adjustsFontSizeToFitWidth(true)
            .lines(0)
            .baselineAdjustment(UIBaselineAdjustment.alignBaselines)
            .font(Fonts.EUCLID_CIRCULAR_B_LIGHT, 22)
            .upperEditor()
            .attachToSuperView().chainBuild()
        
        if(animated) {
            let _ = viewEditor.labelEditor().classicFlipBottomTransitionText(text)
        } else {
            let _ = viewEditor.labelEditor().text(text)
        }
        
        return bigLabel
    }
    
    func setupForwardButton(_ title: String, _ image: UIImage, _ animate: Bool) -> UIButton {
        let viewEditor = ViewEditor(forwardButton, midView)
        viewEditor
            .clipToBounds()
            .isUserInteractionEnabled(true)
            .contentMode(.scaleToFill)
            .percentageFrameRelativeY(0.815)
            .percentageFrameWidth(0.50)
            .percentageFrameHeight(0.15)
            .centerX()
            .tintColor(.white)
            .layerEditor()
            .cornerCurve(.continuous)
            .cornerRadius(25)
            .shadowColor(Colors.GRIGIO)
            .shadowOffset(0, 3)
            .shadowOpacity(1)
            .maskToBounds(false)
            .upperEditor()
            .buttonEditor()
            .backgroundColor(.blue)
            .imageEdge(0, viewEditor.getViewWidth() * 0.7971014492753623, 0, 0)
            .image(image)
            .horizontalAlignment(.leading)
            .verticalAlignment(.center)
            .upperEditor()
            .attachToSuperviewAndVoidBuild()
//        viewEditor.constraintDebug()
        
        if animate {
            let _ = viewEditor.buttonEditor()
                .preMadeLeftToRightAndReturnAnimation(0.0043, true, 0.1, .allowUserInteraction)
        }

        let viewInTheMiddle = UIView()
        let viewInTheMiddleEditor = ViewEditor(viewInTheMiddle, forwardButton)
        viewInTheMiddleEditor
            .asViewBackground()
            .isUserInteractionEnabled(false)
            .attachToSuperviewAndVoidBuild()

        let labelEditor = ViewEditor(UILabel(), viewInTheMiddle)
        labelEditor.isUserInteractionEnabled(false)
            .labelEditor()
            .text(title)
            .textColor(.white)
            .centerText()
            .font(Fonts.EUCLID_CIRCULAR_B_LIGHT, 18)
            .lines(0)
            .adjustsFontSizeToFitWidth(true)
            .upperEditor()
            .asViewBackground()
//            .percentageFrameRelativeX(0.5)
//            .percentageFrameRelativeY(0.5)
            .percentageFrameHeight(0.38)
//            .percentageFrameRelativeY(0.4)
//            .percentageFrameRelativeX(0.30)
            .percentageFrameWidth(0.4)
            .centerY()
            .percentageFrameRelativeX(0.25)
            .attachToSuperviewAndVoidBuild()
        
        return forwardButton
//        print(forwardButton.titleLabel?.frame)
    }
}
