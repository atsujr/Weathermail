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
    let saveData = UserDefaults.standard
    //ここから下は天気の情報をネットから持ってくる関数。
    //    var citytag :String!
    //    var descriptWeather: String? = "何で？"
    //    var maxTemp: String?
    //    var minTemp: String?
    var chanceOfRain0to6: String? = "チョコレイトディスコ"
    var chanceOfRain6to12: String?
    var chanceOfRain12to18: String?
    var chanceOfRain18to24: String?
    var wind: String?
    
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
        //https://api.openweathermap.org/data/2.5/weather?id=1859171&APPID=6c102866d28a640de6c8ef3028a90ed9
        //としの番号で指定したURL
        let text = "https://weather.tsukumijima.net/api/forecast/city/\(citytag)"
        
        //これで、リクエストで使うことができるURLができた
        let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //Alamofireで通信。データを取得。
        AF.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                //jsonを取得します。
                let json = JSON(response.data as Any)
                //                self.descriptWeather = json["forecasts"][0]["telop"].string!
                //                print("🍊")
                //                print(self.descriptWeather)
                //                print("🍊")
                //                self.maxTemp = json["forecasts"][0]["temperature"]["min"]["celsius"].string
                //                self.maxTemp = json["forecasts"][0]["temperature"]["max"]["celsius"].string
                //                //上記の2つは、strinで値を返しているから、optionaol()か、nilが入る。後々アンラップしないと,,,
                //しかも、なぜかは知らないが、最低気温か最高気温が取得できない場合がある。(正確にはnullだったりする。)
                //   print("😡")
                self.chanceOfRain0to6 = json["forecasts"][0]["chanceOfRain"]["T00_06"].string
                //   print("😡")
                self.chanceOfRain6to12 = json["forecasts"][0]["chanceOfRain"]["T06_12"].string
                self.chanceOfRain12to18 = json["forecasts"][0]["chanceOfRain"]["T12_18"].string
                self.chanceOfRain18to24 = json["forecasts"][0]["chanceOfRain"]["T18_24"].string
                //上記の戻り値は、10%,0%,100%,__%とかいうふざけたstringのこともあるから、後々stringを分割して、ifで場合分けしてからintに変換する！
                //self.wind = json["forecasts"][0]["detail"]["wind"].string
                
                
                
                //取得したjsonから、必要なデータを取り出します。
                
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBAction func button1(){
        //yoho("280010")
       // print(chanceOfRain0to6)
    }
//    @IBAction func test(){
//    }
//
    
    @IBAction func checkWeatherView(){
        print(saveData.string(forKey: "place"))
        print("🍊")
        print(chanceOfRain0to6)
        let saveData = UserDefaults.standard
        if (saveData.string(forKey: "place") != nil) {
            performSegue(withIdentifier: "toWeatherView", sender: nil)
        }else{
            let alert = UIAlertController(
                title: "県の指定",
                message: "まずは設定から情報を取得したい県を選択してください。",
                preferredStyle: .alert
            )
            /*
             上記のクラスは、UIkitの中に宣言されているクラス、このクラスをもとにインスタンスを作成できるようにしているって考えると楽!!
             init(これをイニシャライザと呼ぶ)を用いて、初期値を設定している！！
             
             */
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            ))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) { // 戻ってきた時に実行されます
        super.viewWillAppear(animated)
        setApi()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setApi()
    }
    func setApi(){
        if (saveData.string(forKey: "place") != nil) {
            let getApi = GetWeathreApi()
            let getPlaceFromUserdefaults: String! = saveData.string(forKey: "place")
            let getPlace: String! = String(getApi.retCityTag(getPlaceFromUserdefaults))
            
            yoho(getPlace)
        }
    }
    
    
    
}
