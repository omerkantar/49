//
//  ViewController.swift
//  Orlo
//
//  Created by omer on 1.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    // MARK : - Public methods
    
    internal class func create() -> BaseViewController {
        let identifier = ViewControllerIdentifierManager.getIdentifier(withClass: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(identifier) as! BaseViewController
        return vc
    }
    
    internal func presentVC(vc: BaseViewController, fadeAnimation:Bool? = true) {
        
        if fadeAnimation == true {
            
            vc.view.alpha = 0.0
            
            self.presentViewController(vc, animated: false, completion: {
                UIView.animateWithDuration(1.25, animations: { 
                    vc.view.alpha = 1.0
                })
            })
            
        }else {
            self.presentViewController(vc, animated: false, completion: nil)
        }
    }
    
    func rootingEntranceVC() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.rootingEntranceVC()
    }
    
    func presentSceneViewController() {
        let sceneVC = SceneViewController.create()
        sceneVC.view.alpha = 0.0
        UIView.animateWithDuration(1.25, animations: {
            self.view.alpha = 0.0
        }) { (fns) in
            self.presentViewController(sceneVC, animated: false, completion: {
                UIView.animateWithDuration(0.2, animations: {
                    sceneVC.view.alpha = 1.0
                })
            })
        }
    }

}

