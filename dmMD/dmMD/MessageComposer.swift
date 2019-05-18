//
//  MessageComposer.swift
//  dmMD
//
//  Created by Siddharth on 18/05/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self
        messageComposeVC.recipients = ["+15063062122"]
        messageComposeVC.body = "Hello! Welcome to Goodburger home of the Goodburger can I take your order"
        return messageComposeVC
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //        switch result {
        //        case MessageComposeResultCancelled:
        //            print("Message cancelled by user")
        //        case MessageComposeResultSent:
        //            print ("MASS TEXT")
        //        case MessageComposeResultFailed :
        //            print ("Failed sending text")
        //        default:
        //            print ("📝")
        //        }
        
        controller.dismiss(animated: true, completion: nil)
    }

}
