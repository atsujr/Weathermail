//
//  ViewController.swift
//  Weathermail
//
//  Created by Atsuhiro Muroyama on 2022/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func button1(){
        let test = GetWeathreApi(num: "280010")
//        test.yoho(citytag: "280010")
        print(test.descriptWeather)
        print(test.descriptWeather)
    }
    
    @IBAction func checkWeatherView(){
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

