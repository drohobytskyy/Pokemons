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
        self.navigationBar.tintColor = .primaryColor()
    }
}

extension UIColor {
    static func primaryColor() -> UIColor {
        return UIColor.black
    }
    
    static func darkTextColor() -> UIColor {
        return UIColor.black
    }
    
    static func lightTextColor() -> UIColor {
        return UIColor.white
    }
}

extension UILabel {
    func defaultFontStyle() {
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.textColor = .darkTextColor()
    }
    
    func pokemonDetailsCellStyle() {
        self.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        self.textColor = .darkTextColor()
    }
    
    func pokemonCollectionCellNameLabelStyle() {
        self.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.textColor = .lightTextColor()
        self.backgroundColor = .primaryColor()
        self.textAlignment = .center
    }
}


