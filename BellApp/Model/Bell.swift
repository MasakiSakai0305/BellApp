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
    var bellConfigueDict: Dictionary<Int, TimeCount> = [:]
    
    //Dict初期化
    init(){
        
        bellConfigueDict[1] = TimeCount()
        bellConfigueDict[2] = TimeCount()
        bellConfigueDict[3] = TimeCount()
        
    }
    
    func setConfifueDict(numberOfRing:Int, Value:TimeCount){
        
        bellConfigueDict[numberOfRing] = Value
        
    }
    
    
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
