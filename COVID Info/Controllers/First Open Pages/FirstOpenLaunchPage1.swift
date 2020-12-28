//
//  FirstOpenLaunchPage1.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 23/12/2020.
//

import UIKit

class FirstOpenLaunchPage1: UIViewController {
    let currentPage = Pages.pageOne
    
    var topView: UIView = UIView()
    var midView: UIView = UIView()
    var botView: UIView = UIView()
    
    var blurView: UIView = UIView()
    
    var initialized: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) { //in questa funzione perché la dimensione del frame si aggiorna qui
        if(initialized) { //ricordarsi sta roba
            return
        }
        
        let title = "COVID-Info"
        let subtitle = "Benvenuto in COVID Info!"
        let bottomTitle = "All'interno dell'app troverai tutto il necessario per rimanere informato riguardo la malattia da coronavirus (COVID-19)."
        
        let generalPage = GeneralPageUI(self.view, topView, midView, botView, false) //debug mode con true
        generalPage.setupBackground(Images.BACKGROUND_BLUE_1)
        
        generalPage.attachSuperView()
        
        generalPage.setupBlurView()
        
        generalPage.setupTitle(title, true)
        generalPage.setupSubtitle(subtitle, true)
        generalPage.setupImage(Images.GIRL_WITH_MASK)
        generalPage.setupBottomTitle(bottomTitle, true)
        let button = generalPage.setupForwardButton()
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        button.showsTouchWhenHighlighted = false //fargli una cascata
        
        initialized = true
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        FirstLaunchController.presentController(self, currentPage.index + 1)
    }
    
}
