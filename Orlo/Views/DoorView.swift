//
//  DoorView.swift
//  Orlo
//
//  Created by omer on 2.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit

class DoorView: BaseView {
    
    override class func isDoor() -> Bool {
        return true
    }

    override class func getImage() -> UIImage? {
        return UIImage(named: "ic_circle_door")
    }

}
