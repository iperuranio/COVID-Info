//
//  GeneralPage.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 23/12/2020.
//

import UIKit

class GeneralPage: UIViewController {
    var page: Pages
    
    init(with page: Pages) {
        self.page = page
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ERROR #1")
    }
    
    func getPage() -> UIViewController {
        return Page.getPage(page.index)
    }
}
