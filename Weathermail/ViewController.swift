//
//  ViewController.swift
//  Weathermail
//
//  Created by Atsuhiro Muroyama on 2022/05/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet var label:UILabel!
    let saveData = UserDefaults.standard

    var chanceOfRain0to6: String!
    var chanceOfRain6to12: String!
    var chanceOfRain12to18: String!
    var chanceOfRain18to24: String!
    var IntOfchanceOfRain0to6: Int = 0
    var IntOfchanceOfRain6to12: Int = 0
    var IntOfchanceOfRain12to18: Int = 0
    var IntOfchanceOfRain18to24: Int = 0
    
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
    func yoho(_ citytag: String) {
        //としの番号で指定したURL
        let text = "https://weather.tsukumijima.net/api/forecast/city/\(citytag)"
        
        //これで、リクエストで使うことができるURLができた
        let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //Alamofireで通信。データを取得。
        AF.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
               
                //jsonを取得
                let json = JSON(response.data as Any)
                self.chanceOfRain0to6 = json["forecasts"][0]["chanceOfRain"]["T00_06"].string
                self.chanceOfRain6to12 = json["forecasts"][0]["chanceOfRain"]["T06_12"].string
                self.chanceOfRain12to18 = json["forecasts"][0]["chanceOfRain"]["T12_18"].string
                self.chanceOfRain18to24 = json["forecasts"][0]["chanceOfRain"]["T18_24"].string
                
                //取得したやつをintに変換
                self.IntOfchanceOfRain0to6 = self.changeStringToInt(self.chanceOfRain0to6!)
                self.IntOfchanceOfRain6to12 = self.changeStringToInt(self.chanceOfRain6to12!)
                self.IntOfchanceOfRain12to18 = self.changeStringToInt(self.chanceOfRain12to18!)
                self.IntOfchanceOfRain18to24 = self.changeStringToInt(self.chanceOfRain18to24!)
                
                //最後にここに画像をセットしてあげれば終わり
                if(self.IntOfchanceOfRain0to6 >= 60 || self.IntOfchanceOfRain6to12 >= 60 || self.IntOfchanceOfRain12to18 >= 60 || self.IntOfchanceOfRain18to24 >= 60){
                    self.label.text = "傘を持って行こう！"
                }else if(self.IntOfchanceOfRain0to6 >= 50 || self.IntOfchanceOfRain6to12 >= 50 || self.IntOfchanceOfRain12to18 >= 50 || self.IntOfchanceOfRain18to24 >= 50){
                    self.label.text = "折り畳み傘をを持って行こう！"
                }else{
                    self.label.text = "今日は傘はいらないよ！！"
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func checkWeatherView(){
//                    let getIndexNum: Int? = saveData.integer(forKey: "numberOfIndex")
//                    print("✋")
//                    print(getIndexNum!)
//                    print("✋")
//                    print(chanceOfRain0to6!)
        if (saveData.string(forKey: "place") != nil) {
            if let controller = self.presentingViewController as? WeatherViewController {
                controller.setApiInWeatherView()
            }
            performSegue(withIdentifier: "toWeatherView", sender: nil)
        }else{
            let alert = UIAlertController(
                title: "県の指定",
                message: "まずは設定から情報を取得したい県を選択してください。",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            ))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    //取得しデータをint型にして送り返してあげてる。
    func changeStringToInt(_ chanceofrain: String) ->Int {
        if(chanceofrain == "--%"){
            return 0
        }
        var array = chanceofrain.components(separatedBy: "%")
        let retNum = Int(array[0])
        return retNum!
    }
    override func viewWillAppear(_ animated: Bool) {
        // 戻ってきた時に
        super.viewWillAppear(animated)
        setApi()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //setApi()
    }
    func setApi(){
        if (saveData.string(forKey: "place") != nil) {
            let getPlaceFromUserdefaults: String! = saveData.string(forKey: "place")
            let getPlace: String! = retCityTag(getPlaceFromUserdefaults)
            let getIndexNum: Int? = saveData.integer(forKey: "numberOfIndex")
            print("✋")
            print(getPlace!)
            print("✋")
            print(getIndexNum!)
            yoho(getPlace)
        }
    }
    func retCityTag(_ todoufuken: String) -> String{
        if(todoufuken == "北海道"){
            return "016010"
        }else  if(todoufuken == "青森県"){
            return "020010"
        }else if(todoufuken == "岩手県"){
            return "030010"
        }else if(todoufuken == "宮城県"){
            return "040010"
        }else if(todoufuken == "秋田県"){
            return "050010"
        }else if(todoufuken == "山形県"){
            return "060010"
        }else if(todoufuken == "福島県"){
            return "070010"
        }else if(todoufuken == "茨城県"){
            return "080010"
        }else if(todoufuken == "栃木県"){
            return "090010"
        }else  if(todoufuken == "群馬県"){
            return "100010"
        }else if(todoufuken == "埼玉県"){
            return "110010"
        }else if(todoufuken == "千葉県"){
            return "130010"
        }else if(todoufuken == "東京都"){
            return "120010"
        }else if(todoufuken == "神奈川県"){
            return "140010"
        }else if(todoufuken == "新潟県"){
            return "150010"
        }else if(todoufuken == "富山県"){
            return "160010"
        }else  if(todoufuken == "石川県"){
            return "170010"
        }else if(todoufuken == "福井県"){
            return "180010"
        }else if(todoufuken == "山梨県"){
            return "190010"
        }else if(todoufuken == "長野県"){
            return "200010"
        }else if(todoufuken == "岐阜県"){
            return "210010"
        }else if(todoufuken == "静岡県"){
            return "220010"
        }else if(todoufuken == "愛知県"){
            return "230010"
        }else  if(todoufuken == "三重県"){
            return "240010"
        }else if(todoufuken == "滋賀県"){
            return "250010"
        }else if(todoufuken == "京都府"){
            return "260010"
        }else if(todoufuken == "大阪府"){
            return "270000"
        }else if(todoufuken == "兵庫県"){
            return "280010"
        }else if(todoufuken == "奈良県"){
            return "290010"
        }else if(todoufuken == "和歌山県"){
            return "300010"
        }else  if(todoufuken == "鳥取県"){
            return "310010"
        }else if(todoufuken == "島根県"){
            return "320010"
        }else if(todoufuken == "岡山県"){
            return "330010"
        }else if(todoufuken == "広島県"){
            return "340010"
        }else if(todoufuken == "山口県"){
            return "350010"
        }else if(todoufuken == "徳島県"){
            return "360010"
        }else if(todoufuken == "香川県"){
            return "370000"
        }else  if(todoufuken == "愛媛県"){
            return "380010"
        }else if(todoufuken == "高知県"){
            return "390010"
        }else if(todoufuken == "福岡県"){
            return "400010"
        }else if(todoufuken == "佐賀県"){
            return "410010"
        }else if(todoufuken == "長崎県"){
            return "420010"
        }else if(todoufuken == "熊本県"){
            return "430010"
        }else if(todoufuken == "大分県"){
            return "440010"
        }else  if(todoufuken == "宮崎県"){
            return "450010"
        }else if(todoufuken == "鹿児島県"){
            return "460010"
        }else if(todoufuken == "沖縄県"){
            return "471010"
        }
        return "0"
    }
    
    
    
}
