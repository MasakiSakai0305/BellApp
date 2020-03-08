//
//  addBellViewController.swift
//  BellApp
//
//  Created by 境将輝 on 2020/03/02.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit

class addBellViewController: UIViewController, UINavigationControllerDelegate {
    
    
    //タイマー（時間表示用）
    let timeLabel = UILabel()
    
    //スタート・ストップボタン
    let startButton = UIButton()
    let stopButton = UIButton()
    
    //ボタンに使う画像
    let startImage:UIImage = UIImage(named: "start")!
    let stopImage:UIImage = UIImage(named: "stop")!
    
    //ベルの画像
    let bellImageView1 = UIImageView()
    let bellImageView2 = UIImageView()
    let bellImageView3 = UIImageView()
    
    //ベルの数を表示するもの
    let x2Label = UILabel()
    let x3Label = UILabel()
    
    //設定する時間のラベル
    var setTime1Button = UIButton()
    var setTime2Button = UIButton()
    var setTime3Button = UIButton()
    
    //タイマークラス
    var tc = TimeCount()
    
    //サウンド関連
    var soundFile = SoundFile()
    var withoutMP3 = WithoutMP3()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tc = TimeCount()
        
        
        self.view.backgroundColor = .white

        
        //timeラベル設定
        timeLabel.frame = CGRect(x: view.frame.size.width/4, y: view.frame.size.height/7, width: view.frame.size.width/2, height: view.frame.size.height/5) // 位置とサイズの指定
        timeLabel.textAlignment = NSTextAlignment.center // 横揃えの設定
        timeLabel.text = "\(tc.minitue):\(tc.second)" // テキストの設定
        timeLabel.backgroundColor = .green
        timeLabel.textColor = UIColor.black // テキストカラーの設定
        timeLabel.font = UIFont(name: "HiraKakuProN-W6", size: 47) // フォントの設定
        
        
        //ボタン:位置・大きさ設定, 画像をセット
        startButton.frame = CGRect(x: view.frame.size.width/7.2, y: view.frame.size.height/1.15 , width: 80, height: 80)
        startButton.setImage(startImage, for: .normal)
        stopButton.frame = CGRect(x: view.frame.size.width/1.5, y: view.frame.size.height/1.15, width: 80, height: 80)
        stopButton.setImage(stopImage, for: .normal)
        
        //スタート・ストップボタンアクション定義
        startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stop), for: .touchUpInside)
        
        //ベル画像:位置・大きさ設定, 画像をセット
        bellImageView1.image = UIImage(named: "bell")
        bellImageView1.frame = CGRect(x: view.frame.size.width/3, y: view.frame.size.height/2, width: 30, height: 30)
        bellImageView2.image = UIImage(named: "bell")
        bellImageView2.frame = CGRect(x: view.frame.size.width/3, y: view.frame.size.height/2 + 35, width: 30, height: 30)
        bellImageView3.image = UIImage(named: "bell")
        bellImageView3.frame = CGRect(x: view.frame.size.width/3, y: view.frame.size.height/2 + 70, width: 30, height: 30)
        
        //x2, x3ラベル設定
        x2Label.frame = CGRect(x: view.frame.size.width/3 + 30, y: view.frame.size.height/2 + 40, width: 30, height: 30)
        x2Label.text = "x2"
        x2Label.textColor = .black
        x3Label.frame = CGRect(x: view.frame.size.width/3 + 30, y: view.frame.size.height/2 + 75, width: 30, height: 30)
        x3Label.text = "x3"
        x3Label.textColor = .black
        
        
        //設定時間ボタンの設定
        setTime1Button.frame = CGRect(x: view.frame.size.width/2, y: view.frame.size.height/2, width: 80, height: 30)
        setTime1Button.setTitle("0:00", for: .normal)
        setTime1Button.setTitleColor(.green, for: .normal)
        setTime2Button.frame = CGRect(x: view.frame.size.width/2, y: view.frame.size.height/2 + 40, width: 80, height: 30)
        setTime2Button.setTitle("0:00", for: .normal)
        setTime2Button.setTitleColor(.red, for: .normal)
        setTime3Button.frame = CGRect(x: view.frame.size.width/2, y: view.frame.size.height/2 + 75, width: 80, height: 30)
        setTime3Button.setTitle("0:00", for: .normal)
        setTime3Button.setTitleColor(.purple, for: .normal)
        
        
        //設定時間ボタンアクション定義
        setTime1Button.addTarget(self, action: #selector(setTime1), for: .touchUpInside)
        setTime2Button.addTarget(self, action: #selector(setTime2), for: .touchUpInside)
        setTime3Button.addTarget(self, action: #selector(setTime3), for: .touchUpInside)
        
        
        self.view.addSubview(timeLabel)
        self.view.addSubview(startButton)
        self.view.addSubview(stopButton)
        self.view.addSubview(bellImageView1)
        self.view.addSubview(bellImageView2)
        self.view.addSubview(bellImageView3)
        self.view.addSubview(x2Label)
        self.view.addSubview(x3Label)
        self.view.addSubview(setTime1Button)
        self.view.addSubview(setTime2Button)
        self.view.addSubview(setTime3Button)
    
    }
    
    
    //タイマー設定画面に遷移
    func goTimer(){
        
        let setTimeVC = storyboard?.instantiateViewController(withIdentifier: "setTime")  as! SetTimerViewController
        //画面遷移
        navigationController?.pushViewController(setTimeVC, animated: true)
        
    }
    
    
    @objc func setTime1(){
        
        print("set1")
        goTimer()
        
    }
    
    @objc func setTime2(){
        
        print("set2")
        
    }
    
    @objc func setTime3(){
        
        print("set3")
        
    }

    
    @objc func start(time:TimeCount){
        
        print("start")
        
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePer1Second), userInfo: nil, repeats: true)

        
    }
    
    @objc func stop(){
        
        print("stop")
        
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        
        let setTimeVC = storyboard?.instantiateViewController(withIdentifier: "setTime")  as! SetTimerViewController
       //画面遷移
       navigationController?.pushViewController(setTimeVC, animated: true)

        
    }
    
    //タイマー更新(1秒ごと)
    @objc func updatePer1Second(){
        
        //60秒以内ならカウント
        if tc.second < 60{

            tc.second += 1

          }
        
        //60秒に到達したら,秒(s)をリセット, 分(m)をプラス1
        if tc.second == 5 {
              print("!!!!!!!!!!!")
            tc.second = 0
            tc.minitue += 1
            //sound()

          }

        print("\(tc.minitue): \(tc.second)")
        timeLabel.text = "\(tc.minitue):\(tc.second)"

      }
    
    
    func sound(){
        
        soundFile.playSound(filename: "bellSound", extensionName: "mp3", numberOfLoops: 1)
        
//        if {
//            print(1)
//
//            soundFile.playSound(filename: "bellSound", extensionName: "mp3", numberOfLoops: bellcount - 1)
//
//        } else {
//
//            soundFile.playSound(filename: "cutBellSound", extensionName: "mp3", numberOfLoops: bellcount - 1)
//
//        }
//
    }
    

    

}
