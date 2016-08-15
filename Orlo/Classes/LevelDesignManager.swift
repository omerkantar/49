//
//  LevelDesignManager.swift
//  Orlo
//
//  Created by omer on 2.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit

protocol LevelDesignDelegate {
    func willAppearLevelDesign(levelDesign: LevelDesign)
}

class LevelDesignManager: NSObject {

    let screenSize = UIScreen.mainScreen().bounds.size

    var delegate: LevelDesignDelegate
    var lwlDesigns: [LevelDesign]
    var showingDoor: Bool = false
    var step: Int = 0
    var stars: Int = 0
    
    required init(delegate: LevelDesignDelegate) {
        self.delegate = delegate
        self.lwlDesigns = Array<LevelDesign>()
    }
    
    // MARK : - Setup
    func start() {
        createTimerForDoor(35.0)
        createTimerForStars(5.0)
    }
    
    
    // MARK: - Timer
    func createTimerForStars(timeInterval: NSTimeInterval) {
        NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: #selector(LevelDesignManager.willShowLevelDesign), userInfo: nil, repeats: false)

    }
    
    func createTimerForDoor(timeInterval: NSTimeInterval) {
        
        NSTimer.scheduledTimerWithTimeInterval(timeInterval / 2.0, target: self, selector: #selector(LevelDesignManager.createLevelDesign), userInfo: nil, repeats: false)

        
        NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: #selector(LevelDesignManager.willShowDoor), userInfo: nil, repeats: false)
        
    }
    
    // MARK: - LwlDesign
    func willShowDoor() {
        showingDoor = true
        createTimerForDoor(20.0)
    }
    
    func willShowLevelDesign() {
        createLevelDesign()
        var duration = 5.0 - (Double(step) / 6.0)
        if duration < 2.50 {
            duration = 2.50
        }
        createTimerForStars(duration)
    }
    
    func createLevelDesign() {
        step += 1
        
        var allViews = Array<BaseView>()
        
        let animationDuration = getAnimationDuration()
        
        // t = sqrt(x / a)
        if showingDoor {
            
            if let door = DoorView.create() {
                
                let frame = self.getViewFrame(size: door.frame.size, allViews: allViews)
                
                door.frame = frame
                door.startOrigin = frame.origin
                door.endOrigin = CGPointMake(frame.origin.x, screenSize.height)
                door.animationDuration = NSTimeInterval(animationDuration)
                door.beginTime = 0.65
                
                allViews.append(door)
                showingDoor = false
            }
        }else {

            var starCount = 0
            
            switch step {
            case 0...20:
                starCount = 1
                break
            default:
                starCount = Int(rand()%2) + 1
            }

            for i in 0..<starCount {
                
                if let star = StarView.create() {
                    let timeRandom = rand()%50 + 25
                    let time = Double(timeRandom / 100) * Double(i)
                    
                    let frame = self.getViewFrame(size: star.frame.size, allViews: allViews)
                    star.frame = frame
                    star.startOrigin = frame.origin
                    star.endOrigin = CGPointMake(frame.origin.x, screenSize.height)
                    star.animationDuration = NSTimeInterval(animationDuration)
                    star.beginTime = time
                    
                    allViews.append(star)
                }
            }

        }
        
        let levelDesign = LevelDesign()
        levelDesign.level = step
        levelDesign.views = allViews
        
        self.delegate.willAppearLevelDesign(levelDesign)
        
    }
    
    
    func getViewFrame(size size: CGSize, allViews: Array<BaseView>) -> CGRect{
        
        for view in allViews {
            
            let vFrame = view.frame
            
            let frame = self.randomFrame(size)
            
            if frame.intersects(vFrame) {
                return getViewFrame(size: size, allViews: allViews)
            }
            
            return frame
        }
        
        return self.randomFrame(size)
    }
    
    
    func randomFrame(size: CGSize) -> CGRect {
        let a = Int32(screenSize.height) / 2
        let padding = 10.0 as CGFloat
        let height = size.height
        let width = size.width
        let maxY = CGFloat(rand()%(a)) + (padding + height)
        let maxX = screenSize.width - width - padding
        let originY = GenericUtility.randomNumber(Int(height + padding), max: Int(maxY))
        let originX = GenericUtility.randomNumber(Int(padding), max: Int(maxX))
        
        let origin = CGPointMake(originX, -originY)
        let frame = CGRect(origin: origin, size: size)
        return frame
    }
    
    
    func getAnimationDuration() -> CGFloat {
        // a => range 50 250
        var a = CGFloat(Double(step) * M_PI * 2)
        if a < 50.0 {
            a = 50.0
        }else if a >= 250.0 {
            a = 250.0
        }        
        let animationDuration = sqrt(screenSize.height / (a))
        return animationDuration
    }

}
