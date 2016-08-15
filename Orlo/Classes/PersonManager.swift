//
//  SectionManager.swift
//  Orlo
//
//  Created by omer on 1.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit

let SAVED_LAST_SHOWED_PERSON_INDEX = "SAVED_LAST_SHOWED_PERSON_INDEX"

class PersonManager: NSObject {

    static var sharedInstance = PersonManager()
    var persons = Array<Person>()
    var person: Person = Person()
    var informationVM: InformationViewModel?
    var isFirst: Bool = false
    
    class func setup() {
        readingPersons()
        var index = getLastShowedPersonIndex()
        
        if index == -1 {
            sharedInstance.isFirst = true
        }
        
        index += 1
        
        if index == 49 {
            index = 0
        }
        
        sharedInstance.person = sharedInstance.persons[index]
        savedIndex(index)
        sharedInstance.informationVM = InformationViewModel()
    }
    
    class func readingPersons() {
        
        let list = FileManager.getJSON(withJSONFileName: "orlo")
        
        if list is Array<NSDictionary> {
            
            sharedInstance.persons.removeAll()
            
            for dict in list as! Array<NSDictionary> {
                let person = Person(dict: dict)
                sharedInstance.persons.append(person)
            }
        }
    }
    
    
    class func getLastShowedPersonIndex() -> Int {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let object = userDefaults.objectForKey(SAVED_LAST_SHOWED_PERSON_INDEX) {
            
            return object as! Int
        }
        return -1
    }
    
    class func savedIndex(index: Int) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(index, forKey: SAVED_LAST_SHOWED_PERSON_INDEX)
        userDefaults.synchronize()
    }
    
    
    
}
