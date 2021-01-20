//
//  SettingsViewController.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 24/12/2020.
//

import UIKit

class SettingsViewController: UIViewController {

//    var safeAreaInsets = UIEdgeInsets()
    var mainView = UIView()
//    var scrollView = UIScrollView()
    var titleLabel = UILabel()
    
    var settingsView = UIView()
    var infoView = UIView()
    var generalView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewSafeAreaInsetsDidChange() { //qui perché view.safeAreaInsets ha dei valori
        let safeAreaInsets = view.safeAreaInsets
        let safeAreaFrame = CGRect(x: 0, y: safeAreaInsets.top, width: view.frame.width, height: view.frame.height - (safeAreaInsets.top + safeAreaInsets.bottom))
        mainView = UIView(frame: safeAreaFrame)

        view.backgroundColor = Colors.ACCENT_INTERFACE_COLOR
        view.addSubview(mainView)
        
//        mainView.clipsToBounds = true
////        mainView.backgroundColor = .black
//
//        scrollView.frame = mainView.frame
//        scrollView.backgroundColor = Colors.ACCENT_INTERFACE_COLOR
//        self.view.addSubview(scrollView)
        
        setupPageTitle()
        setupSettingsViews()
    }
    
    func setupPageTitle() {
        let title = "Impostazioni"
        
        let titleEditor = ViewEditor(titleLabel, mainView)
        titleEditor.percentageFrameRelativeY(0.01)
            .percentageFrameRelativeX(0.05) //left padding let variable
            .percentageFrameWidth(0.6)
            .percentageFrameHeight(0.05)
            .labelEditor()
            .text(title)
            .font(Fonts.EUCLID_CIRCULAR_B_Semibold.font(25))
            .adjustsFontSizeToFitWidth(true)
            .textColor(.white)
            .upperEditor()
            .attachToSuperviewAndVoidBuild()
    }
    
    func setupSettingsViews() {
        let infoViewEditor = ViewEditor(settingsView, mainView)
        infoViewEditor
            .percentageFrameRelativeY(0.11)
//            .percentageFrameRelativeX(0.06)
            .percentageFrameWidth(1)
            .percentageFrameHeight(0.9)
            .attachToSuperviewAndVoidBuild()
        
        let infoLabel = UILabel()
        let infoLabelText = "Info"
        
        let infoViewLabeleditor = ViewEditor(infoLabel, settingsView)
        infoViewLabeleditor.debug()
            .translatesAutoresizingMaskIntoConstraints(false)
            .percentageFrameRelativeX(0.05)
            .setMinX(50)
            .percentageFrameWidth(0.20)
            .setMinHeight(12)
            .labelEditor()
            .font(Fonts.EUCLID_CIRCULAR_B_LIGHT.font(20))
            .adjustsFontSizeToFitWidth(true)
//            .minimumScaleFactor(0.5)
            .lines(1)
            .baselineAdjustment(.none)
            .textColor(Colors.GRIGIO)
            .text(infoLabelText)
            .upperEditor()
            .attachToSuperviewAndVoidBuild()
        
//        infoLabel.sizeToFit()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
