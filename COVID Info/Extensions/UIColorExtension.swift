//
//  UIColorExtension.swift
//  COVID Info
//
//  Created by Claudio Portuesi on 26/12/2020.
//

import UIKit

extension UIColor {
    static var random: UIColor {
         //Generate between 0 to 1
         let red:CGFloat = CGFloat(drand48())
         let green:CGFloat = CGFloat(drand48())
         let blue:CGFloat = CGFloat(drand48())

         return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
}
