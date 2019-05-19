//
//  ProfileViewController.swift
//  dmMD
//
//  Created by Pranav Panchal on 2019-05-18.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var PINField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doneBtnPressed(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "hasSignedUp")
        UserDefaults.standard.setValue(phoneNumberField.text ?? "", forKey: "phoneNumber")
        UserDefaults.standard.setValue(PINField.text ?? "", forKey: "PIN")
        UserDefaults.standard.setValue(ageField.text ?? "", forKey: "age")
        UserDefaults.standard.setValue(genderField.text ?? "", forKey: "gender")
        self.present(SendTextViewController(), animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
