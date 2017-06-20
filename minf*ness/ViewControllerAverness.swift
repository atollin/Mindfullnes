//
//  ViewControllerAverness.swift
//  minf*ness
//
//  Created by Adam Tollin on 2016-11-15.
//  Copyright © 2016 Adam Tollin. All rights reserved.
//
import UIKit

class ViewControllerAverness: UIViewController {
    
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        start.layer.cornerRadius = 0.5 * start.bounds.width
        start.layer.borderColor = UIColor.white.cgColor
        start.layer.borderWidth = 5
        start.layer.masksToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
