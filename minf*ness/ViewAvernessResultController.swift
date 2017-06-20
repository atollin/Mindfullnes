//
//  ViewAvernessResultController.swift
//  minf*ness
//
//  Created by Gustav Carlsson on 2016-11-29.
//  Copyright © 2016 Adam Tollin. All rights reserved.
//

import UIKit

class ViewAvernessResultController: UIViewController {

  
    
    @IBOutlet var btnDone: UIButton!

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.layer.cornerRadius = 0.5 * image.bounds.width
        image.layer.borderWidth = 5
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.masksToBounds = true
        btnDone.layer.cornerRadius = btnDone.frame.width/2
        btnDone.layer.borderColor = UIColor.white.cgColor
        btnDone.layer.borderWidth = 5
        
        //done.layer.cornerRadius = 0.5 * done.bounds.width
        //done.layer.borderWidth = 5
        //done.layer.borderColor = UIColor.white.cgColor
        //done.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*
    @IBAction func pressDone(_ sender: Any) {
        
        
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
