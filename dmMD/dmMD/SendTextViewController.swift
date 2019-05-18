//
//  SendTextViewController.swift
//  dmMD
//
//  Created by Siddharth on 18/05/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import Alamofire

class SendTextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func sendText(_ sender: Any) {
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "From": "+12268993621",
            "To": "+15063062122",
            "Body": "Hey"
        ]
        
        Alamofire.request("https://3f811da7.ngrok.io/sms", method: .post, parameters: parameters, headers: headers).response { response in
            print(response)
            
        }
        
    }
}
