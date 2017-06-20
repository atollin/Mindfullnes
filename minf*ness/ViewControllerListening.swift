//
//  ViewControllerListening.swift
//  minf*ness
//
//  Created by Adam Tollin on 2016-11-15.
//  Copyright © 2016 Adam Tollin. All rights reserved.
//

import UIKit


struct celldata{
    let titel: String!
    let name : String!
    let color: UIColor!
    let play : String!
    let paus : String!
    

}

class ViewControllerListening: UITableViewController {
    
    
    var musicArray = [celldata]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //starry-night
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "two.jpg"))
        
        
        tableView.register(UINib(nibName: "TableViewCellListening", bundle: nil), forCellReuseIdentifier: "soundCell")
        
        musicArray = [celldata(titel: "Baby Love",          name: "BabyCry",            color: UIColor(red: 215/255, green: 42/255,  blue: 58/255,  alpha: 1.0), play: "playone.png",
                               paus: "pausone.png" ),
                      celldata(titel: "Building Nature",    name: "BandSaw",            color: UIColor(red: 253/255, green: 138/255, blue: 60/255,  alpha: 1.0), play: "playtwo.png",
                               paus: "paustwo.png"  ),
                      celldata(titel: "Calming pulse",      name: "LoudNoice",          color: UIColor(red: 253/255, green: 209/255, blue: 48/255,  alpha: 1.0), play: "playthree.png",
                               paus: "pausthree.png"  ),
                      celldata(titel: "Mindful Healing ",   name: "DentistDrill",       color: UIColor(red: 251/255, green: 237/255, blue: 64/255,  alpha: 1.0), play: "playfour.png",
                               paus: "pausfour.png"  ),
                      celldata(titel: "Restful Call",       name: "Sirens",             color: UIColor(red: 165/255, green: 238/255, blue: 47/255,  alpha: 1.0), play: "playfive.png",
                               paus: "pausfive.png"  ),
                      celldata(titel: "Dreamful Sleeping",  name: "Snoring",            color: UIColor(red: 90/255,  green: 205/255, blue: 255/255, alpha: 1.0), play: "playsix.png",
                               paus: "paussix.png"  ),
                      celldata(titel: "Beautiful Morning",  name: "WakeUpAlarm",        color: UIColor(red: 36/255,  green: 192/255, blue: 248/255, alpha: 1.0), play: "playseven.png",
                               paus: "pausseven.png"  ),
                      celldata(titel: "Love is Calling",    name: "WomanScream",        color: UIColor(red: 11/255,  green: 81/255,  blue: 192/255, alpha: 1.0), play: "playeight.png",
                               paus: "pauseight.png"  ),
                      celldata(titel: "Expanding Focus",    name: "NailOnBlackboard",   color: UIColor(red: 186/255, green: 38/255,  blue: 192/255, alpha: 1.0), play: "playnine.png",
                               paus: "pausnine.png"  ),
                      celldata(titel: "Graceful Nature",    name: "IncrediblyAnnoying", color: UIColor(red: 138/255, green: 24/255,  blue: 176/255, alpha: 1.0), play: "playten.png",
                               paus: "pausten.png"  )]
        
       
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "soundCell", for: indexPath) as! TableViewCellListening
        
        
        cell.lblMusic?.text  = musicArray[indexPath.row].titel
        cell.music = musicArray[indexPath.row].name
        //cell.musicImage.backgroundColor = musicArray[indexPath.row].color
        cell.FixPlayer(music: musicArray[indexPath.row].name)
        cell.btnMusicControll.setTitleColor(musicArray[indexPath.row].color, for: .normal)
        cell.play = musicArray[indexPath.row].play
        cell.paus = musicArray[indexPath.row].paus
        cell.setImage()
        cell.backgroundColor = UIColor.clear
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.height - 64) / 10
    }
}
