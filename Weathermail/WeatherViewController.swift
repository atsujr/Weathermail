//
//  WeatherViewController.swift
//  Weathermail
//
//  Created by Atsuhiro Muroyama on 2022/05/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {
    
    @IBOutlet var todofukenlabel: UILabel!
    @IBOutlet var todaysweather: UILabel!
    @IBOutlet var todaysweatherper: UILabel!
    @IBOutlet var todayweatherlabel:UILabel!
    @IBOutlet var maxtemlabel: UILabel!
    @IBOutlet var mintemlabel: UILabel!
    @IBOutlet var rainparcent0to6: UILabel!
    @IBOutlet var rainparcent6to12: UILabel!
    @IBOutlet var rainparcent12to18: UILabel!
    @IBOutlet var rainparcent18to24: UILabel!
    @IBOutlet var todayweatherlabeltitle:UILabel!
    @IBOutlet var maxtemlabeltitle: UILabel!
    @IBOutlet var mintemlabeltitle: UILabel!
    @IBOutlet var rainparcent0to6title: UILabel!
    @IBOutlet var rainparcent6to12title: UILabel!
    @IBOutlet var rainparcent12to18title: UILabel!
    @IBOutlet var rainparcent18to24title: UILabel!
    @IBOutlet var backButtton: UIButton!
    @IBAction func backbutton() {
        self.dismiss(animated: true)
    }
    let saveData = UserDefaults.standard
    func setApiInWeatherView(){
        if (saveData.string(forKey: "place") != nil) {
            let getPlaceFromUserdefaults: String! = saveData.string(forKey: "place")
            let getPlace: String! = retCityTag(getPlaceFromUserdefaults)
            yoho(citytag: getPlace)
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
        }else if(todoufuken == "東京都"){
            return "130010"
        }else if(todoufuken == "千葉県"){
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
    //ここから下は天気の情報をネットから持ってくる関数。
    var citytag :String!
    var todofuken: String?//県
    var descriptWeatheroftoday: String?//天気
    var maxTemp: String?//最高気温
    
    var minTemp: String?//最低気温
    //降水確率
    var chanceOfRain0to6: String!
    var chanceOfRain6to12: String!
    var chanceOfRain12to18: String!
    var chanceOfRain18to24: String!
    
    
    //    init(num: String){
    //        yoho(citytag: num)
    //    }
    
    func yoho(citytag: String) {
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
                self.todofuken = json["location"]["prefecture"].string
                self.descriptWeatheroftoday = json["forecasts"][0]["telop"].string
                self.maxTemp = json["forecasts"][0]["temperature"]["min"]["celsius"].string
                self.minTemp = json["forecasts"][0]["temperature"]["max"]["celsius"].string
                //上記の2つは、strinで値を返しているから、optionaol()か、nilが入る。後々アンラップしないと,,,
                self.chanceOfRain0to6 = json["forecasts"][0]["chanceOfRain"]["T00_06"].string
                self.chanceOfRain6to12 = json["forecasts"][0]["chanceOfRain"]["T06_12"].string
                self.chanceOfRain12to18 = json["forecasts"][0]["chanceOfRain"]["T12_18"].string
                self.chanceOfRain18to24 = json["forecasts"][0]["chanceOfRain"]["T18_24"].string
                //labelにセットしていく
                self.todofukenlabel.text = self.todofuken
                self.todayweatherlabel.text = self.descriptWeatheroftoday
                if(self.maxTemp != nil){
                    self.maxtemlabel.text = self.maxTemp!
                }else{
                    self.maxtemlabel.text = "取得失敗。"
                }
                if(self.minTemp != nil){
                    self.mintemlabel.text = self.minTemp!
                }else{
                    self.mintemlabel.text = "取得失敗。"
                }
                self.rainparcent0to6.text = self.chanceOfRain0to6
                self.rainparcent6to12.text = self.chanceOfRain6to12
                self.rainparcent12to18.text = self.chanceOfRain12to18
                self.rainparcent18to24.text = self.chanceOfRain18to24
                
                
                
                
//                print("🍊")
//                print(self.todofuken!)
//                print(self.descriptWeatheroftoday!)
//                print(self.wind!)
//                print(self.maxTemp)
//                print(self.minTemp)
//
//                print(self.descriptWeathertomorrow!)
//                print("🍊")
            case .failure(let error):
                print(error)
            }
        }
    }
    func setDesign(){
        //フォント用意
        let bigfont = UIFont(name: "03SmartFontUI", size: 30)
        let fontof20 = UIFont(name: "03SmartFontUI", size: 25)
        let normalfont = UIFont(name: "03SmartFontUI", size: 17)
//天気の詳細を見るボタンの設定
        //角丸
        backButtton.layer.cornerRadius = 5
        backButtton.layer.shadowOpacity = 0.2
        // 影のぼかしの大きさ
        backButtton.layer.shadowRadius = 0.5
        // 影の色
        backButtton.layer.shadowColor = UIColor.black.cgColor
        // 影の方向（width=右方向、height=下方向）
        backButtton.layer.shadowOffset = CGSize(width: 0, height: 2)
        //フォント
        backButtton.titleLabel?.font = fontof20
        print("📩")
        todofukenlabel.font = bigfont
        todayweatherlabel.font = normalfont
        maxtemlabel.font = normalfont
        mintemlabel.font = normalfont
        rainparcent0to6.font = normalfont
        rainparcent6to12.font = normalfont
        rainparcent12to18.font = normalfont
        rainparcent18to24.font = normalfont
        todayweatherlabeltitle.font = normalfont
        maxtemlabeltitle.font = normalfont
        mintemlabeltitle.font = normalfont
        rainparcent0to6title.font = normalfont
        rainparcent6to12title.font = normalfont
        rainparcent12to18title.font = normalfont
        rainparcent18to24title.font = normalfont
        todaysweather.font = fontof20
        todaysweatherper.font = fontof20
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setApiInWeatherView()
        // Do any additional setup after loading the view.
        setDesign()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
