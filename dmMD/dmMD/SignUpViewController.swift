//
//  SignUpViewController.swift
//  dmMD
//
//  Created by Siddharth on 18/05/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBAction func signUpComplete(_ sender: Any) {
        self.present(SendTextViewController(), animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
