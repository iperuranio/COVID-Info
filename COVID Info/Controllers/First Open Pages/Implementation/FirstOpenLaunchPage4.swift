//
//  FirstOpenLaunchPage4.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 23/12/2020.
//

import UIKit

class FirstOpenLaunchPage4: UIViewController {
    let currentPage = Pages.pageFour
    
    var topView: UIView = UIView()
    var midView: UIView = UIView()
    var botView: UIView = UIView()
    
    var blurView: UIView = UIView()
    
    var initialized: Bool = false
    var generalPage: GeneralPageUI? = nil
    
    override func awakeFromNib() {
       super.awakeFromNib()
        
        self.title = "VC\(currentPage.index)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(initialized) {
            return
        }
        
        let generalPage = GeneralPageUI(self.view, topView, midView, botView, false) //debug mode con true
        generalPage.setupBackground(Images.BACKGROUND_BLUE_1)
        
        generalPage.attachSuperView()
        
        generalPage.setupBlurView()
        
        generalPage.setupImage(Images.NOTIFY_BELL)
        
        let title = "COVID-Info"
        let subTitle = "Ti avvisa ad ogni cambiamento."
        let bottomTitle = "Una volta che avrai consentito all'applicazione di mandarti delle notifiche, essa ti avvertirà qualora i dati dovessero essere stati aggiornati o nel caso in cui le disposizioni dovessero variare."
        let buttonTitle = "Chiudi"
        
        generalPage.setupTitle(title, true)
        generalPage.setupSubtitle(subTitle, true)
        generalPage.setupBottomTitle(bottomTitle, true)
        
//        generalPage.setupForwardButton()
        let button = generalPage.setupForwardButton(buttonTitle, Images.XMARK, false)
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        button.showsTouchWhenHighlighted = false
        
        initialized = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
            FirstLaunchController.dimiss()
        }
    }
}

