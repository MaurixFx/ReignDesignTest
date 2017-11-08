//
//  WebContentViewController.swift
//  TestReignDesign
//
//  Created by Mauricio Figueroa olivares on 08-11-17.
//  Copyright © 2017 Maurix. All rights reserved.
//

import UIKit

class WebContentViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    
    var storyLink: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showContentWeb()
    }
    
    // Función donde mostramos en pantalla la web de acuerdo a la URL que viene de la vista anterior
    func showContentWeb() {
        if let url = storyLink {
            let urlStory = URL(string: url)
            let request = URLRequest(url: urlStory!)
            self.webView.loadRequest(request)
        }
    }

    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
