//
//  PlanetView.swift
//  Orlo
//
//  Created by omer on 2.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit


class PlanetView: UIImageView {
    
    class func create() -> PlanetView {
        
        let planetImage = UIImage(named: "ic_planet_white")
        let screenSize = UIScreen.mainScreen().bounds.size
        let size = self.defaultSize()
        let origin = CGPoint(x: (screenSize.width - size.width) / 2.0, y: (screenSize.height - size.height - 32.0))
        let frame = CGRect(origin: origin, size: size)
    
        let planet = PlanetView(frame: frame)
        planet.image = planetImage
        planet.contentMode = .ScaleAspectFit
        

        return planet
    }
    
    class func defaultSize() -> CGSize {
        return CGSize(width: 50.0, height: 60.0)
    }

    
    func darkMode() {
        image = UIImage(named: "ic_planet_black")
    }
    
    func whiteMode() {
        image = UIImage(named: "ic_planet_white")
    }
}





//class PlanetView: TriangleView {
//
//    class func create() -> PlanetView {
//
//        let screenSize = UIScreen.mainScreen().bounds.size
//        let size = self.defaultSize()
//        let origin = CGPoint(x: (screenSize.width - size.width) / 2.0, y: (screenSize.height - size.height - 20.0))
//        let frame = CGRect(origin: origin, size: size)
//
//        let planet = PlanetView(frame: frame)
//        planet.backgroundColor = UIColor.clearColor()
//        planet.innerColor = UIColor.blackColor()
//        planet.layer.shadowColor = UIColor.blackColor().CGColor
//        planet.layer.shadowOpacity = 1.0
//        planet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        planet.layer.shadowRadius = 2.0
//        return planet
//    }
//
//    class func defaultSize() -> CGSize {
//        return CGSize(width: 50.0, height: 60.0)
//    }
//
//
//    func changedColor() {
//        let color = self.innerColor == UIColor.whiteColor() ? UIColor.blackColor() : UIColor.whiteColor()
//        UIView.animateWithDuration(0.15) {
//            self.innerColor = color
//        }
//    }
//}