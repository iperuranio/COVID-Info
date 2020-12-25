//
//  File.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 25/12/2020.
//

import UIKit

class FrameEditor {
    
    static func correctFrameWithCustomHeight(_ frame: CGRect, _ percentageFloat: CGFloat) -> CGRect {
        return correctFrameFromHeight(frame, (FirstLaunchController.frame?.height)!, percentageFloat)
    }
    
    static func correctFrame(_ frame: CGRect, _ percentageFloat: CGFloat) -> CGRect {
        return correctFrameFromHeight(frame, (MainScreenController.instance?.fullscreenFrame.height)!, percentageFloat)
    }
    
    static func correctFrameFromHeight(_ frame: CGRect, _ screenHeight: CGFloat, _ percentageFloat: CGFloat) -> CGRect {
        return CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: percentageFloat * screenHeight)
    }
    
    static func maxScreenWidthSizeFrame(_ minX: CGFloat, _ minY: CGFloat) -> CGRect {
        return maxScreenWidthSizeFrameAndCustomHeight(minX, minY, 0)
    }
    
    static func maxScreenWidthSizeFrameAndCustomHeight(_ minX: CGFloat, _ minY: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY, width: UIScreen.main.bounds.maxX, height: height)
    }
}
