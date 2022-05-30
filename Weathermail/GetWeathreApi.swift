import UIKit
import Alamofire
import SwiftyJSON

class GetWeathreApi{
    //県のcitycodeを返す関数
    func retCityTag(todoufuken: String) -> Int{
        if(todoufuken == "北海道"){
            return 016010
        }else  if(todoufuken == "青森県"){
            return 020010
        }else if(todoufuken == "岩手県"){
            return 030010
        }else if(todoufuken == "宮城県"){
            return 040010
        }else if(todoufuken == "秋田県"){
            return 050010
        }else if(todoufuken == "山形県"){
            return 060010
        }else if(todoufuken == "福島県"){
            return 070010
        }else if(todoufuken == "茨城県"){
            return 080010
        }else if(todoufuken == "栃木県"){
            return 090010
        }else  if(todoufuken == "群馬県"){
            return 100010
        }else if(todoufuken == "埼玉県"){
            return 110010
        }else if(todoufuken == "千葉県"){
            return 130010
        }else if(todoufuken == "東京都"){
            return 120010
        }else if(todoufuken == "神奈川県"){
            return 140010
        }else if(todoufuken == "新潟県"){
            return 150010
        }else if(todoufuken == "富山県"){
            return 160010
        }else  if(todoufuken == "石川県"){
            return 170010
        }else if(todoufuken == "福井県"){
            return 180010
        }else if(todoufuken == "山梨県"){
            return 190010
        }else if(todoufuken == "長野県"){
            return 200010
        }else if(todoufuken == "岐阜県"){
            return 210010
        }else if(todoufuken == "静岡県"){
            return 220010
        }else if(todoufuken == "愛知県"){
            return 230010
        }else  if(todoufuken == "三重県"){
            return 240010
        }else if(todoufuken == "滋賀県"){
            return 250010
        }else if(todoufuken == "京都府"){
            return 260010
        }else if(todoufuken == "大阪府"){
            return 270000
        }else if(todoufuken == "兵庫県"){
            return 280010
        }else if(todoufuken == "奈良県"){
            return 290010
        }else if(todoufuken == "和歌山県"){
            return 300010
        }else  if(todoufuken == "鳥取県"){
            return 310010
        }else if(todoufuken == "島根県"){
            return 320010
        }else if(todoufuken == "岡山県"){
            return 330010
        }else if(todoufuken == "広島県"){
            return 340010
        }else if(todoufuken == "山口県"){
            return 350010
        }else if(todoufuken == "徳島県"){
            return 360010
        }else if(todoufuken == "香川県"){
            return 370000
        }else  if(todoufuken == "愛媛県"){
            return 380010
        }else if(todoufuken == "高知県"){
            return 390010
        }else if(todoufuken == "福岡県"){
            return 400010
        }else if(todoufuken == "佐賀県"){
            return 410010
        }else if(todoufuken == "長崎県"){
            return 420010
        }else if(todoufuken == "熊本県"){
            return 430010
        }else if(todoufuken == "大分県"){
            return 440010
        }else  if(todoufuken == "宮崎県"){
            return 450010
        }else if(todoufuken == "鹿児島県"){
            return 460010
        }else if(todoufuken == "沖縄県"){
            return 471010
        }
        return 0
    }
    //ここから下は天気の情報をネットから持ってくる関数。
    var citytag :String!
    var descriptWeather: String? = "何で？"
    var maxTemp: String?
    var minTemp: String?
    var chanceOfRain0to6: String?
    var chanceOfRain6to12: String?
    var chanceOfRain12to18: String?
    var chanceOfRain18to24: String?
    var wind: String?
    init(num: String){
        yoho(citytag: num)
    }

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
                self.descriptWeather = json["forecasts"][0]["telop"].string!
                print("🍊")
                print(self.descriptWeather)
                print("🍊")
                self.maxTemp = json["forecasts"][0]["temperature"]["min"]["celsius"].string
                self.maxTemp = json["forecasts"][0]["temperature"]["max"]["celsius"].string
                //上記の2つは、strinで値を返しているから、optionaol()か、nilが入る。後々アンラップしないと,,,
                //しかも、なぜかは知らないが、最低気温か最高気温が取得できない場合がある。(正確にはnullだったりする。)
                self.chanceOfRain0to6 = json["forecasts"][0]["chanceOfRain"]["T00_06"].string!
                self.chanceOfRain6to12 = json["forecasts"][0]["chanceOfRain"]["T06_12"].string!
                self.chanceOfRain12to18 = json["forecasts"][0]["chanceOfRain"]["T12_18"].string!
                self.chanceOfRain18to24 = json["forecasts"][0]["chanceOfRain"]["T18_24"].string!
                //上記の戻り値は、10%,0%,100%,__%とかいうふざけたstringのこともあるから、後々stringを分割して、ifで場合分けしてからintに変換する！
                self.wind = json["forecasts"][0]["detail"]["wind"].string!
                
                
                
                //取得したjsonから、必要なデータを取り出します。
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
