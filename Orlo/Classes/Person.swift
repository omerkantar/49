//
//  Person.swift
//  Orlo
//
//  Created by omer on 3.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit

class Person {
    var id: Int? = 0
    var name: String? = ""
    var age: Int? = 0
    
    init() {
        
    }
    
    init(dict: NSDictionary) {
        id = dict["id"]?.integerValue
        name = dict["name"] as? String
        age = dict["age"]?.integerValue
    }
}
