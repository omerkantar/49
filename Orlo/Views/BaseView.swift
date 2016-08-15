//
//  BaseView.swift
//  Orlo
//
//  Created by omer on 1.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit

class BaseView: UIView {

    var imgView: UIImageView?
    
    var startOrigin: CGPoint = CGPointZero
    var endOrigin: CGPoint = CGPointZero
    var animationDuration: NSTimeInterval = 1.5
    var beginTime: NSTimeInterval = 1.0
    
    var startedAnimation: Bool = false
    var keeped: Bool = false

    var isStar: Bool = true
    
    class func getImage() -> UIImage? {
        return nil
    }
    
    class func create() -> BaseView? {
        if let image = getImage() {
            
            let rotation = rand()%180
            let imgFrame = CGRect(origin: CGPointZero, size: image.size)
            let view = BaseView(frame: imgFrame)
            view.imgView = UIImageView(frame: imgFrame)
            view.imgView?.image = image
            view.imgView?.contentMode = .ScaleAspectFit
            view.backgroundColor = UIColor.clearColor()
            view.transform = CGAffineTransformRotate(CGAffineTransformIdentity, CGFloat(rotation))
            view.addSubview(view.imgView!)
            view.isStar = !isDoor()
            return view
        }
        return nil
    }
    
    class func isDoor() -> Bool {
        return false
    }
    
    func startAnimation() {
        startedAnimation = false
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = startOrigin.y
        animation.toValue = endOrigin.y
        animation.duration = animationDuration
        animation.removedOnCompletion = true
        animation.delegate = self
        
        animation.beginTime = CACurrentMediaTime() + beginTime
        self.layer.addAnimation(animation, forKey: "cubeAnimation")
        self.layer.delegate = self
        animation.delegate = self
    }
    
    func stopAnimation() {
        let pausedTime = self.layer.convertTime(CACurrentMediaTime(), toLayer: nil)
        self.layer.speed = 0.0;
        self.layer.timeOffset = pausedTime;
    }
    
    func resumeAnimation() {
        let pausedTime = self.layer.timeOffset
        self.layer.speed = 1.0
        self.layer.timeOffset = 0.0
        self.layer.beginTime = 0.0
        let timeSincePause = self.layer.convertTime(CACurrentMediaTime(), toLayer: nil) - pausedTime
        self.layer.beginTime = timeSincePause
        
    }
    
    override func animationDidStart(anim: CAAnimation) {
        startedAnimation = true
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.removeFromSuperview()
        startedAnimation = false
    }
    
    internal func intersectsPlanetFrame(planetFrame: CGRect) -> Bool {
        
        // :'( image circle or triangle and frame coordinate failure :(
//        var pFrame = planetFrame
//        pFrame.origin.x += 10.0
//        pFrame.origin.y += 5.0
//        pFrame.size.height -= 25
//        pFrame.size.width -= 20
//        
//        var meFrame = self.layer.presentationLayer()?.frame
//        if isStar == false {
//            meFrame?.size.width -= 20
//            meFrame?.size.height -= 20
//            meFrame?.origin.y -= 10.0
//        }
        
        return self.layer.presentationLayer()!.frame.intersects(planetFrame)
    }
    

    func keepedAnimation() {
        UIView.animateWithDuration(0.25) {
            self.alpha = 0.0
        }
    }

    
}
