//
//  withoutMP3.swift
//  BellApp
//
//  Created by 境将輝 on 2020/03/02.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import Foundation


class WithoutMP3: SoundFile{
    
    override func playSound(filename: String, extensionName: String, numberOfLoops:Int) {
        
        if extensionName == "mp3"{
            print("このファイルは再生できません")
        }
        
        player?.stop()
    }
}
