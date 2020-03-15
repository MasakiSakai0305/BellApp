//
//  Bell.swift
//  BellApp
//
//  Created by 境将輝 on 2020/03/02.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import Foundation
//import AVFoundation

class Bell{
    
   // var player:AVAudioPlayer?
//    var withoutMP3 = WithoutMP3()
//    var soundFile = SoundFile()
    
    // <ベルがなる回数:ベルが鳴る時間>
    //var bellConfigueDict: Dictionary<Int, TimeCount> = [:]
    var bellConfigueDict: Dictionary<String, String> = [:]
    
    
    //Dict初期化
    init(){
        
//        bellConfigueDict[1] = TimeCount()
//        bellConfigueDict[2] = TimeCount()
//        bellConfigueDict[3] = TimeCount()
        
        bellConfigueDict["1"] = "0:00"
        bellConfigueDict["2"] = "0:00"
        bellConfigueDict["3"] = "0:00"
        
    }
    
    func setConfifueDict(numberOfRing:Int, Value:String){
        
        bellConfigueDict[String(numberOfRing)] = Value
        
    }
    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.bellConfigueDict, forKey: "cellArray")
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        self.bellConfigueDict = aDecoder.decodeObject(forKey: "cellArray") as! Dictionary
//    }
//
    
//    func playSound(){
//
//        let bellcount = 1
//
//
//        if bellcount == 1{
//            print(1)
//
//            soundFile.playSound(filename: "bellSound", extensionName: "mp3", numberOfLoops: bellcount - 1)
//
//        } else {
//
//            soundFile.playSound(filename: "cutBellSound", extensionName: "mp3", numberOfLoops: bellcount - 1)
//
//        }
//    }
    
    
    
    
    
    
}
