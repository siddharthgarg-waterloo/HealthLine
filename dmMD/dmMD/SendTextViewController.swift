//
//  SendTextViewController.swift
//  dmMD
//
//  Created by Siddharth on 18/05/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MessageUI
import Messages

class SendTextViewController: UIViewController {
    
    let messageComposer = MessageComposer()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendText(_ sender: Any) {
        
        // Make sure the device can send text messages
        if (messageComposer.canSendText()) {
            // Obtain a configured MFMessageComposeViewController
            let messageComposeVC = messageComposer.configuredMessageComposeViewController()
            
            // Present the configured MFMessageComposeViewController instance
            // Note that the dismissal of the VC will be handled by the messageComposer instance,
            // since it implements the appropriate delegate call-back
            present(messageComposeVC, animated: true, completion: nil)
        } else {
            // Alert the user that they cannot send text messages
            let alertController = UIAlertController(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", preferredStyle: UIAlertController.Style.alert)
            let dismissAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
        }
    }
        
//        let headers = [
//            "Content-Type": "application/x-www-form-urlencoded"
//        ]
//
//        let parameters: Parameters = [
//            "To": "+15063062122",
//            "Body": "Hey"
//        ]
//
//        Alamofire.request("https://12809c08.ngrok.io/sms", method: .post, parameters: parameters, headers: headers).responseString { response in
//            if let result = response.result.value {
//                let json = JSON(result)
//                print(json["url"])
//                print(json["explanation"])
//            }
//        }
//
}
