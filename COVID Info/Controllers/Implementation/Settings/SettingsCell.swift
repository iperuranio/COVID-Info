//
//  SettingsCell.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 01/02/2021.
//

import UIKit

class SettingsCell: UITableViewCell {
    var logoImageView = UIImageView()
    var titleLabel = UILabel()
    var buttonIcon = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(buttonIcon)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setData(_ image: UIImage, _ text: String) {
        logoImageView.image = image
        titleLabel.text = text
    }
    
    func setupViews() {
        let imageViewEditor = ViewEditor(logoImageView, self)
        imageViewEditor
            .percentageFrameRelativeX(0.072)
            .percentageFrameHeight(0.95)
            .setWidth(imageViewEditor.getViewHeight())
            .centerY()
            .notAttachToSuperview()
            .voidBuild()
        
        let titleViewEditor = ViewEditor(titleLabel, self)
        titleViewEditor
            .setMinX(imageViewEditor.getViewMinX() + imageViewEditor.getViewHeight() + (0.08 * imageViewEditor.getMainFrameWidth()))
            .percentageFrameHeight(0.425)
            .percentageFrameWidth(0.8)
            .centerY()
            .labelEditor()
            .lines(1)
            .adjustsFontSizeToFitWidth(true)
            .font(Fonts.EUCLID_CIRCULAR_B_LIGHT, titleViewEditor.getBestFontSize())
            .upperEditor()
            .notAttachToSuperview()
            .voidBuild()
        
        let fullscreenWidth = MainScreenController.fullscreenFrame.width
        let buttonIconViewEditor = ViewEditor(buttonIcon, self)
        buttonIconViewEditor
            .percentageFrameHeight(0.375)
            .setWidth(imageViewEditor.getViewHeight())
            .setMinX(fullscreenWidth - imageViewEditor.getViewWidth() - (0.035 * fullscreenWidth))
//            .setMinX(buttonIconViewEditor.getMainFrameWidth() - buttonIconViewEditor.getViewWidth())
            .centerY()
            .contentMode(.scaleAspectFit)
            .tintColor(.white)
            .imageEditor()
            .image(Images.CHEVRON_RIGHT)
            .upperEditor()
            .notAttachToSuperview()
            .voidBuild()

        
//        font.lineHeight = titleViewEditor.getViewHeight()
        
//        titleViewEditor.labelEditor()
//            .font(font)
//            .upperEditor().void()
    }
    
}
