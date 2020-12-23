//
//  ViewController.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 21/12/2020.
//

import UIKit

class MainScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        preview()
//        print("a")
//        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
//            print("b")
//            self.preview()
//        }
//        
//        print("c")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        preview()
    }
    func preview() {
        self.performSegue(withIdentifier: "FIRST_APP_OPEN", sender: self)
    }
}

