//
//  UITextView++.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 11/03/22.
//

import Foundation
import UIKit

extension UITextView{
    func format(){
        self.textAlignment = .center
        self.backgroundColor = .systemGray5
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.layer.borderWidth = 1
    }
}
