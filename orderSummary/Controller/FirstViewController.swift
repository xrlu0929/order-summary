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
import Foundation

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let baseURL = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    
    var orderDataModel = OrderDataModel()
    
    @IBOutlet weak var test: UILabel!
    
    @IBOutlet weak var provinceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded first view of tabview")
        
        getOrderData(url: baseURL)
        
        // Do any additional setup after loading the view, typically from a nib.
        // register Province Xib
        
        provinceTableView.delegate = self
        provinceTableView.dataSource = self
        provinceTableView.register(UINib(nibName: "ProvinceCell", bundle: nil), forCellReuseIdentifier:"provinceCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Networking
    //    /***************************************************************/
    
    func getOrderData(url: String) {
        var orderJSON : JSON = JSON.null
        
        Alamofire.request(url, method: .get)
            .responseJSON {
                response in
                if response.result.isSuccess {
                    
                    print("Success! Got the order data")
                    orderJSON = JSON(response.result.value!)
                    
                    
                    //print(orderJSON)
                    self.parseOrderData(json: orderJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    
                }
        }
        
    }
    
    func parseOrderData(json: JSON) {
        let orderData = json["orders"]
        //var province : [String] = []
        // get orderData length
        let length :Int = orderData.count
        print("the length of Order is: ", "\(length)")
        
        for entry in 0...(length-1) {
            /**
             * ship to
             **/
            if (orderData[entry]["shipping_address"]["province"] != JSON.null) {
                orderDataModel.province.append(orderData[entry]["shipping_address"]["province"].string!)
                //print(orderDataModel.province[entry])
            } else {
                orderDataModel.province.append("N/A")
                //print(orderDataModel.province[entry])
                
            }
            
        }
        orderDataModel.province_ready = orderDataModel.provinceUIUpdate(input: orderDataModel.province)
        orderDataModel.provinceOrderDic = orderDataModel.processProvince(input: orderDataModel.province)
        orderDataModel.orderByProvince = orderDataModel.provinceOrderUIUpdate(input: orderDataModel.province_ready, dic: orderDataModel.provinceOrderDic as! Dictionary<String, Int>)
        provinceTableView.reloadData()
        
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "provinceCell", for: indexPath) as! ProvinceCell
        
//        let provinceTEST : [String] = ["New York", "Alaska", "Ma"]
//        let orderTEST = [22, 33, 14]
//
//        cell.provinceLabel.text = provinceTEST[indexPath.row]
//        cell.orderNumberLabel.text = "\(orderTEST[indexPath.row])"

        cell.provinceLabel.text = orderDataModel.province_ready[indexPath.row]
        cell.orderNumberLabel.text = "\(orderDataModel.orderByProvince[indexPath.row])"
        
        print("finished setting cell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("cell row number returned")
        print(orderDataModel.province_ready.count)
        return orderDataModel.province_ready.count
    }
    

}

