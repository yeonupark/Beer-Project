//
//  LotteryViewController.swift
//  Beer Project
//
//  Created by 마르 on 2023/08/08.
//

import UIKit
import SwiftyJSON
import Alamofire

class LotteryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var numberTextField: UITextField!
    
    let pickerView = UIPickerView()
    
    var list: [Int] = Array(1...1079).reversed()
    
    //@IBOutlet var dateLabel: UILabel!
    @IBOutlet var luckyNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        luckyNumberLabel.textAlignment = .center
        luckyNumberLabel.font = .boldSystemFont(ofSize: 16)
        
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        print("5")
    }
    
    // 휠로 돌아가는 애 = 컴포넌트
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = "\(list[row])"
        
        let num = list[row]
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(num)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                let num = json["drwtNo1"].stringValue + " " + json["drwtNo2"].stringValue + " " + json["drwtNo3"].stringValue + " " + json["drwtNo4"].stringValue + " " + json["drwtNo5"].stringValue + " " + json["drwtNo6"].stringValue
        
                self.luckyNumberLabel.text = "당첨번호: \(num)"
                
            case .failure(let error):
                print(error)
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])"
    }
    
    
}
