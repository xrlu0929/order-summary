//
//  FirstViewController.swift
//  orderSummary
//
//  Created by Xinrui Lu on 7/22/18.
//  Copyright © 2018 AXL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController {
    let baseURL = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    
    let orderDataModel = OrderDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded first view of tabview")
        getOrderData(url: baseURL)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Networking
    //    /***************************************************************/
    
    func getOrderData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got the order data")
                    let orderJSON : JSON = JSON(response.result.value!)
                    
                    print(orderJSON)
                    self.parseOrderData(json: orderJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    //self.bitcoinPriceLabel.text = "Connection Issues"
                }
        }
        
    }
    
    func parseOrderData(json: JSON) {
        let orderData = json["orders"]
        // get orderData length
        let length = orderData.count
        print("the length of Order is: ", "\(length)")
    }


}

