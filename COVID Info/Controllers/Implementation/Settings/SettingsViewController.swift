//
//  SettingsViewController.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 24/12/2020.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    var safeAreaInsets = UIEdgeInsets()
    let cellIdentifier = "settingsCell"
    let rowHeight: CGFloat = 57.312
    var mainView = UIView()
    var scrollView = UIView()
    var topBarView = UIView()
//    var scrollView = UIScrollView()
    var titleLabel = UILabel()
    
    let tableView : UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
    
    var infoView = UIView()
    var generalView = UIView()
    var topHorizontalsScrollView = UIScrollView()
    var horizontalMenusHeight: CGFloat = 0
    
    var horizontalMenus: [SettingCellData] = {
        let privacyPolicy = SettingCellData(Images.POLICY, "Privacy Policy")
        let tos = SettingCellData(Images.TOS, "Termini di utilizzo")
        let info = SettingCellData(Images.INFO, "Informazioni")
        let contact = SettingCellData(Images.MAIL, "Contatti")
        let segnala = SettingCellData(Images.ERROR, "Segnala un problema")
        let share = SettingCellData(Images.SHARE, "Condividi applicazione")
        let review = SettingCellData(Images.STAR, "Lascia una recensione")
        
        return [privacyPolicy, tos, info, contact, segnala, share, review]
    }()
    
    var initialized = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        if(initialized) {
            return
        }
        
        initialized = true
        
        let safeAreaInsets = view.safeAreaInsets
        let safeAreaFrame = CGRect(x: 0, y: safeAreaInsets.top, width: view.frame.width, height: view.frame.height - (safeAreaInsets.top + safeAreaInsets.bottom))
        mainView = UIView(frame: safeAreaFrame)
        
        view.addSubview(mainView)
        view.backgroundColor = Colors.ACCENT_INTERFACE_COLOR

        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = Colors.ACCENT_INTERFACE_COLOR
        tableView.separatorColor = tableView.backgroundColor
        
        tableView.rowHeight = rowHeight
//        self.tableView = UITableView()
//        view.addSubview(mainView)
        
//        mainView.clipsToBounds = true
////        mainView.backgroundColor = .black
//
//        scrollView.frame = mainView.frame
//        scrollView.backgroundColor = Colors.ACCENT_INTERFACE_COLOR
//        self.view.addSubview(scrollView)
                
        tableView.register(SettingsCell.self, forCellReuseIdentifier: cellIdentifier)
        
        setupPageTitle()
        setupSettingsViews()
//        setupHorizontalMenus()
    }
    
    func setupPageTitle() {
        let title = "Impostazioni"
        
        let topBarViewEditor = ViewEditor(topBarView, mainView)
        topBarViewEditor.asViewBackground()
            .percentageFrameHeight(0.06)
            .voidBuild()
        
        let titleEditor = ViewEditor(titleLabel, topBarView)
        titleEditor.percentageFrameRelativeX(0.05) //left padding let variable
            .percentageFrameWidth(0.6)
            .percentageFrameHeight(0.9)
            .centerY()
            .labelEditor()
            .text(title)
            .font(Fonts.EUCLID_CIRCULAR_B_Semibold.font(25))
            .adjustsFontSizeToFitWidth(true)
            .textColor(.white)
            .upperEditor()
            .voidBuild()
        
        let scrollViewEditor = ViewEditor(scrollView, mainView)
        let topBarHeight = topBarViewEditor.getViewHeight()
        let fullHeight = scrollViewEditor.getMainFrameHeight()

        scrollViewEditor.asViewBackground()
            .setHeight(fullHeight - topBarHeight)
            .setMinY(topBarHeight)
            .voidBuild()
    }
    
    func setupSettingsViews() {
        let infoViewEditor = ViewEditor(tableView, scrollView)
        infoViewEditor
            .asViewBackground()
            .notAttachToSuperview()
            .voidBuild()
        
//        let infoLabel = UILabel()
//        let infoLabelText = "Info"
//
//        let infoViewLabeleditor = ViewEditor(infoLabel, tableView)
//        infoViewLabeleditor
//            .translatesAutoresizingMaskIntoConstraints(false)
//            .percentageFrameRelativeX(0.05)
//            .percentageFrameWidth(0.20)
//            .setHeight(12)
//            .labelEditor()
//            .font(Fonts.EUCLID_CIRCULAR_B_LIGHT.font(20))
//            .adjustsFontSizeToFitWidth(true)
////            .minimumScaleFactor(0.5)
//            .lines(1)
//            .baselineAdjustment(.none)
//            .textColor(Colors.GRIGIO)
//            .text(infoLabelText)
//            .upperEditor()
//            .voidBuild()
////        infoLabel.sizeToFit()
    }
    
    func setupHorizontalMenus() {
        var menusArray: [UIView] = []
        let topStackViewEditor = ViewEditor(topHorizontalsScrollView, tableView)
        topStackViewEditor
            .asViewBackground()
            .percentageFrameRelativeY(0.0335)
            .voidBuild()
        
        let policyViewEditor = horizontalMenu()
        let tosViewEditor = horizontalMenu()
        let infoViewEditor = horizontalMenu()
        let contactViewEditor = horizontalMenu()
        
        menusArray.append(policyViewEditor.view)
        menusArray.append(tosViewEditor.view)
        menusArray.append(infoViewEditor.view)
        menusArray.append(contactViewEditor.view)
        
        topStackViewEditor.stackEditor()
            .addArrangedSubviews(menusArray)
            .upperEditor()
            .void()
        
        policyViewEditor.voidBuild()
        tosViewEditor.voidBuild()
        infoViewEditor.voidBuild()
        contactViewEditor.voidBuild()
    }
    
    private func horizontalMenu() -> ViewEditor {
        let dummydummyHorizontalMenuEditor = ViewEditor(UIView(), tableView)
        dummydummyHorizontalMenuEditor.debug()
            .percentageFrameWidth(1)
//            .setHeight()
//            .percentageFrameHeight(0.08)
            .void()
        
        return dummydummyHorizontalMenuEditor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingsCell
        cell.backgroundColor = tableView.backgroundColor
        let data = horizontalMenus[indexPath.row]
        cell.setData(data.image, data.text)
        return cell
    }
}
