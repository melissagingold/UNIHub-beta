//
//  WebViewController.swift
//  UNIHub beta
//
//  Created by Niklas Pant (student LM) on 3/8/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var url : URL?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequest()
    }
    
    func loadRequest(){
        guard let url = self.url else {return}
        let request = URLRequest(url: url)
        webView.load(request)
    }

}
