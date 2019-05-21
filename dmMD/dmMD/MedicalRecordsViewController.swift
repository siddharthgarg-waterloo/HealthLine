//
//  MedicalRecordsViewController.swift
//  dmMD
//
//  Created by Siddharth on 18/05/19.
//  Copyright © 2019 Siddharth. All rights reserved.
//

import UIKit
import HealthKit

class MedicalRecordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CollapsibleTableViewHeaderDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func goToAr(_ sender: Any) {
        present(ScarRecognisitionViewController(), animated: true, completion: nil)
    }
    
    @IBAction func sendText(_ sender: Any) {
        present(SendTextViewController(), animated: true, completion: nil)
    }
    
    @IBAction func goToMaps(_ sender: Any) {
        present(NearbyHospitalsViewController(), animated: true, completion: nil)
    }
    
    static let healthStore = HKHealthStore()
    
    var sections = sectionsData
    
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
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    
    
    
    //tableview delegate methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    
    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:     CollapsibleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollapsibleTableViewCell ??
                CollapsibleTableViewCell(style: .default, reuseIdentifier: "cell")
        
        let item: Item = sections[indexPath.section].items[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.detailLabel.text = item.details
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ??     CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(sections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
    
}
