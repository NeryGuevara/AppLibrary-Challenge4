//
//  CryptoModel.swift
//  AppLibrary-Challenge4
//
//  Created by Felipe Nery Guevara Guevara on 08/03/22.
//

import Foundation

struct Crypto {
    var name: String
    var abbreviation: String
}

extension Crypto: TableViewCellVieable {
    var title: String {
        return name
    }
    var subtitle: String {
        return abbreviation
    }
}
