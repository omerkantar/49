//
//  AllViewControllerIdentifiers.swift
//  Orlo
//
//  Created by omer on 2.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import Foundation


private enum ViewControllerClasses: String {
    case Entrance = "entranceVC",
    Splash = "splashVC",
    Scene = "sceneVC",
    Information = "informationVC"
}


class ViewControllerIdentifierManager {
    
    class func getIdentifier(withClass obj: AnyClass) -> String {
        switch String(obj) {
        case String(SceneViewController):
            return ViewControllerClasses.Scene.rawValue
        case String(EntranceViewController):
            return ViewControllerClasses.Entrance.rawValue
        case String(SplashViewController):
            return ViewControllerClasses.Splash.rawValue
        case String(InformationViewController):
            return ViewControllerClasses.Information.rawValue
        default:
            return ViewControllerClasses.Entrance.rawValue
        }
    }
}