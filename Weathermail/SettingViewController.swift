//
//  SettingViewController.swift
//  Weathermail
//
//  Created by Atsuhiro Muroyama on 2022/05/22.
//

import UIKit

class SettingViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //要素の数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    //スクロールするところに出てくる、要素の表示方法
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    //現在表示されているpickerの中身と一致するものを、textfieldにぶち込む
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placeTextField.text = dataList[row]
    }
    
    @IBOutlet weak private var placeTextField: UITextField!
    @IBOutlet weak private var timeTextField: UITextField!
    //インスタンスを作成
    @IBAction func mailUISwitch(sender: UISwitch) {
        if ( sender.isOn ) {
            timeTextField.isHidden = false
         } else {
             timeTextField.isHidden = true
         }
     }
    
    let todofukenPickerView = UIPickerView(frame: .zero)
    let timePickerView = UIPickerView(frame: .zero)
    //47都道府県を入れた配列を用意
    //https://weather.tsukumijima.net/primary_area.xml
    private let dataList = ["北海道", "青森県", "岩手県", "宮城県", "秋田県",
                            "山形県", "福島県", "茨城県", "栃木県", "群馬県",
                            "埼玉県", "千葉県", "東京都", "神奈川県","新潟県",
                            "富山県", "石川県", "福井県", "山梨県", "長野県",
                            "岐阜県", "静岡県", "愛知県", "三重県", "滋賀県",
                            "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県",
                            "鳥取県", "島根県", "岡山県", "広島県", "山口県",
                            "徳島県", "香川県", "愛媛県", "高知県", "福岡県",
                            "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県",
                            "鹿児島県", "沖縄県"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //最初に、textfieldに入れる値を決定する。
        placeTextField.text = "東京都"
        //準備する関数
        setupWeatherPicker()
       setupTimePicker()
        
//
       // var setTime = SetTimeViewController()
      //  setTime.setupTimepicker()
    }
    
    func setupWeatherPicker() {
        todofukenPickerView.delegate = self
        todofukenPickerView.dataSource = self
        //ここから５行は、Pickerの上のtoolbarに関する説明
        let toolbar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(tappedDone))
        toolbar.items = [space, doneButton]
        toolbar.sizeToFit()
        
        //したから出てくるのを、pickerに指定(これを書かないと、キーボードがそのままでてくる！)
        placeTextField.inputView = todofukenPickerView
        //toolbarを、pickerの上に配置
        placeTextField.inputAccessoryView = toolbar
    }
    
    
    @objc func tappedDone() {
        //doneを押したときに、閉めることができるメソッド
        placeTextField.resignFirstResponder()
        
    }
    func setupTimePicker(){
        timePickerView.dataSource = self
        
        timePickerView.delegate = self
        //したから出てくるのを、pickerに指定(これを書かないと、キーボードがそのままでてくる！)
        timeTextField.inputView = timePicker
        //ここから５行は、Pickerの上のtoolbarに関する説明
        let toolbar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(tappedDone))
        toolbar.items = [space, doneButton]
        toolbar.sizeToFit()
        //toolbarを、pickerの上に配置
        timeTextField.inputAccessoryView = toolbar
    }
    //UIDatePickerをインスタンス化
     let timePicker: UIDatePicker = {
         let dp = UIDatePicker()
        dp.datePickerMode = UIDatePicker.Mode.time
         
         //おそらく上記のところ
         dp.timeZone = NSTimeZone.local
         //時間をJapanese(24時間表記)に変更
         dp.locale = Locale.init(identifier: "Japanese")
         dp.addTarget(SettingViewController.self, action: #selector(dateChange), for: .valueChanged)
         //最小単位（分）を設定
         dp.minuteInterval = 10
         return dp
     }()
     @objc func dateChange(){
         let formatter = DateFormatter()
         formatter.dateFormat = "hh:mm"
         timeTextField.text = "\(formatter.string(from: timePicker.date))"
//     }
    
    //ここから下の４つの関数は、UIPickerViewDelegate, UIPickerViewDataSourceというこの２つのプロトコルの内部に宣言されている(しかもoptionalじゃない４つ)から、絶対書かないといけない。書かないとエラー吐く。
    
    
    //スクロールバーの数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //要素の数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    //スクロールするところに出てくる、要素の表示方法
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    //現在表示されているpickerの中身と一致するものを、textfieldにぶち込む
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placeTextField.text = dataList[row]
    }
    
}
}
