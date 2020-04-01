//
//  bellViewController.swift
//  BellApp
//
//  Created by 境将輝 on 2020/03/02.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit

class bellViewController: UIViewController, UINavigationControllerDelegate, setTimeProtocol {
    

    var delegate:saveBellProtocol?
    
    var numberOfRing = Int()
    
    //メモ削除ボタン
    var trashBarButtonItem: UIBarButtonItem!
    
    var alertController: UIAlertController!
    
    var isDelete = Bool()

    

    //ベルがなる時間を持つオブジェクト
    var bell = Bell()
    
    //ベルオブジェクト辞書を格納する配列
    var bellDictArray = [Dictionary<Int, String>]()
    
    var bellDict: Dictionary<String, String> = [:]
    
    //テーブルの中での順番
    var bellNumber = Int()

    //タイマー（時間表示用）
    let timeLabel = UILabel()
    
    //スタート/ストップボタン, リセットボタン
    let startStopButton = UIButton()
    let stopButton = UIButton()
    let resetButton = UIButton()
    
    //ボタンに使う画像
    let startImage:UIImage = UIImage(named: "start")!
    let stopImage:UIImage = UIImage(named: "stop")!
    let resetImage:UIImage = UIImage(named: "reset")!
    
    var startFlag = false
    
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
    
    //サウンド関連
    var soundFile = SoundFile()
    var withoutMP3 = WithoutMP3()
    
    //タイマークラス
    var timer:Timer?
    
    //タイマーが起動しているかどうかのフラグ
    var timerFlag = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self
        
        trashBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashBarButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [trashBarButtonItem]
        
        
        countTime = TimeCount()
        
            //timeラベル設定
            timeLabel.frame = CGRect(x: view.frame.size.width/4, y: view.frame.size.height/7, width: view.frame.size.width/2, height: view.frame.size.height/5) // 位置とサイズの指定
            timeLabel.textAlignment = NSTextAlignment.center // 横揃えの設定
            timeLabel.text = "\(countTime.minitue):\(countTime.second)" // テキストの設定
            timeLabel.backgroundColor = .green
            timeLabel.textColor = UIColor.black // テキストカラーの設定
            timeLabel.font = UIFont(name: "HiraKakuProN-W6", size: 47) // フォントの設定
            
            
            //ボタン:位置・大きさ設定, 画像をセット
            startStopButton.frame = CGRect(x: view.frame.size.width/7.2, y: view.frame.size.height/1.15 , width: 80, height: 80)
            startStopButton.setImage(startImage, for: .normal)
            stopButton.frame = CGRect(x: view.frame.size.width/7.2, y: view.frame.size.height/1.15 , width: 80, height: 80)
            stopButton.setImage(stopImage, for: .normal)
            resetButton.frame = CGRect(x: view.frame.size.width/1.5, y: view.frame.size.height/1.15, width: 80, height: 80)
            resetButton.setImage(resetImage, for: .normal)
            
            //スタート・ストップボタンアクション定義
            startStopButton.addTarget(self, action: #selector(start), for: .touchUpInside)
            //startStopButton.addTarget(self, action: #selector(stop), for: .touchUpInside)
            stopButton.addTarget(self, action: #selector(stop), for: .touchUpInside)
            resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
            
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
            setTime1Button.setTitle(bellDict["1"], for: .normal)
            setTime1Button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            setTime1Button.setTitleColor(.green, for: .normal)
            setTime2Button.frame = CGRect(x: view.frame.size.width/2, y: view.frame.size.height/2 + 40, width: 80, height: 50)
            setTime2Button.setTitle(bellDict["2"], for: .normal)
            setTime2Button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            setTime2Button.setTitleColor(.red, for: .normal)
            setTime3Button.frame = CGRect(x: view.frame.size.width/2, y: view.frame.size.height/2 + 75, width: 80, height: 50)
            setTime3Button.setTitle(bellDict["3"], for: .normal)
            setTime3Button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            setTime3Button.setTitleColor(.purple, for: .normal)
            
            
            //設定時間ボタンアクション定義
            setTime1Button.addTarget(self, action: #selector(setTime1), for: .touchUpInside)
            setTime2Button.addTarget(self, action: #selector(setTime2), for: .touchUpInside)
            setTime3Button.addTarget(self, action: #selector(setTime3), for: .touchUpInside)
            
            
            self.view.addSubview(timeLabel)
            self.view.addSubview(startStopButton)
            self.view.addSubview(resetButton)
            self.view.addSubview(bellImageView1)
            self.view.addSubview(bellImageView2)
            self.view.addSubview(bellImageView3)
            self.view.addSubview(x2Label)
            self.view.addSubview(x3Label)
            self.view.addSubview(setTime1Button)
            self.view.addSubview(setTime2Button)
            self.view.addSubview(setTime3Button)
    }
    
    //スリープしないようにする
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      UIApplication.shared.isIdleTimerDisabled = true  // この行
    }
    
    //ベル削除ボタン
    @objc func trashBarButtonTapped(_ sender: UIBarButtonItem) {
        print("trashボタンが押された!")
        //self.dismiss(animated: true, completion: nil)
        alert(title: "設定削除", message: "設定を削除しますか？")
    }
    
    func alert(title:String, message:String) {
      alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler:{
          (action: UIAlertAction!) in
          //OKが押された時の処理
          print("OK was pushed\n")
          self.isDelete = true
          
          //前の画面に戻る処理
          self.navigationController?.popViewController(animated: true)
  
          
      })
      let ngAction = UIAlertAction(title: "NG", style: .destructive, handler: {
          (action: UIAlertAction!) in
          //NGが押された時の処理
          print("NG was pushed\n")
      })
      
      
      alertController.addAction(okAction)
      alertController.addAction(ngAction)
      
        present(alertController, animated: true)
    }
    
    
    //前の画面に戻るとき,textviewの中身をメモに格納
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print("--bellVC--")
        print(viewController)
        //前の画面に戻るとき
        if viewController is ViewController {
            print("bellVCから戻るよ")
            
            //タイマーを止める
            self.timer?.invalidate()
            timerFlag = 0
            
            //中身を空にする
            if isDelete == true{
                bellDict["1"] = "0:00"
                bellDict["2"] = "0:00"
                bellDict["3"] = "0:00"
            }
            
            //bellDictArray[bellNumber] = bell.bellConfigueDict
            print(bellDict)
            UserDefaults.standard.set(bellDict, forKey: "bellDict\(bellNumber)")
            delegate?.updateBellTime()
            
        }
    }
    
    
    //セット画面から戻った時に呼ばれるdelegateメソッド
    func setTimerConfigue(numberOfRing:Int, Value:String){
        print("setTimerConfigue!!!")
        print(numberOfRing, Value)
        
        switch numberOfRing {
        case 1:
//            setTime1Button.setTitle("\(Value.minitue):\(Value.second)", for: .normal)
            setTime1Button.setTitle(Value, for: .normal)
            bell.setConfifueDict(numberOfRing: 1, Value: Value)
            bellDict["1"] = bell.bellConfigueDict["1"]
        case 2:
//            setTime2Button.setTitle("\(Value.minitue):\(Value.second)", for: .normal)
            setTime2Button.setTitle(Value, for: .normal)
            bell.setConfifueDict(numberOfRing: 2, Value: Value)
            bellDict["2"] = bell.bellConfigueDict["2"]
        case 3:
//            setTime3Button.setTitle("\(Value.minitue):\(Value.second)", for: .normal)
            setTime3Button.setTitle(Value, for: .normal)
            bell.setConfifueDict(numberOfRing: 3, Value: Value)
            bellDict["3"] = bell.bellConfigueDict["3"]
        default:
            print("KeyError")
            print(numberOfRing)
        }
        
        print("bell", bellDict)
        //bellDict = bell.bellConfigueDict
        //print(bell.bellConfigueDict[1]!.minitue, bell.bellConfigueDict[1]!.second)
        
        
    }
    
    //設定した時間に達したらベルを鳴らす
    func ringTheBell(numberOfRing:Int, bellobject:Dictionary<String, String>){
        
        let min = Int(bellobject[String(numberOfRing)]!.components(separatedBy: ":")[0])
        let sec = Int(bellobject[String(numberOfRing)]!.components(separatedBy: ":")[1])
        //print(countTime.second, sec)
        if countTime.minitue == min && countTime.second == sec {

            print("bellが\(numberOfRing)回鳴るよ！！")
            sound(numberOfRing: numberOfRing)
        }
        
    }
    
    
    func sound(numberOfRing:Int){
        print("--sound--")
        if numberOfRing == 1{
            soundFile.playSound(filename: "bellSound", extensionName: "mp3", numberOfLoops: numberOfRing - 1)
        
        } else {
            
            soundFile.playSound(filename: "cutBellSound", extensionName: "mp3", numberOfLoops: numberOfRing - 1)
            
        }
    
    }
    

    //タイマー更新(1秒ごと)
    @objc func updatePer1Second(_ sender: Timer){
        let b = sender.userInfo as! Bell
        //print(b.bellConfigueDict[1]!.minitue, b.bellConfigueDict[1]!.second)
        
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
        
        
        ringTheBell(numberOfRing: 1, bellobject: bellDict)
        ringTheBell(numberOfRing: 2, bellobject: bellDict)
        ringTheBell(numberOfRing: 3, bellobject: bellDict)
    }
    
    
    //タイマー設定画面に遷移
    func goTimer(numberOfRing:Int){
        
//        let setTimeVC = storyboard?.instantiateViewController(withIdentifier: "setTime")  as! SetTimerViewController
//        setTimeVC.delegate = self
//        setTimeVC.numberOfRing = numberOfRing
        
        //画面遷移
        performSegue(withIdentifier: "setTime", sender: nil)
        //navigationController?.pushViewController(setTimeVC, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue")
        let setTimeVC = segue.destination as! SetTimerViewController
        
        setTimeVC.delegate = self
        setTimeVC.numberOfRing = numberOfRing

        
    }
    
    
    @objc func start(time:TimeCount){
        
        if timerFlag == 0{
            print("start")
            
//            startButton.isEnabled = false
//            stopButton.isEnabled = true
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePer1Second), userInfo: bell, repeats: true)
            timerFlag = 1
            //startStopButton.setImage(stopImage, for: .normal)
            startStopButton.removeFromSuperview()
            self.view.addSubview(stopButton)
        }
    }
    
    
    @objc func stop(){
        
        if timerFlag == 1 {
            print("stop")
            
//            startButton.isEnabled = true
//            stopButton.isEnabled = false
            
            //タイマーオブジェクトを破棄
            self.timer?.invalidate()
            timerFlag = 0
            //startStopButton.setImage(startImage, for: .normal)
            stopButton.removeFromSuperview()
            self.view.addSubview(startStopButton)
            
        }
    }
    
    @objc func reset(){
        
        //タイマーオブジェクトを破棄
        self.timer?.invalidate()
        timerFlag = 0
        stopButton.removeFromSuperview()
        self.view.addSubview(startStopButton)
        
        
        countTime.second = 0
        countTime.minitue = 0
        
        timeLabel.text = "\(countTime.minitue):\(countTime.second)"
        
        
        
    }

    
    @objc func setTime1(){
        
        print("set1")
        numberOfRing = 1
        goTimer(numberOfRing:1)
        //タイマーオブジェクトを破棄
        self.timer?.invalidate()
        timerFlag = 0
        
    }
    
    @objc func setTime2(){
        
        print("set2")
        numberOfRing = 2
        goTimer(numberOfRing:2)
        //タイマーオブジェクトを破棄
        self.timer?.invalidate()
        timerFlag = 0
        
    }
    
    @objc func setTime3(){
        
        print("set3")
        numberOfRing = 3
        goTimer(numberOfRing:3)
        //タイマーオブジェクトを破棄
        self.timer?.invalidate()
        timerFlag = 0
    }
    
    

}

//    //秒が0の時, "X:0"となるため, "X:00"と表示させる関数
//    func modifyZero(timeValue:String, buttonNum:Int){
//        print("--modifyZero--")
//        let min = timeValue.components(separatedBy: ":")[0]
//        let sec = timeValue.components(separatedBy: ":")[1]
//
//        if sec == "0"{
//            print("sec == 0")
//
//            switch buttonNum{
//            case 1:
//                setTime1Button.setTitle("\(min):00", for: .normal)
//            case 2:
//                setTime2Button.setTitle("\(min):00", for: .normal)
//            case 3:
//                setTime3Button.setTitle("\(min):00", for: .normal)
//            default:
//                print("error")
//            }
//
//        } else {
//
//            switch buttonNum{
//            case 1:
//                setTime1Button.setTitle(timeValue, for: .normal)
//            case 2:
//                setTime2Button.setTitle(timeValue, for: .normal)
//            case 3:
//                setTime3Button.setTitle(timeValue, for: .normal)
//            default:
//                print("error")
//            }
//        }
//
//    }
