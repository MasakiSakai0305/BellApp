//
//  ViewController.swift
//  BellApp
//
//  Created by 境将輝 on 2020/03/02.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var soundFile = SoundFile()
    var withoutMP3 = WithoutMP3()
    
    var ct = TimeCount()
    
    //ナビゲーションアイテムのプラスボタン宣言
    var addBarButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [addBarButtonItem]
        
//        Timer.scheduledTimer(timeInterval: 1, target: TimeCount(), selector: #selector(TimeCount.updatePer1Second), userInfo: nil, repeats: true)
//        
        
        let str:String = "book:note pen bag"
        let arr:[String] = str.components(separatedBy: ":")
        
        print(arr[1])
    }
    
    //追加ボタン
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        print("【+】ボタンが押された!")
          
        let addbellVC = storyboard?.instantiateViewController(withIdentifier: "add")  as! addBellViewController
                          
        
        //画面遷移
        navigationController?.pushViewController(addbellVC, animated: true)
                      
            
        }
    
    
    @IBAction func bell(_ sender: Any) {

        //var b = Bell(bellDict: ["1": 1])
        
        
       // soundFile.playSound(filename: "bellSound", extensionName: "mp3", numberOfLoops: 1)

    }
    
    
    @IBAction func picker(_ sender: Any) {
        
        performSegue(withIdentifier: "pick", sender: nil)
        
        
    }
    


}

