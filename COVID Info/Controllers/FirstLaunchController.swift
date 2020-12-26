//
//  FirstLaunchController.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 22/12/2020.
//

import UIKit

enum Pages: CaseIterable {
    case pageOne
    case pageTwo
    case pageThree
    case pageFour
    
    var ids: String {
        switch self {
        case .pageOne:
            return "FIRST_OPEN_PAGE_1"
        case .pageTwo:
            return "FIRST_OPEN_PAGE_2"
        case .pageThree:
            return "FIRST_OPEN_PAGE_3"
        case .pageFour:
            return "FIRST_OPEN_PAGE_4"
        }
    }
    
    var index: Int {
        switch self {
        case .pageOne:
            return 0
        case .pageTwo:
            return 1
        case .pageThree:
            return 2
        case .pageFour:
            return 3
        }
    }
}

struct Page {
    static var controllers: [UIViewController] = []
    
    init() {
        
    }

    static func initialize() {
        Page.controllers.append(contentsOf: Page.createAllPages())
    }
    
    static func getPage(_ index: Int) -> UIViewController {
        return controllers[index]
    }
    
    static func createPage(_ pageID : String) -> UIViewController {
        if let instance = MainScreenController.instance {
            let viewController = instance.storyboardUI.instantiateViewController(withIdentifier: pageID)
            return viewController
        }
//        _ = viewController.view
//        viewController.loadView()
        return UIViewController()
    }
    
    static func createAllPages() -> [UIViewController] {
        var toReturn : [UIViewController] = []
        
        for page in Pages.allCases {
            toReturn.append(createPage(page.ids))
        }
        
        return toReturn
    }
}

class FirstLaunchController: UIViewController {
    
    private var pageController: UIPageViewController?
    private var pages: [Pages] = Pages.allCases
    private var currentIndex: Int = 0
    
    static var frame = MainScreenController.fullscreenFrame
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if primo avvio?
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            if let instance = MainScreenController.instance {
                instance.view.removeBlur()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        DispatchQueue.main.async {
//            self.present(FirstOpenLaunchPage1(coder: NSCoder()), animated: true, completion: nil)
//        }
        
//        if var topController = UIApplication.shared.keyWindow?.rootViewController  {
//                   while let presentedViewController = topController.presentedViewController {
//                         topController = presentedViewController
//                    }
//             self.modalPresentationStyle = .fullScreen
//             topController.present(vc, animated: true, completion: nil)
//        }
        
        FirstLaunchController.frame = view.bounds //sono messi qui perché in questa funzione frame assume un valore diverso di quello in viewDidLoad
        MainScreenController.instance?.view.blurScreen()
        Page.initialize()
        self.setupPageController()
    }
    
    private func setupPageController() {
        if let _ = MainScreenController.instance {
            self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            self.pageController?.dataSource = self
            self.pageController?.delegate = self
            self.pageController?.view.backgroundColor = .clear
            self.pageController?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.size.height)
            self.pageController?.view.layer.masksToBounds = true
            self.pageController?.view.layer.cornerRadius = 20
            self.pageController?.view.layer.cornerCurve = .continuous
            
            self.addChild(self.pageController!)
            self.view.addSubview(self.pageController!.view)
            
            let initialVC = GeneralPage(with: Pages.pageOne)
            let vc = initialVC.getPage()
            _ = vc.view
            vc.loadView()
            
            self.pageController?.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
            self.pageController?.didMove(toParent: self)
        }
    }
}

extension FirstLaunchController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard viewController.title != nil && viewController.title!.starts(with: "VC") else {
            return nil
        }

        var index = (Int(viewController.title!.suffix(1)) ?? 0) - 1
        
        if index == 0 {
            return nil
        }
        
        index -= 1
        
        let vc: GeneralPage = GeneralPage(with: pages[index])
        
        return vc.getPage()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard viewController.title != nil && viewController.title!.starts(with: "VC") else {
            return nil
        }

        var index = (Int(viewController.title!.suffix(1)) ?? 0) - 1
        
        if index >= self.pages.count - 1 {
            return nil
        }
        
        index += 1
        
//        if(index == 3) {
//            navigationController?.popViewController(animated: true)
//            dismiss(animated: true, completion: nil)
//        }
        
        let vc: GeneralPage = GeneralPage(with: pages[index])
        
        return vc.getPage()
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}

extension UIPageControl {

    func customPageControl(dotFillColor:UIColor, dotBorderColor:UIColor, dotBorderWidth:CGFloat) {
        for (pageIndex, dotView) in self.subviews.enumerated() {
            if self.currentPage == pageIndex {
                dotView.backgroundColor = dotFillColor
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
            }else{
                dotView.backgroundColor = .clear
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = dotBorderColor.cgColor
                dotView.layer.borderWidth = dotBorderWidth
            }
        }
    }

}
