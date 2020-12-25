//
//  FirstOpenLaunchPage1.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 23/12/2020.
//

import UIKit

class FirstOpenLaunchPage1: UIViewController {
    let currentPage = Pages.pageOne
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var botView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //titleLabel.font = UIFont.sourceCodeProBold(size: 30)
//        print("called")
//        view.addSubview(storyboardUI.instantiateViewController(withIdentifier: "FIRST_OPEN_PAGE_1").view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let topFrame = topView.frame
        topView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.maxX, height: 20)
//        topView.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.maxX, height: 20)
        
        let midFrame = midView.frame
        midView.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.maxX, height: 60)
//        midView.bounds = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.maxX, height: 20)
        
        let botFrame = botView.frame
        botView.frame = CGRect(x: 0, y: 80, width: UIScreen.main.bounds.maxX, height: 20)
    }
}
