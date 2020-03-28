//
//  SetTimerViewController.swift
//  BellApp
//
//  Created by 境将輝 on 2020/03/03.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit

protocol setTimeProtocol {
    
    func setTimerConfigue(numberOfRing:Int, Value:String)
    
}

class SetTimerViewController: UIViewController, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    
    //ピッカービュー表示用オブジェクト
      var Time = SetTime()
    
    //時間を設定する際のpickerView
    @IBOutlet weak var secondPickerView: UIPickerView!
    @IBOutlet weak var minituePickerView: UIPickerView!
    
    //設定画面のタイトル(ベルを鳴らす回数)
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    var tc = TimeCount()

    
    
    var delegate:setTimeProtocol?
    
    //ベルを鳴らす回数
    var numberOfRing = Int()
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("set\(numberOfRing)から呼ばれたよ！！")
        
        //view.backgroundColor = .black
        // PickerView のサイズと位置
        secondPickerView.frame = CGRect(x: 0, y: view.frame.height/4, width: view.frame.width/2, height: 250)
        secondPickerView.backgroundColor = UIColor(red: 0.69, green: 0.93, blue: 0.9, alpha: 1.0)
        
        minituePickerView.frame = CGRect(x: view.frame.width/2, y: view.frame.height/4, width: view.frame.width/2, height: 250)
        minituePickerView.backgroundColor = UIColor(red: 0.69, green: 0.93, blue: 0.9, alpha: 1.0)
        
        //タグ設定
        minituePickerView.tag = 0
        secondPickerView.tag = 1
        
        // Delegate設定
        secondPickerView.delegate = self
        secondPickerView.dataSource = self
        minituePickerView.delegate = self
        minituePickerView.dataSource = self
        
        navigationController?.delegate = self
        
        titleLabel.text = "ベルを鳴らす回数: \(numberOfRing)"
    


    }
    
   // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return Time.secondList.count
        case 1:
            return Time.minitueList.count
        default:
            return 0
        }
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        switch pickerView.tag {
       case 0:
        tc.second = Int(Time.secondList[row])!
        return Time.secondList[row]
       case 1:
        tc.minitue = Int(Time.minitueList[row])!
        return Time.minitueList[row]
       default:
           return "error"
        }
        
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        switch pickerView.tag {
           case 0:
            tc.second = Int(Time.secondList[row])!
            //print(Time.secondList[row])
           case 1:
            tc.minitue = Int(Time.minitueList[row])!
            //print(Time.minitueList[row])
           default:
            print("error")
        }
        
        
    }
    
    
    //時間設定, 画面遷移
    @IBAction func doneAction(_ sender: Any) {
        print("setTimerから戻るよ!! from doneAction")
        
        var timeString:String!
        
        print(tc.minitue, tc.second)
        
        //秒が0の時, "X:0"となるため, "X:00"と表示させる
        if tc.second == 0{
            timeString = String(tc.minitue) + ":" + "00"
        } else {
            timeString = String(tc.minitue) + ":" + String(tc.second)
        }
        
        
        //このタイミングでdelegateメソッドを使う
        delegate?.setTimerConfigue(numberOfRing:numberOfRing, Value:timeString)
        
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
}

