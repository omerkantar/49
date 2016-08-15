//
//  SplashViewController.swift
//  Orlo
//
//  Created by omer on 1.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

    @IBOutlet weak var lblTitle: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        lblTitle.text = NSLocalizedString("txt_splash_title", comment: "")
        
        let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            // your function here
            UIView.animateWithDuration(1.5, animations: {
                self.view.backgroundColor = UIColor.whiteColor()
            }) { (fns) in
                self.navigateVC()
            }
            
        })

        
    }

    
    func navigateVC() {
        if PersonManager.sharedInstance.isFirst {
            presentSceneViewController()
        }else {
            rootingEntranceVC()
        }
    }

}
