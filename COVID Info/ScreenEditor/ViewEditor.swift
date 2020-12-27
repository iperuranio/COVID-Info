//
//  ViewEditor.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 26/12/2020.
//
//let y = (0.285 * midFrame.height)
//let width = 0.6 * midFrame.width
//let height = (0.2 * midFrame.height)
//
//imageCenter.frame = CGRect(x: 0, y: y, width: width, height: height)
//imageCenter.center.x = self.view.center.x
import UIKit

class ViewEditor {
    
    enum FramePosition: Int {
        case x
        case y
        case width
        case height
    }

    var view: UIView = UIView()
    private var mainView: UIView = UIView()
    private var mainFrame: CGRect = CGRect()
    private var frameToApply = CGRect()
    private var shouldApplyFrameOnBounds = false
    
    private var frameMeasures: [CGFloat] = [0, 0, 0, 0]
    private var absoluteFrameMeasures: [CGFloat] = [0, 0, 0, 0]
    private var centering: [Bool] = [false, false]
    private var shouldBlur = false
    
    private var innerLabelEditor: LabelEditor? = nil
    private var innerImageEditor: ImageEditor? = nil
    private var innerButtonEditor: ButtonEditor? = nil
    private var innerLayerEditor: LayerEditor? = nil
    
    init() {
        
    }
    
    init(_ view: UIView, _ mainView: UIView) {
        self.view = view
        frameToApply = view.frame
        self.mainView = mainView
        mainFrame = mainView.frame
        
        absoluteFrameMeasures = [mainFrame.maxX, mainFrame.maxY, mainFrame.width, mainFrame.height]
        
        if let label = view as? UILabel {
            innerLabelEditor = LabelEditor(label, self)
        }
        
        if let image = view as? UIImageView {
            innerImageEditor = ImageEditor(image, self)
        }
        
        if let button = view as? UIButton {
            innerButtonEditor = ButtonEditor(button, self)
        }
        
        innerLayerEditor = LayerEditor(view.layer, self)
    }
    
    func tag(_ value: Int) -> ViewEditor {
        view.tag = value
        return self
    }
    
    func debug() -> ViewEditor {
        return debug(true)
    }
    
    func debug(_ value: Bool) -> ViewEditor {
        return !value ? self : backgroundColor(.random)
    }
    
    func attachToSuperView() -> ViewEditor {
        mainView.addSubview(view)
        return self
    }
    
    func buttonEditor() -> ButtonEditor {
        return innerButtonEditor!
    }
    
    func imageEditor() -> ImageEditor {
        return innerImageEditor!
    }
    
    func labelEditor() -> LabelEditor {
        return innerLabelEditor!
    }
    
    func layerEditor() -> LayerEditor {
        return innerLayerEditor!
    }
    
    func clipToBounds() -> ViewEditor {
        view.clipsToBounds = true
        return self
    }

    private func updateFrame() {
        frameToApply = CGRect(x: frameMeasures[0], y: frameMeasures[1], width: frameMeasures[2], height: frameMeasures[3])
    }
    
    private func updateArrayWithFrameMeasures(_ value: CGFloat, _ position: FramePosition) -> ViewEditor {
        frameMeasures[position.rawValue] = value
        
        return self
    }
    
    func percentageCustomFramePosition(_ percentage: CGFloat, _ whichFramePosition: FramePosition, _ onWhichDestinationFrameValue: FramePosition) -> ViewEditor {
        var value: CGFloat = 0
        
        switch whichFramePosition.rawValue {
        case 0:
            value = mainFrame.maxX
            break
        case 1:
            value = mainFrame.maxY
            break
        case 2:
            value = mainFrame.width
            break
        case 3:
            value = mainFrame.height
            break
        default:
            break
        }
//        print("request \(percentage) value: \(value) calcol: \(value * percentage) on \(whichFramePosition.rawValue) \(onWhichDestinationFrameValue.rawValue)")
        
        return updateArrayWithFrameMeasures(value * percentage, onWhichDestinationFrameValue)
    }
    
    func backgroundColor(named name: String) -> ViewEditor {
        return backgroundColor(UIColor(named: name)!)
    }
    
    func backgroundColor(_ color: UIColor) -> ViewEditor {
        view.backgroundColor = color
        return self
    }
    
    func clearBackground() -> ViewEditor {
        return backgroundColor(.clear)
    }
    
    func percentageFrameRelativeX(_ percentage: CGFloat) -> ViewEditor {
        return percentageCustomFramePosition(percentage, .width, .x)
    }
    
    func percentageFrameRelativeY(_ percentage: CGFloat) -> ViewEditor {
        return percentageCustomFramePosition(percentage, .height, .y)
    }
    
    func percentageFrameMaxX(_ percentage: CGFloat) -> ViewEditor {
        return percentageCustomFramePosition(percentage, .x, .x)
    }
    
    func percentageFrameMaxY(_ percentage: CGFloat) -> ViewEditor {
        return percentageCustomFramePosition(percentage, .y, .y)
    }
    
    func percentageFrameWidth(_ percentage: CGFloat) -> ViewEditor {
        return percentageCustomFramePosition(percentage, .width, .width)
    }
    func percentageFrameHeight(_ percentage: CGFloat) -> ViewEditor {
        return percentageCustomFramePosition(percentage, .height, .height)
    }
    
    private func percentage(_ percentage: CGFloat, _ value: CGFloat) -> CGFloat {
        return percentage * value
    }
    
    func centerX() -> ViewEditor {
        return center(.x)
    }
    
    func centerY() -> ViewEditor {
        return center(.y)
    }
    
    func blur() -> ViewEditor {
        self.shouldBlur = true
        return self
    }
    
    func center(_ position: FramePosition) -> ViewEditor {
        centering[position.rawValue] = true
        return self
    }
    
    func asViewBackground() -> ViewEditor {
        return updateArrayWithFrameMeasures(0, .x)
            .updateArrayWithFrameMeasures(0, .y)
            .updateArrayWithFrameMeasures(absoluteFrameMeasures[FramePosition.width.rawValue], .width)
            .updateArrayWithFrameMeasures(absoluteFrameMeasures[FramePosition.height.rawValue], .height)
    }
    
    func asScreenBackground() -> ViewEditor {
        return updateArrayWithFrameMeasures(0, .x)
            .updateArrayWithFrameMeasures(0, .y)
            .updateArrayWithFrameMeasures(MainScreenController.fullscreenFrame.width, .width)
            .updateArrayWithFrameMeasures(MainScreenController.fullscreenFrame.height, .height)
    }
    
    func applyFrameOnBounds() -> ViewEditor {
        self.shouldApplyFrameOnBounds = true
        return self
    }
    
    func contentMode(_ contentMode: UIView.ContentMode) -> ViewEditor {
        view.contentMode = contentMode
        return self
    }
    
    func build() -> UIView {
        updateFrame()
        view.frame = frameToApply
        
        if(centering[FramePosition.x.rawValue]) {
            view.center.x = mainView.center.x
        }
        
        if(centering[FramePosition.y.rawValue]) {
            view.center.y = mainView.center.y
        }
        
        if(shouldApplyFrameOnBounds) {
            view.bounds = frameToApply
        }
        
        if(shouldBlur) {
            let blurView = UIView.getBlurView(view)
            view.addSubview(blurView)
        }
        
        return view
    }
    
    func attachToSuperviewAndBuild() -> UIView {
        return attachToSuperView().build()
    }
    
    func attachToSuperviewAndVoidBuild() {
        return attachToSuperView().voidBuild()
    }
    
    func voidBuild() {
        let _ = build()
    }
    
    class SubEditor {
        init() {
            
        }
        
        func upperEditor() -> ViewEditor {
            preconditionFailure("must be overrided")
        }
    }
    
    class ImageEditor: SubEditor {
        private var imageView: UIImageView = UIImageView()
        private var mainInstance: ViewEditor = ViewEditor()
        
        init(_ imageView: UIImageView, _ mainInstance: ViewEditor) {
            self.imageView = imageView
            self.mainInstance = mainInstance
        }
        
        func image(named name: String) -> ImageEditor {
            return image(UIImage(named: name)!)
        }
        
        func image(_ image: UIImage) -> ImageEditor {
            imageView.image = image
            return self
        }
        
        override func upperEditor() -> ViewEditor {
            return mainInstance
        }
    }
    
    class LayerEditor: SubEditor {
        private var layer: CALayer = CALayer()
        private var mainInstance: ViewEditor = ViewEditor()
        
        init(_ layer: CALayer, _ mainInstance: ViewEditor) {
            self.layer = layer
            self.mainInstance = mainInstance
        }
        
        func shadowColor(named name: String) -> LayerEditor {
            return shadowColor(UIColor(named: name)!)
        }
        
        func shadowColor(_ color: UIColor) -> LayerEditor {
            layer.shadowColor = color.cgColor
            return self
        }
        
        func shadowOffset(_ width: CGFloat, _ height: CGFloat) -> LayerEditor {
            layer.shadowOffset = CGSize(width: width, height: height)
            return self
        }
        
        func shadowOpacity(_ opacity: Float) -> LayerEditor {
            layer.shadowOpacity = opacity
            return self
        }
        
        func shadowRadius(_ value: CGFloat) -> LayerEditor {
            layer.shadowRadius = value
            return self
        }
        
        func maskToBounds(_ value: Bool) -> LayerEditor {
            layer.masksToBounds = value
            return self
        }
        
        func cornerRadius(_ value: CGFloat) -> LayerEditor {
            layer.cornerRadius = value
            return self
        }
        
        func cornerCurve(_ value: CALayerCornerCurve) -> LayerEditor {
            layer.cornerCurve = value
            return self
        }
        
        override func upperEditor() -> ViewEditor {
            return mainInstance
        }
    }
    
    class ButtonEditor: SubEditor {
        private var button: UIButton = UIButton()
        private var mainInstance: ViewEditor = ViewEditor()
        
        init(_ button: UIButton, _ mainInstance: ViewEditor) {
            self.button = button
            self.mainInstance = mainInstance
        }
        
        func image(named name: String) -> ButtonEditor {
            return image(UIImage(named: name)!)
        }
        
        func image(_ image: UIImage) -> ButtonEditor {
            button.setImage(image, for: .normal)
            return self
        }
        
        func backgroundImage(named name: String) -> ButtonEditor {
            return image(UIImage(named: name)!)
        }
        
        func titleEdge(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> ButtonEditor {
            return titleEdge(UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
        }
        
        func titleEdge(_ edge: UIEdgeInsets) -> ButtonEditor {
            button.titleEdgeInsets = edge
            return self
        }
        
        func contentEdge(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> ButtonEditor {
            return contentEdge(UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
        }
        
        func contentEdge(_ edge: UIEdgeInsets) -> ButtonEditor {
            button.contentEdgeInsets = edge
            return self
        }
        
        func imageEdge(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> ButtonEditor {
            return imageEdge(UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
        }
        
        func imageEdge(_ edge: UIEdgeInsets) -> ButtonEditor {
            button.imageEdgeInsets = edge
            return self
        }
        
        func title(_ title: String) -> ButtonEditor {
            button.setTitle(title, for: .normal)
            return self
        }
        
        func backgroundColor(named name: String) -> ButtonEditor {
            return backgroundColor(UIColor(named: name)!)
        }
        
        func backgroundColor(_ color: UIColor) -> ButtonEditor {
            button.backgroundColor = color
            return self
        }
        
        func shadowColor(named name: String) -> ButtonEditor {
            return shadowColor(UIColor(named: name)!)
        }
        
        func shadowColor(_ color: UIColor) -> ButtonEditor {
            button.setTitleShadowColor(color, for: .normal)
            return self
        }
        
        func showsTouchOnHighlight() -> ButtonEditor {
            button.showsTouchWhenHighlighted = true
            return self
        }
        
        func reversesTitleShadowWhenHighlighted() -> ButtonEditor {
            button.reversesTitleShadowWhenHighlighted = true
            return self
        }

        func buttonLabelEditor() -> LabelEditor {
            return LabelEditor(button.titleLabel!, mainInstance)
        }
        
        func titleColor(named name: String) -> ButtonEditor {
            return titleColor(UIColor(named: name)!)
        }
        
        func titleColor(_ color: UIColor) -> ButtonEditor {
            button.setTitleColor(color, for: .normal)
            return self
        }
        
        func horizontalAlignment(_ alignment: UIControl.ContentHorizontalAlignment) -> ButtonEditor {
            button.contentHorizontalAlignment = alignment
            return self
        }
        
        func verticalAlignment(_ alignment: UIControl.ContentVerticalAlignment) -> ButtonEditor {
            button.contentVerticalAlignment = alignment
            return self
        }
        
        func backgroundImage(_ image: UIImage) -> ButtonEditor {
            button.setBackgroundImage(image, for: .normal)
            return self
        }
        
        override func upperEditor() -> ViewEditor {
            return mainInstance
        }
    }
    
    class LabelEditor: SubEditor {
        private var label: UILabel = UILabel()
        private var mainInstance: ViewEditor = ViewEditor()
        
        init(_ label: UILabel, _ mainInstance: ViewEditor) {
            self.label = label
            self.mainInstance = mainInstance
        }
        
        override func upperEditor() -> ViewEditor {
            return mainInstance
        }
        
        func emptyText() -> LabelEditor {
            return text("")
        }
        
        func blackText() -> LabelEditor {
            return textColor(.black)
        }
        
        func font(_ enumFont: Fonts, _ size: CGFloat) -> LabelEditor {
            return font(enumFont.font(size))
        }
        
        func font(named: String, size: CGFloat) -> LabelEditor {
            return font(UIFont(name: named, size: size)!)
        }
        
        func font(_ font: UIFont) -> LabelEditor {
            label.font = font
            return self
        }
        
        func lines(_ lines: Int) -> LabelEditor {
            label.numberOfLines = lines
            return self
        }
        
        func adjustsFontSizeToFitWidth(_ value: Bool) -> LabelEditor {
            label.adjustsFontSizeToFitWidth = value
            return self
        }
        
        func baselineAdjustment(_ value: UIBaselineAdjustment) -> LabelEditor {
            label.baselineAdjustment = value
            return self
        }
        
        func lineBreak(_ value: NSLineBreakMode) -> LabelEditor {
            label.lineBreakMode = value
            return self
        }
        
        func textColor(named name: String) -> LabelEditor {
            return textColor(UIColor(named: name)!)
        }
        
        func textColor(_ color: UIColor) -> LabelEditor {
            label.textColor = color
            return self
        }
        
        func centerText() -> LabelEditor {
            return textAlignment(.center)
        }
        
        func textAlignment(_ alignment: NSTextAlignment) -> LabelEditor {
            label.textAlignment = alignment
            return self
        }
        
        func text(_ text: String) -> LabelEditor {
            label.text = text
            return self
        }
        
        func transitionText(_ after: TimeInterval, _ repeats: Bool, _ duration: TimeInterval, _ options: UIView.AnimationOptions, _ resultText: String /*(() -> Void)?*/, completion: ((Bool) -> Void)? = nil) -> LabelEditor {
            _ = Timer.scheduledTimer(withTimeInterval: after, repeats: repeats) { timer in
                UIView.transition(with: self.label,
                                  duration: duration,
                                  options: options,
                            animations: { [weak self] in
                                self?.label.text = resultText
                            }, completion: completion)
            }
            
            return self
        }
    }
}
