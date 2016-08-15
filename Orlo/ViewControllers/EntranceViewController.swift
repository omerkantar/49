//
//  EntranceViewController.swift
//  Orlo
//
//  Created by omer on 1.08.2016.
//  Copyright © 2016 omer. All rights reserved.
//

import UIKit

class EntranceViewController: BaseViewController {

    @IBOutlet weak var btnBottom: UIButton!

    let planetView = PlanetView.create()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        design()
        
        let tapGRBG: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedBGView(_:)))
        view.addGestureRecognizer(tapGRBG)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        planetView.center = view.center
    }
    
    // MARK: - Design 
    func design() {
        let isDark: Bool = rand()%2 == 1 ? false : true

        let darkColor = UIColor.darkColor()
        let whiteColor = UIColor.whiteColor()

        view.addSubview(planetView)
        
        let txtPersonName = PersonManager.sharedInstance.person.name
        btnBottom.setTitle(txtPersonName, forState: .Normal)
        btnBottom.titleLabel?.adjustsFontSizeToFitWidth = true
        btnBottom.titleLabel?.lineBreakMode = .ByClipping
        
        if isDark {
            btnBottom.setTitleColor(whiteColor, forState: .Normal)
            view.backgroundColor = darkColor
            planetView.whiteMode()
        }else {
            btnBottom.setTitleColor(darkColor, forState: .Normal)
            view.backgroundColor = whiteColor
            planetView.darkMode()
        }
        
        let motionEffectGroup = GenericUtility.motionEffectGroup(20.0)
        
        planetView.addMotionEffect(motionEffectGroup)
        
    }
    
    // MARK: - Actions
    @IBAction func tappedBottomBtn() {
        let informationVC = InformationViewController.create()
        presentVC(informationVC)
        
    }
    
    func tappedBGView(sender: UITapGestureRecognizer) {
        presentSceneViewController()
    }
        
}
