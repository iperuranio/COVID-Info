//
//  Transition.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 28/12/2020.
//

import UIKit

class Transition {
    var after: TimeInterval = 0
    var repeats: Bool = false
    var duration: TimeInterval = 0
    var options: UIView.AnimationOptions = .curveEaseIn
    var animation: (() -> Void)? = nil
    var completion: ((Bool) -> Void)? = nil
    
    init(_ after: TimeInterval, _ repeats: Bool, _ duration: TimeInterval, _ options: UIView.AnimationOptions, _ animation: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
        self.after = after
        self.duration = duration
        self.options = options
        self.animation = animation
        self.completion = completion
    }
    
    func withAnimation(_ animation: (() -> Void)?) -> Transition {
        self.animation = animation
        return self
    }
}
