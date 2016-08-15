//
//  GenericUtility.swift
//  Orlo
//
//  Created by omer on 2.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit

class GenericUtility {
    

    
    class func randomNumber(min: Int, max: Int) -> CGFloat {
        let num = Int(arc4random_uniform(UInt32(max - min))) + min
        return CGFloat(num)
    }

    class func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return (random() % (max - min)) + min
    }
    
    class func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }


    class func motionEffectGroup(range: Double? = 10.0) -> UIMotionEffectGroup {
        // Set vertical effect
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
                                                               type: .TiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -range!
        verticalMotionEffect.maximumRelativeValue = range!
        
        // Set horizontal effect
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
                                                                 type: .TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -range!
        horizontalMotionEffect.maximumRelativeValue = range!
        
        // Create group to combine both
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        return group
    }
}
