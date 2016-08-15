//
//  InformationViewModel.swift
//  Orlo
//
//  Created by omer on 4.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit

class InformationViewModel {

    var txtAllPersonNames: String = ""
    var txtDescription: String = ""
    var attDescription: NSMutableAttributedString?
    
    init() {
        
        let list = PersonManager.sharedInstance.persons
        let description = NSString(string: NSLocalizedString("txt_info_description", comment: ""))
        
        txtDescription = String(description)

        for person in list {
            txtAllPersonNames += person.name!
            if list.last?.id != person.id {
                txtAllPersonNames += "\n"
            }
        }
        
        txtDescription += "\n\n\n" + txtAllPersonNames + "\n\n"
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Center
        
        let otherStyle = NSMutableParagraphStyle()
        otherStyle.alignment = .Natural
        
        attDescription = NSMutableAttributedString(string: txtDescription,
                                                 attributes: [ NSParagraphStyleAttributeName: style ])
        
        attDescription?.addAttributes([ NSParagraphStyleAttributeName: otherStyle ], range: NSMakeRange(0, description.length))
        

        
    }
}
