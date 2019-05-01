//
//  StyleUNIhub.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/1/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import Foundation
import UIKit

// extension of style class that creates a more specific default version for the app
extension Style {
    static var UNIhub : Style {
        return Style (
            backgroundColor: .black,
            preferredStatusBarStyle: .lightContent,
            attributesForStyle: { $0.UNIhubAttributes }
        )
    }
}

// extension of style class that sets default of title and color for different design aspects
private extension Style.TextStyle {
    var UNIhubAttributes : Style.TextAttributes {
        switch self {
        case .navigationBar:
            return Style.TextAttributes(font: .UNIhubNavigationBar, color: .UNIhubGreen, backgroundColor: .black)
        case .title:
            return Style.TextAttributes(font: .UNIhubTitle, color: .UNIhubGreen)
        case .subtitle:
            return Style.TextAttributes(font: .UNIhubSubtitle, color: .UNIhubBlue)
        case .body:
            return Style.TextAttributes(font: .UNIhubBody, color: .black, backgroundColor: .white)
        case .button:
            return Style.TextAttributes(font: .UNIhubButton, color: .white, backgroundColor: .UNIhubRed)
        }
    }
}

// default colors for easy access
extension UIColor {
    static var UNIhubRed: UIColor {
        return UIColor(red: 1, green: 0.1, blue: 0.1, alpha: 1)
    }
    static var UNIhubGreen: UIColor {
        return UIColor(red: 0, green: 1, blue: 0, alpha: 1)
    }
    static var UNIhubBlue: UIColor {
        return UIColor(red: 0, green: 0.2, blue: 0.9, alpha: 1)
    }
}

// default font sizes for different types of design features
extension UIFont {
    static var UNIhubTitle: UIFont {
        return UIFont.systemFont(ofSize: 17)
    }
    static var UNIhubSubtitle: UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    static var UNIhubBody: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var UNIhubNavigationBar: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    static var UNIhubButton: UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
}
