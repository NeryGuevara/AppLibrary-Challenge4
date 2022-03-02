//
//  UIButton++.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 01/03/22.
//

import Foundation
import UIKit

extension UIButton{
    
    func blueFormat(){
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.layer.borderWidth = 1
    }
    
}
