//
//  CollegeCell.swift
//  UNIHub beta
//
//  Created by Niklas Pant (student LM) on 2/5/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import Foundation
import UIKit

class CollegeCell: UITableViewCell {
    var name: String?
    var information: String?
    
    var nameView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.font = UIFont(name: "Helvetica Neue", size: 30)
        return textView
    }()
    
    var informationView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.font = UIFont(name: "Helvetica Neue", size: 15)
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(nameView)
        self.addSubview(informationView)
        
        nameView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        nameView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 15).isActive = true
        nameView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameView.bottomAnchor.constraint(equalTo: informationView.topAnchor).isActive = true
        
        informationView.topAnchor.constraint(equalTo: nameView.bottomAnchor).isActive = true
        informationView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        informationView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 15).isActive = true
        informationView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let name = name {
            nameView.text = name
        }
        if let information = information {
            informationView.text = information
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
