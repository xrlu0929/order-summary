//
//  ViewController.swift
//  orderSummary
//
//  Created by Xinrui Lu on 7/22/18.
//  Copyright © 2018 AXL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    let baseURL = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOrderData(url: baseURL)
        // Do any additional setup after loading the view.
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
    
                    } else {
                        print("Error: \(String(describing: response.result.error))")
                        //self.bitcoinPriceLabel.text = "Connection Issues"
                    }
                }
    
        }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
