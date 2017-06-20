//
//  ViewAvernessQuizpageController.swift
//  minf*ness
//
//  Created by Gustav Carlsson on 2016-11-29.
//  Copyright © 2016 Adam Tollin. All rights reserved.
//

import UIKit

class ViewAvernessQuizpageController: UIViewController {

    
    
    @IBOutlet weak var questionLabel: UILabel!
    var currentQuestion = 0
    var rightAnswer:UInt32 = 0
    
    let questions = [
        "Who's mother got shot?",
        "Who started WWII",
        "Are you insecure?",
        "Is the droid you are looking for?",
        "What is Android?",
    ]
    
    let pictures:[[UIImage]] = [[
            #imageLiteral(resourceName: "bambi"),
            #imageLiteral(resourceName: "dumbo"),
            #imageLiteral(resourceName: "quasi"),
            #imageLiteral(resourceName: "simba")
        ],[
            #imageLiteral(resourceName: "hitler"),
            #imageLiteral(resourceName: "polpot"),
            #imageLiteral(resourceName: "trump"),
            #imageLiteral(resourceName: "stalin")
        ],[
            #imageLiteral(resourceName: "black"),
            #imageLiteral(resourceName: "black"),
            #imageLiteral(resourceName: "black"),
            #imageLiteral(resourceName: "black")
        ],[
            #imageLiteral(resourceName: "an-droid"),
            #imageLiteral(resourceName: "bb8"),
            #imageLiteral(resourceName: "c3po"),
            #imageLiteral(resourceName: "r2d2")
        ],[
            #imageLiteral(resourceName: "black"),
            #imageLiteral(resourceName: "black"),
            #imageLiteral(resourceName: "black"),
            #imageLiteral(resourceName: "black")
        ]]
    
    let answers = [[
            nil,
            nil,
            nil,
            nil
        ],[
            nil,
            nil,
            nil,
            nil
        ],[
            "Yes",
            "3.14",
            "Maybe",
            "10"
        ],
          [
            nil,
            nil,
            nil,
            nil
        ],[
            "Dum",
            "Obsolete",
            "Stupid",
            "Booring"
        ]]
    
    @IBAction func action(_ sender: UIButton) {
        if(sender.tag == Int(rightAnswer)){
            print("RIGHT")
        } else {
            print("WRONG")
        }
        
        if(currentQuestion != questions.count){
            newQuestion()
        } else {
            performSegue(withIdentifier: "showResult", sender: self)
        }
    }
    
    func newQuestion(){
        
        questionLabel.text = questions[currentQuestion]
        rightAnswer = arc4random_uniform(4)+1
        var button:UIButton = UIButton()
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        
        var x = 1
        
        for i in 1...4
        {
            button = view.viewWithTag(i) as! UIButton
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            button.layer.borderWidth = 5
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.masksToBounds = true
            
            if(i == Int(rightAnswer)){
                let setImage = pictures[currentQuestion][0]
                button.setTitle(answers[currentQuestion][0], for: .normal)
                UIView.transition(with: button, duration: 1.0, options: .transitionFlipFromRight, animations: {
                    button.setBackgroundImage(setImage.circle, for: .normal)
                }, completion: nil)
                
            } else {
                
                let elseImage = pictures[currentQuestion][x]
                button.setTitle(answers[currentQuestion][x], for: .normal)
                UIView.transition(with: button, duration: 1.0, options: .transitionFlipFromRight, animations: {
                    button.setBackgroundImage(elseImage.circle, for: .normal)
                }, completion: nil)
                x += 1
            }
        }
        currentQuestion += 1
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        newQuestion()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIImage {
    var circle: UIImage? {
        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: square))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
