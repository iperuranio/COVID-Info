//
//  SettingsCell.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 01/02/2021.
//

import UIKit

class SettingsCell: UITableViewCell {
    let percentageLeftOffset: CGFloat = 0.072
    
    var logoImageView = UIImageView()
    var titleLabel = UILabel()
    var buttonIcon = UIImageView()
    
    var measures: [CGFloat] = []
    
    var isSeparator = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(buttonIcon)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setData(_ data: SettingCellData, _ visible: Bool) {
        if(!visible) {
            return
        }
        
        logoImageView.image = data.image
        titleLabel.text = data.text
        isSeparator = data.isSeparator
        
        self.backgroundColor = data.color
        self.selectionStyle = isSeparator ? .none : .default
        setupViews()
    }
    
    private func setupViews() {
        let titleViewEditor = ViewEditor(titleLabel, self)
        titleViewEditor
            .labelEditor()
            .lines(1)
            .adjustsFontSizeToFitWidth(true)
            .upperEditor()
            .notAttachToSuperview()
            .void()
        
        if(!isSeparator) {
            let imageViewEditor = ViewEditor(logoImageView, self)
            imageViewEditor
                .percentageFrameRelativeX(percentageLeftOffset)
                .percentageFrameHeight(0.95)
                .setWidth(imageViewEditor.getViewHeight())
                .centerY()
                .chainBuild()
                .unactiveExternalConstraints()
                .void()
            
            titleViewEditor
                .setMinX(imageViewEditor.getViewMinX() + imageViewEditor.getViewHeight() + (0.04 * SettingsViewController.Measures.ROW_WIDTH.value))
                .percentageFrameHeight(0.425)
                .percentageFrameWidth(0.8)
                .centerY()
                .labelEditor()
                .font(Fonts.EUCLID_CIRCULAR_B_LIGHT, titleViewEditor.getBestFontSize())
                .upperEditor()
                .notAttachToSuperview()
                .voidBuild()
            
            let fullscreenWidth = SettingsViewController.Measures.ROW_WIDTH.value
            let buttonIconViewEditor = ViewEditor(buttonIcon, self)
            buttonIconViewEditor
                .percentageFrameHeight(0.375)
                .setWidth(imageViewEditor.getViewHeight())
                .setMinX(fullscreenWidth - imageViewEditor.getViewWidth() - (0.035 * fullscreenWidth))
                .centerY()
                .contentMode(.scaleAspectFit)
                .tintColor(.white)
                .imageEditor()
                .image(Images.CHEVRON_RIGHT)
                .upperEditor()
                .notAttachToSuperview()
                .voidBuild()
        } else {
            titleViewEditor.percentageFrameRelativeX(percentageLeftOffset)
                .percentageFrameHeight(0.38)
                .setMinY(SettingsViewController.Measures.ROW_HEIGHT.value - titleViewEditor.getViewHeight() - (0.045 * SettingsViewController.Measures.ROW_HEIGHT.value))
                .percentageFrameWidth(0.5)
                .labelEditor()
                .textColor(Colors.GRIGIO)
                .font(Fonts.EUCLID_CIRCULAR_B_LIGHT, titleViewEditor.getBestFontSize())
                .upperEditor()
                .voidBuild()
        }
//        font.lineHeight = titleViewEditor.getViewHeight()
        
//        titleViewEditor.labelEditor()
//            .font(font)
//            .upperEditor().void()
    }
    
}
