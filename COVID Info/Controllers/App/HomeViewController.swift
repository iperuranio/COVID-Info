//
//  HomeViewController.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 24/12/2020.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.yellow], for:.selected)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarItem.selectedImage = self.tabBarItem.selectedImage?.tabBarImageWithCustomTint(tintColor: .red)
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
