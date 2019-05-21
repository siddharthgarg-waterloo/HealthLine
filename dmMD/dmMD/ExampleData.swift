//
//  ExampleData.swift
//  ios-swift-collapsible-table-section
//
//  Created by Yong Su on 8/1/17.
//  Copyright © 2017 Yong Su. All rights reserved.
//

import Foundation

//
// MARK: - Section Data Structure
//
public struct Item {
    var name: String
    var gender: String
    var age: String
    var symptoms: String
    
    var details: String
    
    public init(name: String,
                gender: String,
                age: String,
                symptoms: String) {
        self.name = name
        self.gender = gender
        self.age = age
        self.symptoms = symptoms
        self.details = name + " " + gender + " " + age + " " + symptoms
    }
}

public struct Section {
    var name: String
    var items: [Item]
    var collapsed: Bool
    
    public init(name: String, items: [Item], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

public var sectionsData: [Section] = [
    Section(name: "05-19-2019", items: [
        Item(name: "Sid Garg", gender: "m", age: "18", symptoms: "headache, fever, cough"),
        ]),
    Section(name: "05-19-2019", items: [
        Item(name: "Sid Garg", gender: "m", age: "18", symptoms: "headache, fever, cough"),
        ]),
    Section(name: "05-19-2019", items: [
        Item(name: "Sid Garg", gender: "m", age: "18", symptoms: "sweating, fever, dizziness"),
        ]),
    Section(name: "05-18-2019", items: [
        Item(name: "Sid Garg", gender: "m", age: "18", symptoms: "fatigue, cramps, cough"),
        ]),
    Section(name: "05-18-2019", items: [
        Item(name: "Sid Garg", gender: "m", age: "18", symptoms: "nausea, fever, cough"),
        ]),
    Section(name: "05-18-2019", items: [
        Item(name: "Sid Garg", gender: "m", age: "18", symptoms: "bloating, fever, fatigue"),
        ])
]
