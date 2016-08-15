//
//  PlanetMotionManager.swift
//  Orlo
//
//  Created by omer on 2.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit

class PlanetMotionManager: NSObject {
    
    var unit: CGFloat
    // default 10
    var range: Double = 10.0 {
        didSet {
            findUnit()
        }
    }
    
    var playerFrame: CGRect
    var playerEndOriginX: CGFloat
    var playerStartOriginX: CGFloat
    var playerOriginY: CGFloat
    var playerEndPoint: CGPoint
    let screenSize = UIScreen.mainScreen().bounds.size
    let padding: CGFloat = 2.0
    
    init(withPlayerFrame player: CGRect) {
        
        self.playerFrame = player
        self.playerOriginY = player.origin.y
        self.playerStartOriginX = padding
        self.playerEndOriginX = screenSize.width - player.size.width - padding
        self.playerEndPoint = player.origin
        self.unit = screenSize.width / CGFloat(range)
    }
    
    func findUnit() -> Void {
        unit = screenSize.width / CGFloat(range)
    }
    
    func startDeviceMotionUpdate(withGravityX x: CGFloat) -> CGPoint {
        var originX = playerEndPoint.x + ( x * unit )
        
        if originX <= playerStartOriginX {
            originX = playerStartOriginX
        }else if originX >= playerEndOriginX {
            originX = playerEndOriginX
        }
        
        playerEndPoint = CGPoint(x: originX, y: playerOriginY)
        return playerEndPoint
    }
}
