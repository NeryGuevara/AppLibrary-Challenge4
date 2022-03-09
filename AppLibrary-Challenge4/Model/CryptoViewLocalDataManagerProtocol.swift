//
//  CryptoViewLocalDataManagerProtocol.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 08/03/22.
//

import Foundation
import UIKit

protocol CryptoViewLocalDataManagerProtocol {
    func obtainAvailableCryptos() -> [Crypto]
}
