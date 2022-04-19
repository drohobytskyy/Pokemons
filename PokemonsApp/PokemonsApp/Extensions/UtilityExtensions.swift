//
//  UtilityExtensions.swift
//  PokemonsApp
//
//  Created by @drohobytskyy on 12/04/2022.
//

import Foundation
import UIKit

//MARK: - String
extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}

//MARK: - UIColor
extension UIColor {
    static func primaryColor() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor.white
                } else {
                    return UIColor.black
                }
            }
        } else {
            return UIColor.black
        }
    }
    
    static func textColor() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor.black
                } else {
                    return UIColor.white
                }
            }
        } else {
            return UIColor.white
        }
    }
}

//MARK: - UILabel
extension UILabel {
    func defaultFontStyle() {
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.textColor = .primaryColor()
    }
    
    func pokemonDetailsCellStyle() {
        self.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        self.textColor = .primaryColor()
    }
    
    func pokemonCollectionCellNameLabelStyle() {
        self.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.textColor = .textColor()
        self.backgroundColor = .primaryColor()
        self.textAlignment = .center
    }
}

//MARK: - UINavigationController
extension UINavigationController {
    func customAppStyle() {
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.tintColor = .primaryColor()
    }
}

//MARK: - UIViewController
extension UIViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
}

//MARK: - UIImageView
extension UIImageView {
    func loadImage(with url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


