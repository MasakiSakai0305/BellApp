//
//  soundFile.swift
//  BellApp
//
//  Created by 境将輝 on 2020/03/02.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import Foundation
import AVFoundation

class SoundFile{
    
    var player:AVAudioPlayer?
    
    func playSound(filename:String, extensionName:String, numberOfLoops:Int){
        
        print(2)
        //再生する
        let soundURL = Bundle.main.url(forResource: filename, withExtension: extensionName)
    
    do{
        print(3)
        //効果音を鳴らす
        player = try AVAudioPlayer(contentsOf: soundURL!)
        
        //繰り返しをする回数
        player?.numberOfLoops = numberOfLoops
        
        player?.play()



        
    } catch {
        print("エラーです")
        print(error)
    }
        
    }
    
    
}
