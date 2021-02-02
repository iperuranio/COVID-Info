//
//  SettingsViewController.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 24/12/2020.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    public enum Measures: Int {
        case LEFT_OFFSET_PERCENTAGE
        case ROW_WIDTH
        case ROW_HEIGHT
//        case SEPARATOR_ROW_HEIGHT
        
        var value: CGFloat {
            switch self {
            case .LEFT_OFFSET_PERCENTAGE:
                return 0.05
            case .ROW_WIDTH:
                return MainScreenController.fullscreenFrame.width
            case .ROW_HEIGHT:
                return 57.312
//            case .SEPARATOR_ROW_HEIGHT:
//                return 37.0
            }
        }
    }
    
    static let mainColor = Colors.ACCENT_INTERFACE_COLOR
    static let separatorColor = Colors.ACCENT_BUTTONS_COLOR_1
    
//    var safeAreaInsets = UIEdgeInsets()
    let cellIdentifier = "settingsCell"
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
        let info_separator = SettingCellData(nil, "Info", true)
        let privacyPolicy = SettingCellData(Images.POLICY, "Privacy Policy", false, {
            print("privacy")
        })
        let tos = SettingCellData(Images.TOS, "Termini di utilizzo", false, {
            print("terms")
        })
        let info = SettingCellData(Images.INFO, "Informazioni", false, {
            print("info")
        })
        let contact = SettingCellData(Images.MAIL, "Contatti", false, {
            print("contact")
        })
        
        let general_separator = SettingCellData(nil, "Generali", true)
        let segnala = SettingCellData(Images.ERROR, "Segnala un problema", false, {
            print("problem")
        })
        let share = SettingCellData(Images.SHARE, "Condividi applicazione", false, {
            print("share")
        })
        let review = SettingCellData(Images.STAR, "Lascia una recensione", false, {
            print("review")
        })
        
        return [info_separator, privacyPolicy, tos, info, contact, general_separator, segnala, share, review]
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
        view.backgroundColor = SettingsViewController.mainColor

        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.backgroundColor = SettingsViewController.separatorColor
        tableView.separatorColor = tableView.backgroundColor
        tableView.clipsToBounds = true
        
        tableView.rowHeight = Measures.ROW_HEIGHT.value
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
            .percentageFrameHeight(0.07)
            .voidBuild()
        
        let titleEditor = ViewEditor(titleLabel, topBarView)
        let superHeight = titleEditor.getMainFrameHeight()
        titleEditor.percentageFrameRelativeX(0.05) //left padding let variable
            .percentageFrameWidth(0.6)
            .percentageFrameHeight(0.55)
            .setMinY(superHeight - titleEditor.getViewHeight() - (0.20 * superHeight))
            .labelEditor()
            .text(title)
            .font(Fonts.EUCLID_CIRCULAR_B_Semibold, titleEditor.getBestFontSize())
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
        return horizontalMenus.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        horizontalMenus[indexPath.row].execute()
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return horizontalMenus[indexPath.row].isSeparator ? Measures.SEPARATOR_ROW_HEIGHT.value : Measures.ROW_HEIGHT.value
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingsCell
        cell.setData(horizontalMenus[indexPath.row], tableView.bounds.contains(tableView.rectForRow(at: indexPath))) //il secondo parametro verifica che il rettangolo della cella sia visibile e nella funzione se non è visibile non viene aggiornata la view
        return cell
    }
}
