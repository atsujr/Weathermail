//
//  SettingViewController.swift
//  Weathermail
//
//  Created by Atsuhiro Muroyama on 2022/05/22.
//

import UIKit
import os

class SettingViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    //ここから下の４つの関数は、UIPickerViewDelegate, UIPickerViewDataSourceというこの２つのプロトコルの内部に宣言されている(しかもoptionalじゃない４つ)から、絶対書かないといけない。書かないとエラー吐く。
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 要素の数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    //スクロールするところに出てくる、要素の表示方法
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
        
    }
    
    //現在表示されているpickerの中身と一致するものを、textfieldにぶち込む
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placeText = dataList[row]
        placeTextField.text = placeText
    }
    
    //textFieldの宣言
    @IBOutlet  var placeTextField: CustomTextField!
    @IBOutlet  var timeTextField: CustomTextField!
    
    //userdefaultsに入れる用の変数を2つ宣言しておく。
    var placeText: String!
    var timeText: String!
    
    //通知を希望するかしないかのための変数
    var wantMail: Bool! = true
    
    //userdefaultsを宣言する
    let userDefaults = UserDefaults.standard
    
    let now = NSDate()
    //switchの動作決定
    @IBAction func mailUISwitch(sender: UISwitch) {
        if ( sender.isOn ) {
            timeTextField.isHidden = false
            wantMail = true
            
        } else {
            timeTextField.isHidden = true
            wantMail = false
        }
    }
    
    //saveボタンを押したら、usserdefaulltsに値を入れる。
    @IBAction func savePlaceAndTime() {
        didSaveAlert()
    }
    
    //戻るボタンを押したとき
    @IBAction func backHomeView() {
        didBackAlert()
    }
    //インスタンスを作成
    let todofukenPickerView = UIPickerView(frame: .zero)
    let timePickerView = UIPickerView(frame: .zero)
    
    //通知リクエストを作成
    var request:UNNotificationRequest!
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
        timePicker.date = now as Date
        //Userdefaultsに初期値を代入
        userDefaults.register(defaults: ["place" : "北海道", "time" : "0:00"])
        //最初に、textfieldに入れる値を決定する。
        placeTextField.text = (UserDefaults.standard.object(forKey: "place") as? String)
        timeTextField.text = (UserDefaults.standard.object(forKey: "time") as? String)
        //準備する関数
        setupWeatherPicker()
        setupTimePicker()
        
    }
    
    func setupWeatherPicker() {
        todofukenPickerView.delegate = self
        todofukenPickerView.dataSource = self
        //ここから５行は、Pickerの上のtoolbarに関する説明
        let toolbar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(tappedPlaceDone))
        toolbar.items = [space, doneButton]
        toolbar.sizeToFit()
        
        //したから出てくるのを、pickerに指定(これを書かないと、キーボードがそのままでてくる！)
        placeTextField.inputView = todofukenPickerView
        //toolbarを、pickerの上に配置
        placeTextField.inputAccessoryView = toolbar
    }
    
    @objc func tappedPlaceDone() {
        //doneを押したときに、閉めることができるメソッド
        placeTextField.resignFirstResponder()
        
    }
    
    func setupTimePicker(){
        timePickerView.dataSource = self
        
        timePickerView.delegate = self
        //したから出てくるのを、pickerに指定(これを書かないと、キーボードがそのままでてくる！)
        timeTextField.inputView = timePicker
        //車輪型を選択する。他にも色々デザインは選択できる。詳しくは、optionキーを押して、書類を確認せよ。
        timePicker.preferredDatePickerStyle = .wheels
        //ここから５行は、Pickerの上のtoolbarに関する説明
        let toolbar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(tappedTimeDone))
        toolbar.items = [space, doneButton]
        toolbar.sizeToFit()
        //toolbarを、pickerの上に配置
        timeTextField.inputAccessoryView = toolbar
    }
    
    @objc func tappedTimeDone() {
        //doneを押したときに、閉めることができるメソッド
        timeTextField.resignFirstResponder()
        
    }
    
    //UIDatePickerをインスタンス化
    let timePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = UIDatePicker.Mode.time
        dp.timeZone = NSTimeZone.local
        //時間をJapaneseに変更
        dp.locale = Locale.init(identifier: "Japanese")
        dp.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        //最小単位（分）を設定
        dp.minuteInterval = 1
        return dp
    }()
    
    @objc func changeDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        timeText = "\(formatter.string(from: timePicker.date))"
        timeTextField.text = timeText
        print("🍌")
    }
    
    func didSaveAlert(){
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定
        let alert = UIAlertController(title: "保存", message: "保存しますか？", preferredStyle: .alert)
        
        // OKボタン
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            //通知を希望するかどうかで保存するものが変わる。
            if (self.wantMail) {
                //userdefaultsに、場所と時間をセットする。
                self.userDefaults.set(self.placeText, forKey: "place")
                self.userDefaults.set(self.timeText, forKey: "time")
                
                //通知機能を準備するための関数
                self.setMail(self.timeText)
                
                // 通知リクエストの登録
                let center = UNUserNotificationCenter.current()
                center.add(self.request)
                
            } else {
                self.userDefaults.set(self.placeText, forKey: "place")
            }
            //一個前の画面に戻る。
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        
        // キャンセルボタン
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
            //self.dismiss(animated: true, completion: nil)
            print("🍫")
        }
        alert.addAction(cancel)
        
        // Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    func didBackAlert(){
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定
        let alert = UIAlertController(title: "データをまだ保存してません", message: "本当に戻りますか？", preferredStyle: .alert)
        
        // OKボタン
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            //一個前の画面に戻る。
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        
        // キャンセルボタン
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
            //self.dismiss(animated: true, completion: nil)
            print("🍫")
        }
        alert.addAction(cancel)
        
        // Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    func setMail(_ timeOfMail: String){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ja_JP")
 
        
        let date2 = DateFormatter.HHmm.date(from: timeOfMail)!
        let targetDate = Calendar.current.dateComponents(
            [.hour, .minute],
            from: date2)
 
        let dateString = dateFormatter.string(from: date2)
        print(dateString)
 
        // トリガーの作成
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: targetDate, repeats: false)
 
        // 通知コンテンツの作成
        let content = UNMutableNotificationContent()
        content.title = "Calendar Notification"
        content.body = "お腹すいた,,,"
        content.sound = UNNotificationSound.default
 
        // 通知リクエストの作成
        request = UNNotificationRequest.init(
                identifier: "CalendarNotification",
                content: content,
                trigger: trigger)
    }
    
}
extension DateFormatter {
    static var HHmm: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }
}
