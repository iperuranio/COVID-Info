//
//  SettingCellData.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 01/02/2021.
//

import UIKit

class SettingCellData {
    var image: UIImage? = UIImage()
    var text = String()
    var isSeparator = false
    var color = UIColor()
    var toExecute: (() -> Void)? = nil
    
    init(_ image: UIImage?, _ text: String, _ separator: Bool = false, _ toExecute: (() -> Void)? = nil) {
        self.image = image
        self.text = text
        isSeparator = separator
        self.toExecute = toExecute
        
        color = isSeparator ? SettingsViewController.separatorColor : SettingsViewController.mainColor
    }
    
    func execute() {
        toExecute?()
    }
}
