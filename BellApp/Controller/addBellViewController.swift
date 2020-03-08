//
//  addBellViewController.swift
//  BellApp
//
//  Created by 境将輝 on 2020/03/02.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit

class addBellViewController: UIViewController, UINavigationControllerDelegate, setTimeProtocol {
    
    //ベルがなる時間を持つオブジェクト
    var bell = Bell()
    
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
    
    //タイマーオブジェクト(ラベルでカウント)
    var countTime = TimeCount()
    
    var tc = TimeCount()
    
    //各セット時間(ベルが鳴る回数毎)のオブジェクト
    var Time1 = TimeCount()
    var Time2 = TimeCount()
    var Time3 = TimeCount()
    
    //サウンド関連
    var soundFile = SoundFile()
    var withoutMP3 = WithoutMP3()
    
    //タイマークラス
    var timer:Timer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        countTime = TimeCount()
    
        
        self.view.backgroundColor = .white

        
        //timeラベル設定
        timeLabel.frame = CGRect(x: view.frame.size.width/4, y: view.frame.size.height/7, width: view.frame.size.width/2, height: view.frame.size.height/5) // 位置とサイズの指定
        timeLabel.textAlignment = NSTextAlignment.center // 横揃えの設定
        timeLabel.text = "\(countTime.minitue):\(countTime.second)" // テキストの設定
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
        bellImageView1.frame = CGRect(x: view.frame.size.width/3, y: view.frame.size.height/2 + 10, width: 30, height: 30)
        bellImageView2.image = UIImage(named: "bell")
        bellImageView2.frame = CGRect(x: view.frame.size.width/3, y: view.frame.size.height/2 + 45, width: 30, height: 30)
        bellImageView3.image = UIImage(named: "bell")
        bellImageView3.frame = CGRect(x: view.frame.size.width/3, y: view.frame.size.height/2 + 80, width: 30, height: 30)
        
        //x2, x3ラベル設定
        x2Label.frame = CGRect(x: view.frame.size.width/3 + 30, y: view.frame.size.height/2 + 50, width: 30, height: 30)
        x2Label.text = "x2"
        x2Label.textColor = .black
        x3Label.frame = CGRect(x: view.frame.size.width/3 + 30, y: view.frame.size.height/2 + 85, width: 30, height: 30)
        x3Label.text = "x3"
        x3Label.textColor = .black
        
        
        //設定時間ボタンの設定
        setTime1Button.frame = CGRect(x: view.frame.size.width/2, y: view.frame.size.height/2, width: 80, height: 50)
        setTime1Button.setTitle("0:00", for: .normal)
        setTime1Button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        setTime1Button.setTitleColor(.green, for: .normal)
        setTime2Button.frame = CGRect(x: view.frame.size.width/2, y: view.frame.size.height/2 + 40, width: 80, height: 50)
        setTime2Button.setTitle("0:00", for: .normal)
        setTime2Button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        setTime2Button.setTitleColor(.red, for: .normal)
        setTime3Button.frame = CGRect(x: view.frame.size.width/2, y: view.frame.size.height/2 + 75, width: 80, height: 50)
        setTime3Button.setTitle("0:00", for: .normal)
        setTime3Button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
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
    
    
    @objc func setTime1(){
        
        print("set1")
        goTimer(numberOfRing:1)
        
    }
    
    @objc func setTime2(){
        
        print("set2")
        goTimer(numberOfRing:2)
        
    }
    
    @objc func setTime3(){
        
        print("set3")
        goTimer(numberOfRing:3)
        
    }

    
    @objc func start(time:TimeCount){
        
        print("start")
        
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePer1Second), userInfo: bell, repeats: true)

        
    }
    
    @objc func stop(){
        
        print("stop")
        
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        //タイマーオブジェクトを破棄
        self.timer?.invalidate()

        
    }
    
    //タイマー更新(1秒ごと)
    @objc func updatePer1Second(_ sender: Timer){
        let b = sender.userInfo as! Bell
        print(b.bellConfigueDict[1]!.minitue, b.bellConfigueDict[1]!.second)
        
        //60秒以内ならカウント
        if countTime.second < 60{

            countTime.second += 1

          }
        
        //60秒に到達したら,秒(s)をリセット, 分(m)をプラス1
        if countTime.second == 60 {
              print("!!!!!!!!!!!")
            countTime.second = 0
            countTime.minitue += 1
            //sound()

          }

        print("\(countTime.minitue): \(countTime.second)")
        timeLabel.text = "\(countTime.minitue):\(countTime.second)"
        
        
        checkRingBell(numberOfRing: 1, bellobject: b)
        checkRingBell(numberOfRing: 2, bellobject: b)
        checkRingBell(numberOfRing: 3, bellobject: b)
    }
    
    //設定した時間に達したらベルを鳴らす
    func checkRingBell(numberOfRing:Int, bellobject:Bell){
        
        if countTime.minitue == bellobject.bellConfigueDict[numberOfRing]!.minitue && countTime.second == bellobject.bellConfigueDict[numberOfRing]!.second{
            
            print("bellが\(numberOfRing)回鳴るよ！！")
            sound(numberOfRing: numberOfRing)
        }
        
    }
    
    func sound(numberOfRing:Int){
        
        if numberOfRing == 1{
            soundFile.playSound(filename: "bellSound", extensionName: "mp3", numberOfLoops: numberOfRing - 1)
        
        } else {
            
            soundFile.playSound(filename: "cutBellSound", extensionName: "mp3", numberOfLoops: numberOfRing - 1)
            
        }
    
    }
    
    
    //セット画面から戻った時に呼ばれるdelegateメソッド
    func setTimerConfigue(numberOfRing:Int, Value:TimeCount){
        print("setTimerConfigue!!!")
        print(numberOfRing, Value.minitue, Value.second)
        
        switch numberOfRing {
        case 1:
            setTime1Button.setTitle("\(Value.minitue):\(Value.second)", for: .normal)
            Time1 = Value
            bell.setConfifueDict(numberOfRing: 1, Value: Value)
        case 2:
            setTime2Button.setTitle("\(Value.minitue):\(Value.second)", for: .normal)
            Time2 = Value
            bell.setConfifueDict(numberOfRing: 2, Value: Value)
        case 3:
            setTime3Button.setTitle("\(Value.minitue):\(Value.second)", for: .normal)
            Time3 = Value
            bell.setConfifueDict(numberOfRing: 3, Value: Value)
        default:
            print("KeyError")
            print(numberOfRing)
        }
        
        print("bell")
        print(bell.bellConfigueDict[1]!.minitue, bell.bellConfigueDict[1]!.second)
        
        
    }
    
    //タイマー設定画面に遷移
    func goTimer(numberOfRing:Int){
        
        let setTimeVC = storyboard?.instantiateViewController(withIdentifier: "setTime")  as! SetTimerViewController
        setTimeVC.delegate = self
        setTimeVC.numberOfRing = numberOfRing
        //画面遷移
        navigationController?.pushViewController(setTimeVC, animated: true)
        
    }

}
