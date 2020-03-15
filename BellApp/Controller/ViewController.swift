//
//  ViewController.swift
//  BellApp
//
//  Created by 境将輝 on 2020/03/02.
//  Copyright © 2020 Masaki Sakai. All rights reserved.
//

import UIKit

extension UserDefaults {
       static func contains(_ key: String) -> Bool {
           return UserDefaults.standard.object(forKey: key) != nil
       }
   }

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, saveBellProtocol{
    
   

   
    @IBOutlet weak var tableview: UITableView!
    
    var soundFile = SoundFile()
    var withoutMP3 = WithoutMP3()
    
    var ct = TimeCount()
    
    //ナビゲーションアイテムのプラスボタン宣言
    var addBarButtonItem: UIBarButtonItem!
    
    //ベルオブジェクトを格納する配列
    var bellArray = [Bell]()
    
    //セルの数
    var cellCount = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //UserDefaults.standard.removeObject(forKey: "bellDictCount")
        //UserDefaults.standard.removeObject(forKey: "bellDict")

        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell")
        
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
        addbellVC.delegate = self
        addbellVC.bellNum = cellCount
                          
        //画面遷移
        navigationController?.pushViewController(addbellVC, animated: true)
    }
    
    
    @IBAction func bell(_ sender: Any) {

        //var b = Bell(bellDict: ["1": 1])
        
        
       // soundFile.playSound(filename: "bellSound", extensionName: "mp3", numberOfLoops: 1)

    }
    
    //セルの数を決定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        
        //let count = UserDefaults.standard.object(forKey: "bellDictCount") as! Int
        print(UserDefaults.contains("bellDictCount"))
        if UserDefaults.contains("bellDictCount") == true {
        
            let count = UserDefaults.standard.object(forKey: "bellDictCount") as! Int
            
            //セルの数が1以上あった時
            if count >= 1{
                cellCount = count
                print("count", count)
                
                return count
    //            print("\nメモの数: ", Count)
    //            print(array, "\n")
                
            }
            //セルの数が0の時
            else {
                print("count = nil")
                cellCount = 0
                return 0
            }
        }
            
        //ラベルに現在のメモの数を表示
        //memoCountLabel.text = "現在: " + String(Count)
        return 0
        
    }
    
    //セルの構成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        //セルのハイライトについて
        //cell.selectionStyle = .none
        
        let timeDict = UserDefaults.standard.object(forKey: "bellDict\(indexPath.row)") as! Dictionary<String, String>
        let time1 = timeDict["1"]
        let time2 = timeDict["2"]
        let time3 = timeDict["3"]
        print("time1:", time1)
        print("time2:", time2)
        print("time3:", time3)
        //セルに時間を表示する
        cell.bell1TimeLabel.text = time1
        cell.bell2TimeLabel.text = time2
        cell.bell3TimeLabel.text = time3
        
//        print("---cell:\(String(indexPath.row))---")
//        print(array)
        
        return cell
    }
    
    //セルが選択された時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        //タップした時にメモの中身を渡す
        let bellVC = storyboard?.instantiateViewController(withIdentifier: "bell")  as! bellViewController

        bellVC.delegate = self

        //中身とセルの順番を渡す
        print("\(String(indexPath.row)) is selected")
        let bellDict = UserDefaults.standard.object(forKey: "bellDict\(indexPath.row)") as! Dictionary<String, String>
        print(bellDict)
        
        bellVC.bellDict = bellDict
        bellVC.bellNumber = indexPath.row
        
        //画面遷移
        navigationController?.pushViewController(bellVC, animated: true)
        
    }
    
    //セクションの数を定義
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func updateBellTime() {
        print("updateBellTime")
        tableview.reloadData()
        
    }
    
}

