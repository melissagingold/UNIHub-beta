//
//  Style.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/1/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import Foundation

import UIKit

// Style class
class Style {
    // Set of named values for different text designs / styles
    enum TextStyle {
        case navigationBar
        case title
        case subtitle
        case body
        case button
    }
    // Data type for text attributes that sets default for font, font color, and background color
    struct TextAttributes {
        let font: UIFont
        let color: UIColor
        let backgroundColor: UIColor?
        
        init(font: UIFont, color: UIColor, backgroundColor: UIColor? = nil) {
            self.font = font
            self.color = color
            self.backgroundColor = backgroundColor
        }
    }
    
    // variables
    let backgroundColor: UIColor
    let preferredStatusBarStyle: UIStatusBarStyle
    let attributesForStyle: (_ style: TextStyle) -> TextAttributes
    
    // initializing attributes for style - background color, status bar, and text styles
    init(backgroundColor: UIColor,
         preferredStatusBarStyle: UIStatusBarStyle = .default,
         attributesForStyle: @escaping (_ style: TextStyle) -> TextAttributes)
    {
        self.backgroundColor = backgroundColor
        self.preferredStatusBarStyle = preferredStatusBarStyle
        self.attributesForStyle = attributesForStyle
    }
    
    // for easy access - functions able to call and return desired style for font, color, and backgroundColor features
    func font(for style: TextStyle) -> UIFont {
        return attributesForStyle(style).font
    }
    
    func color(for style: TextStyle) -> UIColor {
        return attributesForStyle(style).color
    }
    
    func backgroundColor(for style: TextStyle) -> UIColor? {
        return attributesForStyle(style).backgroundColor
    }
    
    // for easy access - functions able to apply the different default styles to specific labels, buttons, or navigation bars
    func apply(textStyle: TextStyle, to label: UILabel) {
        let attributes = attributesForStyle(textStyle)
        label.font = attributes.font
        label.textColor = attributes.color
        label.backgroundColor = attributes.backgroundColor
    }
    
    func apply(textStyle: TextStyle = .button, to button: UIButton) {
        let attributes = attributesForStyle(textStyle)
        button.setTitleColor(attributes.color, for: .normal)
        button.titleLabel?.font = attributes.font
        button.backgroundColor = attributes.backgroundColor
    }
    
    func apply(textStyle: TextStyle = .navigationBar, to navigationBar: UINavigationBar) {
        let attributes = attributesForStyle(textStyle)
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: attributes.font,
            NSAttributedString.Key.foregroundColor: attributes.color
        ]
        
        if let color = attributes.backgroundColor {
            navigationBar.barTintColor = color
        }
        
        navigationBar.tintColor = attributes.color
        navigationBar.barStyle = preferredStatusBarStyle == .default ? .default : .black
    }

}
