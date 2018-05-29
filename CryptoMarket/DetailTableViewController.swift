//
//  DetailTableViewController.swift
//  CryptoMarket
//
//  Created by Eng Tian Xi on 07/04/2018.
//  Copyright © 2018 techcoderx. All rights reserved.
//

import UIKit
import CryptoCurrencyKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var symLbl: UILabel!
    @IBOutlet var rankLbl: UILabel!
    @IBOutlet var priceusdLbl: UILabel!
    @IBOutlet var pricebtcLbl: UILabel!
    @IBOutlet var chg1hLbl: UILabel!
    @IBOutlet var chg24hLbl: UILabel!
    @IBOutlet var chg7dLbl: UILabel!
    @IBOutlet var availableSupplyLbl: UILabel!
    @IBOutlet var totalSupplyLbl: UILabel!
    @IBOutlet var marketCapUSDLbl: UILabel!
    
    var cellid:Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CryptoCurrencyKit.fetchTickers { response in
            switch response {
            case .success(let data):
                self.nameLbl.text = "\(data[self.cellid].name)"
                self.symLbl.text = "\(data[self.cellid].symbol)"
                self.rankLbl.text = "\(data[self.cellid].rank)"
                self.priceusdLbl.text = "$\(data[self.cellid].priceUSD!)"
                self.pricebtcLbl.text = "₿\(data[self.cellid].priceBTC!)"
                self.chg1hLbl.text = "\(data[self.cellid].percentChange1h!)%"
                self.chg24hLbl.text = "\(data[self.cellid].percentChange24h!)%"
                self.chg7dLbl.text = "\(data[self.cellid].percentChange7d!)%"
                self.availableSupplyLbl.text = "\(data[self.cellid].availableSupply!)"
                self.totalSupplyLbl.text = "\(data[self.cellid].totalSupply!)"
                self.marketCapUSDLbl.text = "$\(data[self.cellid].marketCapUSD!)"
            case .failure(let error):
                print(error)
            }
        }
    }

}
