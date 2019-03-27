//
//  EssayViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/25/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

private var listTableViewController: EssayListTableViewController?
private var brainstormViewController: EssayBrainstormViewController?


class EssayViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        stackView.axis = axisForSize(size)
    }
    
    func axisForSize(_ size: CGSize) -> NSLayoutConstraint.Axis {
        return size.width > size.height ? .horizontal : .vertical
    }

}
