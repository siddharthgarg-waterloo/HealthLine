//
//  LoginViewController.swift
//  dmMD
//
//  Created by Siddharth on 18/05/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var loginViewBtn: UIButton!
    @IBOutlet weak var PINField: UITextField!
    @IBOutlet weak var incorrectPIN: UILabel!
    
    @IBAction func continueButton(_ sender: Any) {
        if let hasSignedUp = UserDefaults.standard.object(forKey: "hasSignedUp"),
            let pin = UserDefaults.standard.object(forKey: "PIN") as? String {
            if (PINField.text == pin) {
                self.present(SendTextViewController(), animated: true, completion: nil)
            } else {
                incorrectPIN.isHidden = false
            }
        } else {
            self.present(ProfileViewController(), animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        incorrectPIN.isHidden = true
        if let hasSignedUp = UserDefaults.standard.object(forKey: "hasSignedUp") {
            loginViewBtn.setTitle("Enter PIN", for: .normal)
        } else {
            PINField.isHidden = true
            loginViewBtn.setTitle("Create Profile", for: .normal)
        }
    }

}
