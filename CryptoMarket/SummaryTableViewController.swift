//
//  SummaryTableViewController.swift
//  CryptoMarket
//
//  Created by Eng Tian Xi on 07/04/2018.
//  Copyright © 2018 techcoderx. All rights reserved.
//

import UIKit
import CryptoCurrencyKit

class SummaryTable: UITableViewController {
    @IBOutlet var marketCapLbl: UILabel!
    @IBOutlet var Vol24hLbl: UILabel!
    @IBOutlet var btcdominance: UILabel!
    @IBOutlet var cryptonumberLbl: UILabel!
    @IBOutlet var marketnumberLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        fetchCryptoMarketData()
        
    }
    
    func fetchCryptoMarketData() {
        CryptoCurrencyKit.fetchGlobal(convert: .cny) { response in
            switch response {
            case .success(let data):
                self.marketCapLbl.text = "$\(data.totalMarketCapUSD)"
                self.Vol24hLbl.text = "$\(data.totalVolumeUSD24h)"
                self.btcdominance.text = "\(data.bitCoinPercentageOfMarketCap)%"
                self.cryptonumberLbl.text = "\(data.activeCurrencies + data.activeAssets)"
                self.marketnumberLbl.text = "\(data.activeMarkets)"
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func refreshData() {
        fetchCryptoMarketData()
        refreshControl?.endRefreshing()
    }
}
