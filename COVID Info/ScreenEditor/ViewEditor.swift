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
    var view: UIView
    private var mainView: UIView
    private var frameToApply = CGRect()
    private var shouldApplyFrameOnBounds = false
    
    private var frameMeasures: [CGFloat] = [0, 0, 0, 0]
    private var absoluteFrameMeasures: [CGFloat] = [0, 0, 0, 0]
    private var centering: [Bool] = [false, false]
    
    init(_ view: UIView, _ mainView: UIView) {
        self.view = view
        frameToApply = view.frame
        self.mainView = mainView
        
        absoluteFrameMeasures = [mainView.frame.maxX, mainView.frame.maxY, mainView.frame.width, mainView.frame.height]
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
    
    enum FramePosition: Int {
        case x
        case y
        case width
        case height
    }
}
