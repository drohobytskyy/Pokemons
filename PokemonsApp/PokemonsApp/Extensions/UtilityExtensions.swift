//
//  UtilityExtensions.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

import Foundation
import UIKit

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

extension UINavigationController {
    func customAppStyle() {
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.tintColor = .black
    }
}


