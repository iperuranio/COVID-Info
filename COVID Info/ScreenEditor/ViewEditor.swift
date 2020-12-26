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
    private var frameToApply = CGRect()
    private var shouldApplyFrameOnBounds = false
    
    private var frameMeasures: [CGFloat] = [0, 0, 0, 0]
    private var absoluteFrameMeasures: [CGFloat] = [0, 0, 0, 0]
    private var centering: [Bool] = [false, false]
    
    private var innerLabelEditor: LabelEditor? = nil
    private var innerImageEditor: ImageEditor? = nil
    
    init() {
        
    }
    
    init(_ view: UIView, _ mainView: UIView) {
        self.view = view
        frameToApply = view.frame
        self.mainView = mainView
        
        absoluteFrameMeasures = [mainView.frame.maxX, mainView.frame.maxY, mainView.frame.width, mainView.frame.height]
        
        if let label = view as? UILabel {
            innerLabelEditor = LabelEditor(label, self)
        }
        
        if let image = view as? UIImageView {
            innerImageEditor = ImageEditor(image, self)
        }
    }
    
    func attachToSuperView() -> ViewEditor {
        mainView.addSubview(view)
        return self
    }
    
    func imageEditor() -> ImageEditor {
        return innerImageEditor!
    }
    
    func labelEditor() -> LabelEditor {
        return innerLabelEditor!
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
            value = mainView.frame.maxX
            break
        case 1:
            value = mainView.frame.maxY
            break
        case 2:
            value = mainView.frame.width
            break
        case 3:
            value = mainView.frame.height
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
    
    func center(_ position: FramePosition) -> ViewEditor {
        centering[position.rawValue] = true
        return self
    }
    
    func asBackground() -> ViewEditor {
        return updateArrayWithFrameMeasures(mainView.frame.minX, .x)
            .updateArrayWithFrameMeasures(mainView.frame.minY, .y)
            .updateArrayWithFrameMeasures(absoluteFrameMeasures[FramePosition.width.rawValue], .width)
            .updateArrayWithFrameMeasures(absoluteFrameMeasures[FramePosition.height.rawValue], .height)
    }
    
    func applyFrameOnBounds() -> ViewEditor {
        self.shouldApplyFrameOnBounds = true
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
        private var imageView: UIImageView
        private var mainInstance: ViewEditor
        
        init(_ imageView: UIImageView, _ mainInstance: ViewEditor) {
            self.imageView = imageView
            self.mainInstance = mainInstance
            
            super.init()
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
    
    class LabelEditor: SubEditor {
        private var label: UILabel
        private var mainInstance: ViewEditor
        
        init(_ label: UILabel, _ mainInstance: ViewEditor) {
            self.label = label
            self.mainInstance = mainInstance
            
            super.init()
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
