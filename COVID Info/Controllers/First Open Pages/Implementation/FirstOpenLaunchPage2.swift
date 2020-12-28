//
//  FirstOpenLaunchPage2.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 23/12/2020.
//

import UIKit

class FirstOpenLaunchPage2: UIViewController {
    let currentPage = Pages.pageTwo
    
    var topView: UIView = UIView()
    var midView: UIView = UIView()
    var botView: UIView = UIView()
    
    var blurView: UIView = UIView()
    
    var initialized: Bool = false
    
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
        
        let title = "COVID-Info"
        let subTitle = "App italiana, dati italiani."
        let bottomTitle = "L'app riporta i dati che fornisce la Protezione Civile Italiana e li organizza per migliorare l'esperienza dell'utente."
        let buttonTitle = "Avanti"
        
        generalPage.setupTitle(title, true)
        generalPage.setupSubtitle(subTitle, true)
        generalPage.setupImage(Images.PISA_TOWER)
        generalPage.setupBottomTitle(bottomTitle, true)
        
        let button = generalPage.setupForwardButton(buttonTitle, Images.ARROW_WHITE, true)
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
        button.showsTouchWhenHighlighted = false
        
        initialized = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
            FirstLaunchController.presentController(self, self.currentPage.index + 1)
        }
    }
}
