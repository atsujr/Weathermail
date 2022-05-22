//
//  SettingViewController.swift
//  Weathermail
//
//  Created by Atsuhiro Muroyama on 2022/05/22.
//

import UIKit

class SettingViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak private var textField: UITextField!
       private let pickerView = UIPickerView(frame: .zero)

       private let dataList = ["Mickey Mouse", "Minnie Mouse", "Donald Duck", "Goofy", "Pluto"]
       
       override func viewDidLoad() {
           super.viewDidLoad()
           textField.text = "japan"
           setup()
       }
       
       private func setup() {
           pickerView.delegate = self
           pickerView.dataSource = self
           let toolbar = UIToolbar()
           let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(SettingViewController.tappedDone))
           toolbar.items = [space, doneButton]
           toolbar.sizeToFit()
           textField.inputView = pickerView
           textField.inputAccessoryView = toolbar
       }
    
    @objc func tappedDone() {
        textField.resignFirstResponder()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return dataList.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return dataList[row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            textField.text = dataList[row]
        }
}
