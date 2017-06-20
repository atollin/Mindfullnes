//
//  TableViewCellListening.swift
//  minf*ness
//
//  Created by Adam Tollin on 2016-11-17.
//  Copyright © 2016 Adam Tollin. All rights reserved.
//

import UIKit
import AVFoundation

class TableViewCellListening: UITableViewCell {

    @IBOutlet var btnMusicControll: UIButton!
    
    
    @IBOutlet var imageP: UIImageView!
    
    @IBOutlet var lblMusic: UILabel!
 
    
    @IBOutlet var musicImage: UIImageView!
    
    var music: String!
    var play : String!
    var paus : String!
    
    var audioPlayer = AVAudioPlayer()
    
    var playing: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // btnMusicControll.setBackgroundImage(#imageLiteral(resourceName: "play2"), for: .normal)
        //btnMusicControll.setTitle("Play", for: .normal)
       
        btnMusicControll.layer.cornerRadius = btnMusicControll.frame.width/2
       
        imageP.layer.cornerRadius = imageP.frame.width / 2
            }
    
    func setImage(){
         imageP.image = UIImage(named: play)
    }
    
    func FixPlayer(music : String){
        
        let musicUrL = NSURL(fileURLWithPath: Bundle.main.path(forResource: music, ofType: "wav")!)
        do{
            
            audioPlayer = try AVAudioPlayer(contentsOf: musicUrL as URL)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
        }
            
        catch{
            print(Error.self)
        }
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func pulseAnimation(){
        UIView.animate(withDuration: 1, delay: 0, animations: { () -> Void in
            self.imageP.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.lblMusic.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.lblMusic.alpha = 1.0
        }) { (finished: Bool) -> Void in
            UIView.animate(withDuration: 1, animations: { () -> Void in
                self.imageP.transform = CGAffineTransform.identity
                self.lblMusic.transform = CGAffineTransform.identity
                
            }) { (finished: Bool) -> Void in
                self.updatePulse()
            }}
    }
    func updatePulse(){
        if playing == true{
            pulseAnimation()
        }
    }
    
    
    @IBAction func Playmusic(_ sender: Any) {
        if playing == false{
            audioPlayer.play();
           // btnMusicControll.setBackgroundImage(#imageLiteral(resourceName: "paus2"), for: .normal)
            //btnMusicControll.setTitle("Paus", for: .normal)
            imageP.image = UIImage(named: paus)
                playing = true
            let spinAnimation = CABasicAnimation()
            spinAnimation.fromValue = 0
            spinAnimation.toValue = M_PI*2
            spinAnimation.duration = 1.5
            spinAnimation.repeatCount = Float.infinity
            spinAnimation.fillMode = kCAFillModeForwards
            spinAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            imageP.layer.add(spinAnimation, forKey: "transform.rotation.z")
            pulseAnimation()
        }
        else {
            audioPlayer.stop()
            imageP.layer.removeAllAnimations()
            
            imageP.image = UIImage(named: play)
            playing = false
            
        }
       
        
        
    }
    
}
