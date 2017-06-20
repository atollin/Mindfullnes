//
//  ViewControllerQuotes.swift
//  minf*ness
//
//  Created by Adam Tollin on 2016-11-15.
//  Copyright © 2016 Adam Tollin. All rights reserved.
//

import UIKit
import Firebase
import SystemConfiguration

class ViewControllerQuotes: UIViewController {
    
    @IBOutlet var lblQuotes: UILabel!
   
    
    @IBOutlet var viewQ: UIView!
    
    
    @IBOutlet weak var innerviewQ: UIView!
    
    
    @IBOutlet weak var visualQ: UIVisualEffectView!
    
    
    var ref: FIRDatabaseReference!
    var qArray = [String]()
    
    var number = 1
    var cornerR:CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
 
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        ref = FIRDatabase.database().reference()
        
        
        viewQ.layer.cornerRadius = cornerR
        visualQ.layer.cornerRadius = cornerR
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getQuotes()
    }
    
    func getQuotes(){
        if(isInternetAvailable()){
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
                let q = snapshot.value as? [String : AnyObject] ?? [:]
            
                var tempArr = [String]()
            
                for item in q.values {
                    for i in 0...(item.count - 1) {
                        tempArr.append((item[i] as? String)!)
                    }
                }
            
                DispatchQueue.main.async {
                    self.qArray = tempArr
                    self.changeQuote()
                }
            
            
            }) { (error) in
                    print(error.localizedDescription)
                }
        } else {
            qArray = ["Shake me baby! Shake me harder!!... Almost there!!",
                      "\"Grab the by the pussy\" \n\n D.Trump",
                      "\"Five fingers up \n YO MAMA\" \n\n R.Kochauf",
                      "\"You are just an average breed of monkey on an average planet circling a small star\"\n\n S.Hawkings",
                      "\"Adam is awesome\" \n\n E.Verybody",
                      "\"Whatever you are. Don't\" \n\n A.Lincoln",
                      "\"Don't cry because it's over. Smile because it happend\" \n\n A.Hitler",
                      "\"Always kiss the children goodnight, even if they're someone else's\" \n\n J.Brown",
                      "\"With great power comes great responsibility\" \n\n Batman",
                      "\"If you can't hate yourself, how the hell are you going to hate someone else\""
            ]
        }
        
        
    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    
    func respondToSwipeGesture(_gesture: UIGestureRecognizer) {
        
        if let swipeGesture = _gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.right:
                number += 1
                if(number >= qArray.count - 1){
                    number = 1
                }
                flipLeft()
                break
                
            case UISwipeGestureRecognizerDirection.left:
                number -= 1
                if(number < 1){
                    number = qArray.count - 1
                }
                flipRight()
                break
                
                
            default:
                break
            }
        }
    }
    
    func changeQuote(){
        print(qArray)
        lblQuotes.text = qArray[number]
        
    }
    
    func flipRight(){
        
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: viewQ, duration: 1.0, options: transitionOptions, animations: {
            
        })
        changeQuote()
        
    }
    func flipLeft(){
        
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        
        UIView.transition(with: viewQ, duration: 1.0, options: transitionOptions, animations: {
            
        })
        changeQuote()
        
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        var randomInt:Int
        
        repeat {
        
            let randomNum:UInt32 = arc4random_uniform(UInt32(qArray.count))
            randomInt = Int(randomNum)
        
        } while number == randomInt
        
        number = randomInt
        //viewQtwo.isHidden = true
        shakeView()
        shrinkView()
        changeQuote()
        //shakeView()
        //viewQtwo.isHidden = false
        
        
    }
    
    func shrinkView(){
        UIView.animate(withDuration: 0.2, delay: 0, animations: { () -> Void in
            self.viewQ.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (finished: Bool) -> Void in
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.viewQ.transform = CGAffineTransform.identity
            })
        }
    }
    
    func shakeView(){
        let shake:CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let from_point:CGPoint = CGPoint(x: viewQ.center.x - 25, y: viewQ.center.y + 5)
        let from_value:NSValue = NSValue(cgPoint: from_point)
        
        let to_point:CGPoint = CGPoint(x: viewQ.center.x + 25, y: viewQ.center.y - 5)
        let to_value:NSValue = NSValue(cgPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        
        viewQ.layer.add(shake, forKey: "position")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

