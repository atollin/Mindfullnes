//
//  ViewControllerBreathe.swift
//  minf*ness
//
//  Created by Adam Tollin on 2016-11-15.
//  Copyright © 2016 Adam Tollin. All rights reserved.
//

import UIKit

class ViewControllerBreathe: UIViewController {
    
    @IBOutlet var breatheView: UIView!
    
    @IBOutlet var lblBreathe: UILabel!
    
    @IBOutlet var btnBrethe: UIButton!
    
    var expansionDuration = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        breatheView.layer.cornerRadius = breatheView.frame.size.width/2
        breatheView.layer.borderColor = UIColor.white.cgColor
        breatheView.layer.borderWidth = 5
    }
    
    @IBAction func StartBreathing(_ sender: Any) {
        lblBreathe.isHidden = false
        btnBrethe.isHidden = true
        breatheAnimation()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func breatheAnimation(){
        
        
        UIView.animate(withDuration: expansionDuration, delay: 0, animations: { () -> Void in
            self.breatheView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.lblBreathe.text = "In"
        }) { (finished: Bool) -> Void in
            UIView.animate(withDuration: self.expansionDuration, animations: { () -> Void in
                self.breatheView.transform = CGAffineTransform.identity
                self.lblBreathe.text = "Out"
            }) { (finished: Bool) -> Void in
                self.updateTime()
            }}
        
    }
    
    func updateTime(){
        if (expansionDuration < 0.5){
            breatheAnimation()
        } else {
            expansionDuration -= 0.2
            breatheAnimation()
        }
        
    }
    
    
}
