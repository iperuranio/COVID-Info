//
//  CustomButton.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 28/12/2020.
//

import UIKit

class CustomBlueButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .blue : Colors.SELECTED_BUTTON
        }
    }
}
