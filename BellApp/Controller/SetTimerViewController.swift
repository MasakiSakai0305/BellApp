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
    
    
    
    
    var tc = TimeCount()
    
    var delegate:setTimeProtocol?
    
    //ベルを鳴らす回数
    var numberOfRing = Int()
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("set\(numberOfRing)から呼ばれたよ！！")
        
        
        // PickerView のサイズと位置
        secondPickerView.frame = CGRect(x: 0, y: view.frame.height/4, width: view.frame.width/2, height: 300)
        secondPickerView.backgroundColor = UIColor(red: 0.69, green: 0.93, blue: 0.9, alpha: 1.0)
        
        minituePickerView.frame = CGRect(x: view.frame.width/2, y: view.frame.height/4, width: view.frame.width/2, height: 300)
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
    
//    //前の画面に戻るとき,textviewの中身をメモに格納
//    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        print(viewController)
//        print("navigationController from setTimer\n")
//
//        //前の画面に戻るとき
//        if viewController is addBellViewController {
//            print("setTime画面から前の画面に戻るよ!")
//
//            print(tc.minitue, tc.second)
//            let timeString = String(tc.minitue) + String(tc.second)
//
//            //このタイミングでdelegateメソッドを使う
//            delegate?.setTimerConfigue(numberOfRing:numberOfRing, Value:timeString)
//
//        }
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("setTimerから戻るよ!! viewWillDisappear")
        
        print(tc.minitue, tc.second)
        let timeString = String(tc.minitue) + ":" + String(tc.second)

        //このタイミングでdelegateメソッドを使う
        //delegate?.setTimerConfigue(numberOfRing:numberOfRing, Value:timeString)
        
    }
    
    //時間設定, 画面遷移
    @IBAction func doneAction(_ sender: Any) {
        
        print("setTimerから戻るよ!! from doneAction")
        
        print(tc.minitue, tc.second)
        let timeString = String(tc.minitue) + ":" + String(tc.second)

        //このタイミングでdelegateメソッドを使う
        delegate?.setTimerConfigue(numberOfRing:numberOfRing, Value:timeString)
        
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
}

