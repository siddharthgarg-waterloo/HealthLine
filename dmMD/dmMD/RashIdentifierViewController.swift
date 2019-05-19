//
//  RashIdentifierViewController.swift
//  dmMD
//
//  Created by Siddharth on 18/05/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit

class RashIdentifierViewController: UIViewController {

    var _rashLabel:String = ""
    var _descriptionLabel:String = ""
    
    
    @IBOutlet weak var detailsRash: UILabel!
    @IBOutlet weak var typeRash: UILabel!
    
    @IBAction func exitButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        typeRash.text = _rashLabel
        detailsRash.text = _descriptionLabel
    }
    func updateContent() {
        typeRash.text = _rashLabel
        detailsRash.text = _descriptionLabel
    }
}
