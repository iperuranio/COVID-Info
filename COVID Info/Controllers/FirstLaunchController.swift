//
//  FirstLaunchController.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 22/12/2020.
//

import UIKit

enum Pages: CaseIterable { //case iterable così posso fare .allCases
    case pageOne
    case pageTwo
    case pageThree
    case pageFour
    
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
    
    static func createPage(_ page: Pages) -> UIViewController {
        switch page {
        case .pageOne:
            return FirstOpenLaunchPage1()
        case .pageTwo:
            return FirstOpenLaunchPage2()
        case .pageThree:
            return FirstOpenLaunchPage3()
        case .pageFour:
            return FirstOpenLaunchPage4()
        }
    }
    
    static func createAllPages() -> [UIViewController] {
        var toReturn : [UIViewController] = []
        
        for page in Pages.allCases {
            toReturn.append(createPage(page))
        }
        
        return toReturn
    }
}

class FirstLaunchController: UIViewController {
    static var instance: FirstLaunchController? = nil
    var pageController: UIPageViewController = UIPageViewController()
    private var pages: [Pages] = Pages.allCases
    var currentIndex: Int = 0
    
    static var frame = MainScreenController.fullscreenFrame
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirstLaunchController.instance = self
        //if primo avvio?
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            if let instance = MainScreenController.instance {
                instance.view.removeBlur()
                delayAskNotification(0.1)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FirstLaunchController.frame = view.bounds //sono messi qui perché in questa funzione frame assume un valore diverso di quello in viewDidLoad
        MainScreenController.instance?.view.blurScreen()
        Page.initialize()
        self.setupPageController()
    }
    
    static func dimiss() {
        if let instance = FirstLaunchController.instance {
            instance.dismiss(animated: true, completion: nil)
        }
    }
    
    private func delayAskNotification(_ delay: TimeInterval) {
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { timer in
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                
                if let error = error {
                    // Handle the error here.
                }
                
                // Enable or disable features based on the authorization.
            }
        }
    }
    
    static func presentController(_ previous: UIViewController, _ index: Int) {
        if let instance = FirstLaunchController.instance {
            let initialVC = GeneralPage(index)
            instance.currentIndex = index
            
            instance.pageController.setViewControllers([initialVC.getPage()], direction: .forward, animated: false, completion: nil)
            instance.pageController.didMove(toParent: previous)
        }
    }
    
    private func setupPageController() {
        if let instance = FirstLaunchController.instance {
            instance.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            instance.pageController.dataSource = self //per togliere i pallini
            instance.pageController.delegate = self
            instance.pageController.view.backgroundColor = .clear
            instance.pageController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.size.height)
            instance.pageController.view.layer.masksToBounds = true
            instance.pageController.view.layer.cornerRadius = 20
            instance.pageController.view.layer.cornerCurve = .continuous
//            FirstLaunchController.pageController.view.
            
            for subView in instance.pageController.view.subviews { //disable scroll laterale
                if (subView as? UIScrollView != nil) {
                    let scrollView = subView as! UIScrollView
                    
                    let panGestureRecognizer: UIPanGestureRecognizer = scrollView.panGestureRecognizer
                    panGestureRecognizer.cancelsTouchesInView = false
                    panGestureRecognizer.delaysTouchesBegan = false
//                    panGestureRecognizer.cancelsTouchesInView = true
                    panGestureRecognizer.removeTarget(nil, action: nil)
                }
            }
//            FirstLaunchController.pageController.dimiss
            
            self.addChild(instance.pageController)
            self.view.addSubview(instance.pageController.view)
            
            let initialVC = GeneralPage(with: Pages.pageOne)
            
            instance.pageController.setViewControllers([initialVC.getPage()], direction: .forward, animated: true, completion: nil)
            instance.pageController.didMove(toParent: self)
        }
    }
}

extension FirstLaunchController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return FirstLaunchController.instance!.currentIndex
    }
}

extension UIPageControl {
    func customPageControl(dotFillColor:UIColor, dotBorderColor:UIColor, dotBorderWidth:CGFloat) {
        for (pageIndex, dotView) in self.subviews.enumerated() {
            if self.currentPage == pageIndex {
                dotView.backgroundColor = dotFillColor
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
            } else {
                dotView.backgroundColor = .clear
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = dotBorderColor.cgColor
                dotView.layer.borderWidth = dotBorderWidth
            }
        }
    }
}
