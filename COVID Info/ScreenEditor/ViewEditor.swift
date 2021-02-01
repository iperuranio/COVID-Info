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
import DynamicBlurView

class ViewEditor {
    
    enum FramePosition: Int {
        case x
        case y
        case width
        case height
    }

    let tag = 4000
    let maxTag = 10000
    var view: UIView = UIView()
    private var mainView: UIView = UIView()
    private var mainFrame: CGRect = CGRect()
    private var frameToApply = CGRect()
    private var shouldApplyFrameOnBounds = false
    private var blurView = UIVisualEffectView()
    
    private var unsetXVariable = false
    private var unsetYVariable = false
    
    private var frameMeasures: [CGFloat] = [0, 0, 0, 0]
    private var mainViewFrameMeasures: [CGFloat] = [0, 0, 0, 0]
    private var centering: [Bool] = [false, false]
    private var shouldBlur = false
    
    private var innerLabelEditor: LabelEditor? = nil
    private var innerImageEditor: ImageEditor? = nil
    private var innerButtonEditor: ButtonEditor? = nil
    private var innerLayerEditor: LayerEditor? = nil
    private var innerStackEditor: StackEditor? = nil
    
    private var isAddedOnView = false
    
    private let xConstraintIdentifier = "xCostraint"
    private var xConstraint: NSLayoutConstraint?
    private let yConstraintIdentifier = "yConstraint"
    private var yConstraint: NSLayoutConstraint?
    private let widthConstraintIdentifier = "widthConstraint"
    private var widthConstraint: NSLayoutConstraint?
    private let heightConstraintIdentifier = "heightConstraint"
    private var heightConstraint: NSLayoutConstraint?
    private let centerXConstraintIdentifier = "centerXConstraint"
    private var centerXConstraint: NSLayoutConstraint?
    private let centerYConstraintIdentifier = "centerYConstraint"
    private var centerYConstraint: NSLayoutConstraint?
    
    init() {
        
    }
    
    convenience init(_ view: UIView, _ superEditor: ViewEditor) {
        self.init(view, superEditor.view)
        
        innerLabelEditor = superEditor.innerLabelEditor
        innerImageEditor = superEditor.innerImageEditor
        innerButtonEditor = superEditor.innerButtonEditor
        innerLayerEditor = superEditor.innerLayerEditor
        innerStackEditor = superEditor.innerStackEditor
    }
    
    init(_ view: UIView, _ mainView: UIView) {
        self.view = view
        let _ = tag(Int.random(in: tag...maxTag))
        
        frameToApply = view.frame
        self.mainView = mainView
        mainFrame = mainView.frame
        
        if let xConstraint = view.constraintWithIdentifier(xConstraintIdentifier) {
            self.xConstraint = xConstraint
        }
        
        if let yConstraint = view.constraintWithIdentifier(yConstraintIdentifier) {
            self.yConstraint = yConstraint
        }
        
        if let widthConstraint = view.constraintWithIdentifier(widthConstraintIdentifier) {
            self.widthConstraint = widthConstraint
        }
        
        if let heightConstraint = view.constraintWithIdentifier(heightConstraintIdentifier) {
            self.heightConstraint = heightConstraint
        }
        
        if let centerXConstraint = view.constraintWithIdentifier(centerXConstraintIdentifier) {
            self.centerXConstraint = centerXConstraint
        }
        
        if let centerYConstraint = view.constraintWithIdentifier(centerYConstraintIdentifier) {
            self.centerYConstraint = centerYConstraint
        }

        mainViewFrameMeasures = [generateMainMinX(), generateMainMinY(), generateMainWidth(), generateMainHeight()]
        mainFrame = CGRect(x: self.getMainFrameMinX(), y: self.getMainFrameMinY(), width: self.getMainFrameWidth(), height: self.getMainFrameHeight())
        
        if let label = view as? UILabel {
            innerLabelEditor = LabelEditor(label, self)
        }
        
        if let image = view as? UIImageView {
            innerImageEditor = ImageEditor(image, self)
        }
        
        if let button = view as? UIButton {
            innerButtonEditor = ButtonEditor(button, self)
        }
        
        if let stack = view as? UIStackView {
            innerStackEditor = StackEditor(stack, self)
        }
        
        innerLayerEditor = LayerEditor(view.layer, self)
    }
    
    func disableGestureRecognizers() -> ViewEditor {
        for gesture in view.gestureRecognizers! {
            gesture.isEnabled = false
        }
        
        return self
    }
    
    func getFrame() -> CGRect {
        updateFrame()
        return frameToApply
    }
    
    func tag(_ value: Int) -> ViewEditor {
        view.tag = value
        return self
    }
    
    func tagDebug() -> ViewEditor {
        print("DEBUG VIEW WITH TAG \(view.tag)")
        return self
    }
    
    func constraintDebug() -> ViewEditor {
        var toReturn = "\n---------\nConstraints for view \(view.tag)\n"
        var i = 0
        for constraint in view.constraints {
            toReturn.append("(\(i)) \(constraint.toString())\n")
            i += 1
        }
        
        toReturn.append("_________\n")
        
        print(toReturn)
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
        isAddedOnView = true
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
    
    func stackEditor() -> StackEditor {
        return innerStackEditor!
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
        return updateArrayWithFrameMeasures(mainViewFrameMeasures[whichFramePosition.rawValue] * percentage, onWhichDestinationFrameValue)
    }
    
    func getMainFrameMinX() -> CGFloat {
        return mainViewFrameMeasures[FramePosition.x.rawValue]
    }
    
    func getMainFrameMinY() -> CGFloat {
        return mainViewFrameMeasures[FramePosition.y.rawValue]
    }
    
    func getMainFrameWidth() -> CGFloat {
        return mainViewFrameMeasures[FramePosition.width.rawValue]
    }
    
    func getMainFrameHeight() -> CGFloat {
        return mainViewFrameMeasures[FramePosition.height.rawValue]
    }
    
    private func generateMainMinX() -> CGFloat {
        let constraint = mainView.constraintWithIdentifier(xConstraintIdentifier)
        return isTag() ? constraint == nil ? 0 : constraint!.constant : mainFrame.minX
    }
    
    private func generateMainMinY() -> CGFloat {
        let constraint = mainView.constraintWithIdentifier(yConstraintIdentifier)
        return isTag() ? constraint == nil ? 0 : constraint!.constant : mainFrame.minY
    }
    
    private func generateMainWidth() -> CGFloat {
        let constraint = mainView.constraintWithIdentifier(widthConstraintIdentifier)
        return isTag() ? constraint == nil ? 0 : constraint!.constant : mainFrame.width
    }
    
    private func generateMainHeight() -> CGFloat {
        let constraint = mainView.constraintWithIdentifier(heightConstraintIdentifier)
        return isTag() ? constraint == nil ? 0 : constraint!.constant : mainFrame.height
    }
    
    func getBestFontSize() -> CGFloat {
        return self.getViewHeight() - 3
    }
    
    private func isTag() -> Bool {
        return mainView.tag >= tag
    }
    
    func getViewMinX() -> CGFloat {
        return frameMeasures[FramePosition.x.rawValue]
    }
    
    func getViewMinY() -> CGFloat {
        return frameMeasures[FramePosition.y.rawValue]
    }
    
    func getViewWidth() -> CGFloat {
        return frameMeasures[FramePosition.width.rawValue]
    }
    
    func getViewHeight() -> CGFloat {
        return frameMeasures[FramePosition.height.rawValue]
    }
    
    func setMinX(_ value: CGFloat) -> ViewEditor {
        return setFrameValue(value, .x)
    }
    
    func setMinY(_ value: CGFloat) -> ViewEditor {
        return setFrameValue(value, .y)
    }
    
    func setHeight(_ value: CGFloat) -> ViewEditor {
        return setFrameValue(value, .height)
    }
    
    func setWidth(_ value: CGFloat) -> ViewEditor {
        return setFrameValue(value, .width)
    }
    
    func setFrameValue(_ value: CGFloat, _ framePosition: FramePosition) -> ViewEditor {
        return updateArrayWithFrameMeasures(value, framePosition)
    }
    
    
    func tintColor(named name: String) -> ViewEditor {
        return tintColor(UIColor(named: name)!)
    }
    
    func tintColor(_ color: UIColor) -> ViewEditor {
        view.tintColor = color
        return self
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
    
    func frame(_ frame: CGRect) -> ViewEditor {
        return updateArrayWithFrameMeasures(frame.minX, .x)
            .updateArrayWithFrameMeasures(frame.minY, .y)
            .updateArrayWithFrameMeasures(frame.width, .width)
            .updateArrayWithFrameMeasures(frame.height, .height)
    }
    
    private func percentage(_ percentage: CGFloat, _ value: CGFloat) -> CGFloat {
        return percentage * value
    }
    
    func translatesAutoresizingMaskIntoConstraints(_ value: Bool) -> ViewEditor {
        view.translatesAutoresizingMaskIntoConstraints = value
        return self
    }
    
    func centerX() -> ViewEditor {
        return center(.x)
    }
    
    func centerY() -> ViewEditor {
        return center(.y)
    }
    
    func blur(withEffect blurStyle: UIBlurEffect.Style) -> ViewEditor {
//        blurView.blendColor = .white
        let effect = UIBlurEffect(style: blurStyle)
        
        blurView.effect = effect
//                bottomBlurView.blurRadius = CGFloat(slider.maximumValue)
//        blurView.iterations = 10
        
        self.shouldBlur = true
        return self
    }
    
    func blur() -> ViewEditor {
        return blur(withEffect: .systemMaterial)
    }
    
    func center(_ position: FramePosition) -> ViewEditor {
        centering[position.rawValue] = true
        return self
    }
    
    func asViewBackground() -> ViewEditor {
        return updateArrayWithFrameMeasures(0, .x)
            .updateArrayWithFrameMeasures(0, .y)
            .updateArrayWithFrameMeasures(mainViewFrameMeasures[FramePosition.width.rawValue], .width)
            .updateArrayWithFrameMeasures(mainViewFrameMeasures[FramePosition.height.rawValue], .height)
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
    
    func isUserInteractionEnabled(_ value: Bool) -> ViewEditor {
        view.isUserInteractionEnabled = value
        return self
    }
    
    func chainBuild() -> ViewEditor {
        let _  = build()
        return self
    }
    
    func unsetX() -> ViewEditor {
        return unsetAxe(.x)
    }
    
    func unsetY() -> ViewEditor {
        return unsetAxe(.y)
    }
    
    func unsetAxis() -> ViewEditor {
        return unsetX().unsetY()
    }
    
    func unsetAxe(_ axe: FramePosition) -> ViewEditor {
        if(axe.rawValue == 0) {
            unsetXVariable = true
        } else if(axe.rawValue == 1) {
            unsetYVariable = true
        }
        
        return self
    }
    
    private func updateConstraint(_ constraint: inout NSLayoutConstraint?, _ toConstraint: NSLayoutConstraint, _ fallBackValue: CGFloat) {
        if(constraint == nil) {
            constraint = toConstraint
            constraint!.isActive = true
//            print("aggiorno \(constraint!.toString())")
        } else {
            constraint!.constant = fallBackValue
//            view.layoutIfNeeded()
        }
        
        view.updateConstraints()
    }
    
    func build() -> UIView {
        updateFrame()
//        view.frame = frameToApply
        
        let _ = translatesAutoresizingMaskIntoConstraints(false)
        
        if(!isAddedOnView) {
            let _ = attachToSuperView()
        }
        
        var leading = NSLayoutConstraint()
        if(!unsetXVariable) {
            leading = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1, constant: frameMeasures[FramePosition.x.rawValue])
            leading.identifier = xConstraintIdentifier
        }
        
        var top = NSLayoutConstraint()
        if(!unsetYVariable) {
            top = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1, constant: frameMeasures[FramePosition.y.rawValue])
            top.identifier = yConstraintIdentifier
        }
        
        let width = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frameMeasures[FramePosition.width.rawValue])
        width.identifier = widthConstraintIdentifier
        
        let height = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frameMeasures[FramePosition.height.rawValue])
        height.identifier = heightConstraintIdentifier
        
        let centerX = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: mainView, attribute: .centerX, multiplier: 1, constant: 0)
        centerX.identifier = centerXConstraintIdentifier
        
        let centerY = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: mainView, attribute: .centerY, multiplier: 1, constant: 0)
        centerY.identifier = centerYConstraintIdentifier
        
        updateConstraint(&widthConstraint, width, frameMeasures[FramePosition.width.rawValue])
        updateConstraint(&heightConstraint, height, frameMeasures[FramePosition.height.rawValue])

        if(centering[FramePosition.x.rawValue]) {
            updateConstraint(&centerXConstraint, centerX, 0)
        } else {
            if(!unsetXVariable) {
                updateConstraint(&xConstraint, leading, frameMeasures[FramePosition.x.rawValue])
            }
        }

        if(centering[FramePosition.y.rawValue]) {
            updateConstraint(&centerYConstraint, centerY, 0)
        } else {
            if(!unsetYVariable) {
                updateConstraint(&yConstraint, top, frameMeasures[FramePosition.y.rawValue])
            }
        }
        
//        print("processed view \(view)")
        
//        if(shouldApplyFrameOnBounds) {
//            view.bounds = frameToApply
//        }
        
        if(shouldBlur) {
            let blurEditor = ViewEditor(blurView, view)

            if(centering[FramePosition.x.rawValue]) {
                blurEditor.centerX().void()
            }

            if(centering[FramePosition.y.rawValue]) {
                blurEditor.centerY().void()
            }

            blurEditor
                .asViewBackground()
                .clipToBounds()
                .attachToSuperviewAndVoidBuild()
        }
        
        return view
    }
    
    func notAttachToSuperview() -> ViewEditor {
        isAddedOnView = true
        return self
    }
    
    func attachToSuperviewAndBuild() -> UIView {
        return attachToSuperView().build()
    }
    
    func attachToSuperviewAndVoidBuild() {
        return attachToSuperView().voidBuild()
    }
    
    func void() {
        
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
        
        func borderWidth(_ value: CGFloat) -> LayerEditor {
            layer.borderWidth = value
            return self
        }
        
        func borderColor(_ color: UIColor) -> LayerEditor {
            layer.borderColor = color.cgColor
            return self
        }
        
        func borderColor(named name: String) -> LayerEditor {
            return borderColor(UIColor(named: name)!)
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
    
    class StackEditor: SubEditor {
        private var stackView = UIStackView()
        private var mainInstance: ViewEditor = ViewEditor()
        
        init(_ stackView: UIStackView, _ mainInstance: ViewEditor) {
            self.stackView = stackView
            self.mainInstance = mainInstance
        }
        
        func addArrangedSubviews(_ views: [UIView]) -> StackEditor {
            views.forEach { view in views
                addArrangedSubview(view)
            }
            
            return self
        }
        
        func addArrangedSubview(_ view: UIView) -> StackEditor {
            stackView.addArrangedSubview(view)
            return self
        }
        
        func axis(_ axis: NSLayoutConstraint.Axis) -> StackEditor {
            stackView.axis = axis
            return self
        }
        
        func distribution(_ distribution: UIStackView.Distribution) -> StackEditor {
            stackView.distribution = distribution
            return self
        }
        
        func alignment(_ alignment: UIStackView.Alignment) -> StackEditor {
            stackView.alignment = alignment
            return self
        }
        
        func spacing(_ spacing: CGFloat) -> StackEditor {
            stackView.spacing = spacing
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
        
        func preMadeLeftToRightAndReturnAnimation(_ after: TimeInterval, _ repeats: Bool, _ duration: TimeInterval, _ options: UIView.AnimationOptions, _ resultText: String? /*(() -> Void)?*/ = nil, completion: ((Bool) -> Void)? = nil) -> ButtonEditor {
            let min: CGFloat = mainInstance.getViewWidth() * 0.7971014492753623 //una percentuale dell'asse X
            var offset: CGFloat = min
            let max: CGFloat = mainInstance.getViewWidth() * 0.8454106280193237 //una percentuale dell'asse X 0.8454106280193237
            var forward: Bool = true
            
            _ = Timer.scheduledTimer(withTimeInterval: after, repeats: repeats) { timer in
                UIView.transition(with: self.button,
                                  duration: duration,
                                  options: options,
                            animations: { [weak self] in
                                let increment: CGFloat = 0.1
                                
                                if(!forward) {
                                    if(offset < min) {
                                        forward = true
                                    }
                                    
                                    offset = offset - increment
                                } else {
                                    if(offset > max) {
                                        forward = false
                                    }
                                    
                                    offset = offset + increment
                                }
                                
                                let _ = self?.imageEdge(0, offset, 0, 0)
                            }, completion: completion)
            }
            
            return self
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
        
        func centerTitleX() -> ButtonEditor { //button.imageView?.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -8.0).isActive = true
            button.imageView?.centerXAnchor.constraint(equalTo: button.centerXAnchor, constant: 0.0).isActive = true
            return self
        }
        
        func centerTitleY() -> ButtonEditor {
            button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 0.0).isActive = true
            return self
        }
        
//
//
//        func titleEdgeLeftPercentage(_ top: CGFloat, percentage: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> ButtonEditor {
//            let rect = button.titleLabel?.attributedText?.size()
//
//            let w = rect!.width
//            let h = rect!.height
//
//            let v = UIView(frame: CGRect())
//            v.backgroundColor = .red
//            self.upperEditor().mainView.addSubview(v)
//
////            button.titleLabel?.backgroundColor = .red
//
//            return titleEdge(top,
//                             0,
//                             bottom,
//                             right)
//
////            return titleEdge(top * (button.frame.height),
////                             left * (button.frame.width),
////                             bottom * (button.frame.height),
////                             right * (button.frame.width))
//        }
//
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
        
        func buttonImageViewEditor() -> ViewEditor {
            return innerViewEditor(button.imageView!)
        }
        
        private func innerViewEditor(_ view: UIView) -> ViewEditor {
            return ViewEditor(view, mainInstance)
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
        
        enum TextTransitions: Int {
            case classicFlipBottom
            
            var transition: Transition {
                switch self {
                    case .classicFlipBottom:
                        return Transition(0, false, 0.30, .transitionFlipFromBottom, nil)
                }
            }
        }
        
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
        
        func minimumScaleFactor(_ value: CGFloat) -> LabelEditor {
            label.minimumScaleFactor = value
            return self
        }
        
        func baselineAdjustment(_ value: UIBaselineAdjustment) -> LabelEditor {
            label.baselineAdjustment = value
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
        
        func lineBreakMode(_ value: NSLineBreakMode) -> LabelEditor { // ByCharWrapping non taglia
            label.lineBreakMode = value
            return self
        }
        
        func textAlignment(_ alignment: NSTextAlignment) -> LabelEditor {
            label.textAlignment = alignment
            return self
        }
        
        func text(_ text: String) -> LabelEditor {
            label.text = text
            return self
        }
        
        func classicFlipBottomTransitionText(_ resultText: String) -> LabelEditor {
            return transitionText(TextTransitions.classicFlipBottom.transition.withAnimation({ [weak self] in
                self?.label.text = resultText
            }))
        }
        
        func transitionText(_ transition: Transition) -> LabelEditor {
            _ = Timer.scheduledTimer(withTimeInterval: transition.after, repeats: transition.repeats) { timer in
                UIView.transition(with: self.label,
                                  duration: transition.duration,
                                  options: transition.options,
                                  animations: transition.animation, completion: transition.completion)
            }
            
            return self
        }
    }
}
