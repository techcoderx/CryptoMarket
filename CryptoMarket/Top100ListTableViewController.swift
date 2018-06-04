//
//  Top100ListTableViewController.swift
//  CryptoMarket
//
//  Created by Eng Tian Xi on 07/04/2018.
//  Copyright © 2018 techcoderx. All rights reserved.
//

import UIKit
import CryptoCurrencyKit

class Top100ListTableViewController: UITableViewController {
    
    var selectedindex:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        CryptoCurrencyKit.fetchTickers { response in
            switch response {
            case .success(let data):
                cell.textLabel?.text = "\(data[indexPath.row].name)"
                cell.detailTextLabel?.text = "$\(data[indexPath.row].priceUSD!)(\(data[indexPath.row].percentChange24h!)%)"
            case .failure(let error):
                print(error)
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedindex = indexPath.row
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    @objc func refreshData() {
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let finalvc = segue.destination as! DetailTableViewController
            finalvc.cellid = selectedindex
        }
    }
    

}
