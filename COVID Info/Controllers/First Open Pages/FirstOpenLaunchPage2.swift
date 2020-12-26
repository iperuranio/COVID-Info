//
//  FirstOpenLaunchPage2.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 23/12/2020.
//

import UIKit

class FirstOpenLaunchPage2: UIViewController {
    let currentPage = Pages.pageTwo
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    
    @IBOutlet weak var imageCenter: UIImageView!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var botView: UIView!
    
    var frame = CGRect()
    var midFrame = CGRect()
    
    var initialized: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(initialized) {
            return
        }
        
        frame = CGRect(x: 0, y: 0, width: mainView.frame.width, height: mainView.frame.height)
        
        let _ = GeneralPageUI(topView, midView, botView, false)
        midFrame = midView.frame
        
        setupTitle()
        setupSubtitle()
        setupImage()
        setupBottomTitle()
        
        initialized = true
    }
    
    func setupTitle() {
        let viewEditor = ViewEditor(titleLabel, midView)
        let text = "COVID-Info"
        
        viewEditor.percentageFrameMaxX(0)
            .percentageFrameRelativeY(0)
            .percentageFrameWidth(0.65)
            .percentageFrameHeight(0.25)
            .centerX()
            .labelEditor()
            .text("")
            .textAlignment(.center)
            .transitionText(0.10, false, 0.40, .transitionFlipFromBottom, text)
            .upperEditor()
            .voidBuild()
    }
    
    func setupSubtitle() {
        let viewEditor = ViewEditor(text1, midView)
        let text = "App italiana, dati italiani."
        
        viewEditor.percentageFrameRelativeY(0.17)
            .percentageFrameWidth(0.58)
            .percentageFrameHeight(0.05)
            .centerX()
            .labelEditor()
            .text("")
            .textAlignment(.center)
            .transitionText(0.10, false, 0.40, .transitionFlipFromBottom, text)
            .upperEditor()
            .voidBuild()
    }
    
    func setupImage() {
        let viewEditor = ViewEditor(imageCenter, midView)
        
        viewEditor.percentageFrameRelativeY(0.285)
            .percentageFrameWidth(0.6)
            .percentageFrameHeight(0.2)
            .centerX()
            .voidBuild()
    }
    
    func setupBottomTitle() {
        let viewEditor = ViewEditor(text2, midView)
        let text = "L'app riporta i dati che fornisce la Protezione Civile Italiana e li organizza per migliorare l'esperienza dell'utente."
        
        viewEditor.percentageFrameRelativeY(0.57)
            .percentageFrameWidth(0.9)
            .percentageFrameHeight(0.30)
            .centerX()
            .labelEditor()
            .text("")
            .textAlignment(.center)
            .transitionText(0.10, false, 0.40, .transitionFlipFromBottom, text)
            .upperEditor()
            .voidBuild()
    }
}
