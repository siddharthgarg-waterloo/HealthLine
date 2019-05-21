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

class SendTextViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var exitButton: UIButton!
    let cellIdentifier = "CollectionViewCell"
    let messageComposer = MessageComposer()
    
    @IBOutlet weak var defaultSymptomCollection: UICollectionView!
    
    var defaultSymptoms = ["bloating", "cough", "diarrhea", "dizziness", "fatigue", "fever", "headache", "cramps",
                   "nausea", "sweating"]
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var arrSelectedData = [String]() // This is selected cell data array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSymptomCollection.allowsMultipleSelection = true
        defaultSymptomCollection.delegate = self
        defaultSymptomCollection.dataSource = self
        let nibCell = UINib(nibName: cellIdentifier, bundle: nil)
        defaultSymptomCollection.register(nibCell, forCellWithReuseIdentifier: cellIdentifier)
        exitButton.layer.cornerRadius = 15
        exitButton.clipsToBounds = true
        exitButton.addTarget(self, action: #selector(exitSymptoms), for: .touchUpInside)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaultSymptoms.count
    }
    
    @IBAction func sendText(_ sender: Any) {
//        let number = UserDefaults.standard.object(forKey: "phoneNumber") as! String
//        let gender = UserDefaults.standard.object(forKey: "gender") as! String
//        let age = UserDefaults.standard.object(forKey: "age") as! String
        
        let number = "+12268993621"
        let gender = "m"
        let age = "18"
        
//        let selectedSymptoms = defaultSymptomCollection.indexPathsForSelectedItems as! [IndexPath]
//        var symptomString = ""
//
//        var dummy = 0
//        for path in selectedSymptoms {
//            let cell = defaultSymptomCollection?.cellForItem(at: path) as! CollectionViewCell
//            if (dummy == 0) {
//                symptomString = cell.symptomTitle.text ?? ""
//                dummy += 1
//            } else {
//                symptomString = symptomString + " "
//                symptomString = cell.symptomTitle.text ?? ""
//            }
//        }
        
        
        let finalString = number + " " + gender + " " + age + " " + "headache fever cough"
        
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        cell.symptomTitle.text = defaultSymptoms[indexPath.row]
        cell.symptomTitle.textColor = UIColor.lightGray
        cell.symptomTitle.textAlignment = .center
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        cell?.backgroundColor = UIColor(red:0.22, green:0.45, blue:0.97, alpha:1.0)
        cell?.symptomTitle.textColor = UIColor.white
    }
    
    @objc private func exitSymptoms() {
        self.present(ScarRecognisitionViewController(), animated: true, completion: nil)
    }
    
}
