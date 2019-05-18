//
//  MedicalRecordsViewController.swift
//  dmMD
//
//  Created by Siddharth on 18/05/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import HealthKit

class MedicalRecordsViewController: UIViewController {
    
    static let healthStore = HKHealthStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let allergiesType = HKObjectType.clinicalType(forIdentifier: .allergyRecord),
            let medicationsType = HKObjectType.clinicalType(forIdentifier: .medicationRecord),
            let conditionsType = HKObjectType.clinicalType(forIdentifier: .conditionRecord),
            let vitalsType = HKObjectType.clinicalType(forIdentifier: .vitalSignRecord),
            let immunizationType = HKObjectType.clinicalType(forIdentifier: .immunizationRecord),
            let procedureType = HKObjectType.clinicalType(forIdentifier: .procedureRecord),
            let labResultsType = HKObjectType.clinicalType(forIdentifier: .labResultRecord)
            else {
                fatalError("*** Unable to create the requested types ***")
        }
        
        // Clinical types are read-only.
        MedicalRecordsViewController.healthStore.requestAuthorization(toShare: nil, read:
            [allergiesType, medicationsType, conditionsType, vitalsType, immunizationType, procedureType, labResultsType])
        { (success, error) in
            guard success else {
                // Handle errors here.
                fatalError("*** An error occurred while requesting authorization: \(error!.localizedDescription) ***")
            }
            
//            guard let fhirRecord = clinicalRecord.fhirResource else {
//                print("No FHIR record found!")
//                return
//            }
//
//            do {
//                let jsonDictionary = try JSONSerialization.jsonObject(with: fhirRecord.data, options: [])
//
//                // Do something with the JSON data here.
//            }
//            catch let error {
//                print("*** An error occurred while parsing the FHIR data: \(error.localizedDescription) ***")
//                // Handle JSON parse errors here.
//            }
        }
    }


}
