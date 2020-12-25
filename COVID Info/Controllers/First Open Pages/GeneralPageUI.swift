//
//  GeneralPageUI.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 25/12/2020.
//

import UIKit

class GeneralPageUI {
    var topView: UIView
    var midView: UIView
    var botView: UIView
    
    var debug: Bool
    
    convenience init(_ topView: UIView, _ midView: UIView, _ botView: UIView) {
        self.init(topView, midView, botView, false)
    }
    
    init(_ topView: UIView, _ midView: UIView, _ botView: UIView, _ debug: Bool) {
        self.topView = topView
        self.midView = midView
        self.botView = botView
        self.debug = debug
        
        prepareFrames()
    }
    
    func prepareFrames() {
        if debug {
            topView.backgroundColor = .red
            midView.backgroundColor = .yellow
            botView.backgroundColor = .blue
        }
        
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
}
