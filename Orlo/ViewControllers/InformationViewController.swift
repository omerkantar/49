//
//  InformationViewController.swift
//  Orlo
//
//  Created by omer on 4.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit

class InformationViewController: BaseViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblInformation: UILabel!
    @IBOutlet weak var btnBottom: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewContainer: UIView!
    
    var isFinished: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btnBottom.layer.cornerRadius = btnBottom.frame.size.height / 2.0
        btnBottom.layer.borderWidth = 1.5
        btnBottom.layer.borderColor = UIColor.whiteColor().CGColor
        btnBottom.backgroundColor = UIColor.clearColor()
        
        lblTitle.alpha = 0.0
        lblInformation.alpha = 0.0
        btnBottom.alpha = 0.0
        btnClose.alpha = 0.0
        
        lblTitle.text = NSLocalizedString("txt_info_title", comment: "")

        let informationVM = PersonManager.sharedInstance.informationVM
        
        self.lblInformation.numberOfLines = 0
        self.lblInformation.text = informationVM?.txtDescription
        self.lblInformation.attributedText = informationVM?.attDescription
        self.lblInformation.sizeToFit()
        self.viewContainer.updateConstraintsIfNeeded()

        
        let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {

            
            UIView.animateWithDuration(1.5, animations: {
                self.lblTitle.alpha = 1.0
                self.lblInformation.alpha = 1.0
                self.btnClose.alpha = 1.0
                self.btnBottom.alpha = 1.0
                
            })
            
            self.startWaveAnimation()
            
        })

    }
 
    // MARK: Actions
    @IBAction func tappedCloseBtn() {
        UIView.animateWithDuration(0.2, animations: { 
            self.view.alpha = 0.0
            }) { (fns) in
                self.rootingEntranceVC()
        }
    }
    
    // MARK: Animations
    func startWaveAnimation() {
        
        let wave1 = getWaveView()
        
        wave1.center = btnBottom.center
        
        viewContainer.addSubview(wave1)
        viewContainer.sendSubviewToBack(wave1)
        
        UIView.animateWithDuration(1.85, animations: {
                wave1.alpha = 0.0
                wave1.transform = CGAffineTransformMakeScale(2.0, 2.0)
            }) { (fns) in
                wave1.removeFromSuperview()
                self.startWaveAnimation()
        }
        
        
    }
    
    func getWaveView() -> UIView {
        let btnSize = btnBottom.frame.size
        let wave = UIView(frame: CGRectZero)
        wave.frame = CGRect(origin: CGPointZero, size: btnSize)
        wave.layer.borderColor = UIColor.whiteColor().CGColor
        wave.layer.borderWidth = 1.0
        wave.layer.cornerRadius = btnSize.height / 2.0
        return wave
    }
}
