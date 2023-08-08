//
//  BeerViewController.swift
//  Beer Project
//
//  Created by 마르 on 2023/08/08.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

class BeerViewController: UIViewController {

    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerLabel: UILabel!
    @IBOutlet var beerDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beerLabel.textAlignment = .center
        beerLabel.font = .boldSystemFont(ofSize: 15)
        beerLabel.textColor = .systemPink
        beerDescription.textAlignment = .left
        beerDescription.font = .boldSystemFont(ofSize: 13)
    }

    @IBAction func beerButtonClicked(_ sender: UIButton) {
        
        getRandomBeer()
        
        }
    
    func getRandomBeer() {
        let url = APIKey.beerKey
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let image_url = json[0]["image_url"].stringValue
                let name = json[0]["name"].stringValue
                let desciption = json[0]["description"].stringValue
                let pair = json[0]["food_pairing"][0].stringValue
                self.beerLabel.text = name
                self.beerDescription.text = "잘 어울리는 안주: \(pair)\n\n맥주 설명: \(desciption)"
                self.setImage(url: image_url)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setImage(url: String) {
        let url = URL(string: url)
        beerImageView.kf.setImage(with: url)
    }
}
