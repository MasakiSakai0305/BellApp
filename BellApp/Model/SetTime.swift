//
//  Time.swift
//  BellApp
//
//  Created by 境将輝 on 2020/03/03.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import Foundation

class SetTime {
    
    var secondList = [String()]
    var minitueList = [String()]
    
    init(){
        
        secondList = ["0", "10", "20", "30", "40", "50"]
        
        for i in 0 ..< 60{
            minitueList.append(String(i))
        }
        
        //最初に""が入ってしまうため
        minitueList.removeFirst()
    }
}
