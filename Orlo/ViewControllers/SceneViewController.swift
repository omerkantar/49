//
//  SceneViewController.swift
//  Orlo
//
//  Created by omer on 1.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit
import CoreMotion

class SceneViewController: BaseViewController, UIAccelerometerDelegate, LevelDesignDelegate {

    @IBOutlet weak var lblStarsNumber: UILabel!
    @IBOutlet weak var imgSmallStar: UIImageView!
    @IBOutlet weak var lblInformation: UILabel!
    
    let motionManager = CMMotionManager()

    var planetView = PlanetView.create()
    var planetMotionManager: PlanetMotionManager?
    var levelDesignManager: LevelDesignManager?
    
    var visibleViews: [BaseView]?
    var isDark: Bool = false
    var time = 0
    var isFirst: Bool = false
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    // MARK: Design
    
    func setup() {
        
        lblInformation.text = NSLocalizedString("txt_game_info", comment: "")
        
        isDark = rand()%2 == 0 ? true : false
        
        visibleViews = [BaseView]()
        lblInformation.alpha = 0.0
        
        self.view.addSubview(planetView)
        planetMotionManager = PlanetMotionManager(withPlayerFrame: planetView.frame)
        levelDesignManager = LevelDesignManager(delegate: self)
        desing()
        updateStarsNumberLabel()
        
        planetView.alpha = 0.0
        
        let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            let frame = self.planetView.frame
            
            var bottomFrame = UIScreen.mainScreen().bounds
            bottomFrame.origin.x = bottomFrame.width / 2.0
            bottomFrame.origin.y = bottomFrame.height + self.planetView.frame.height
            
            self.planetView.alpha = 1.0
            self.planetView.center = bottomFrame.origin
            
            UIView.animateWithDuration(1.25, animations: { 
                self.planetView.frame = frame
                }, completion: { (fns) in
                    self.buildMotionManger()
                    if PersonManager.sharedInstance.isFirst {
                        self.isFirst = true
                        self.showInformationLbl()
                    }else {
                        self.levelDesignManager?.start()
                    }
            })
        })

    }
    
    func desing() {
        let darkColor = UIColor.darkColor()
        let whiteColor = UIColor.whiteColor()
        
        if isDark {
            
            UIView.animateWithDuration(0.25, animations: { 
                self.view.backgroundColor = darkColor
                self.lblStarsNumber.textColor = whiteColor
                self.planetView.whiteMode()
                self.lblInformation.textColor = whiteColor
            })
            
        }else {
            
            UIView.animateWithDuration(0.25, animations: {
                self.view.backgroundColor = whiteColor
                self.lblStarsNumber.textColor = darkColor
                self.planetView.darkMode()
                self.lblInformation.textColor = darkColor

            })
            
            
        }
    }
    
    
    func goInCircleDoorView() {
        isDark = !isDark
        desing()
    }
    
    func updateStarsNumberLabel() {
        if let stars = levelDesignManager?.stars {
            lblStarsNumber.text = String(stars)
        }
    }
    
    func showInformationLbl() {
        
        UIView.animateWithDuration(0.25) { 
            self.lblInformation.alpha = 1.0
        }
    }
    
    func hideInformationLbl() {
        
        UIView.animateWithDuration(0.25, animations: { 
            self.lblInformation.alpha = 0.0
            }) { (fns) in
                self.lblInformation.hidden = true
                self.levelDesignManager?.start()
        }

    }
    
    // MARK: Build
    func buildMotionManger() {
        if motionManager.deviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) {
                [weak self] (data: CMDeviceMotion?, error: NSError?) in
                if let gravity = data?.gravity {
                    let originX = CGFloat(gravity.x)
                    self?.movedDevice(withOriginX: originX)
                }
                
            }
        }
    }
    

    // MARK: Game Life Cycle
    
    func finishGame() {
        let informationVC = InformationViewController.create()
        presentVC(informationVC)
    }
    
    func starsUp() {
        levelDesignManager?.stars += 1
        updateStarsNumberLabel()
        
        UIView.animateWithDuration(0.25, animations: {
            self.imgSmallStar.transform = CGAffineTransformMakeScale(1.25, 1.25)
            }) { (fns) in
                UIView.animateWithDuration(0.15, animations: { 
                    self.imgSmallStar.transform = CGAffineTransformMakeScale(1.0, 1.0)
                })
        }
        
        if levelDesignManager?.stars == 49 {
            finishGame()
        }
    }
    
    
    // MARK: Motion Methods
    func movedDevice(withOriginX x: CGFloat) {
        
        let originX = planetMotionManager?.startDeviceMotionUpdate(withGravityX: x)
        
        var frame = planetView.frame
        frame.origin.x = (originX?.x)!
        planetView.frame = frame
        
        ifkeepViews()
        
        if isFirst {
            NSTimer.scheduledTimerWithTimeInterval(1.25, target: self, selector: #selector(self.hideInformationLbl), userInfo: nil, repeats: false)
            isFirst = false
        }
    }
    
    func ifkeepViews() {
        
        if let views = visibleViews {
            for obj in views {
                if obj.startedAnimation {
                    if obj.keeped == false {
                        let planetFrame = self.planetView.frame
                        //triangle image                        
                        if obj.intersectsPlanetFrame(planetFrame) {
                            obj.keeped = true
                            obj.keepedAnimation()
                            
                            if obj.isStar {
                                starsUp()
                            }else {
                                goInCircleDoorView()
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: LevelDesignDelegate
    func willAppearLevelDesign(levelDesign: LevelDesign) {
        
        for obj in levelDesign.views! {

            self.view.addSubview(obj)
            self.view.sendSubviewToBack(obj)
            obj.startAnimation()
            visibleViews?.append(obj)
        }
    }

    

    

}
