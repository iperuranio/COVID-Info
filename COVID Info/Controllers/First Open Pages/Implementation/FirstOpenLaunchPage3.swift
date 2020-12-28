//
//  FirstOpenLaunchPage3.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 23/12/2020.
//

import UIKit

class FirstOpenLaunchPage3: UIViewController {
    let currentPage = Pages.pageThree
    
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
        let subTitle = "Tiene conto delle disposizioni in vigore."
        let bottomTitle = "Selezionando la regione di appartenenza, l'app mostrerà le disposizioni in vigore e cercherà di evidenziare eventuali raccomandazioni, limiti o divieti."
        let buttonTitle = "Avanti"
        
        generalPage.setupTitle(title, true)
        generalPage.setupSubtitle(subTitle, true)
        generalPage.setupImage(Images.LAW_BOOK)
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
