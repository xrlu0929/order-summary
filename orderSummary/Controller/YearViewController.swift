//
//  YearViewController.swift
//  orderSummary
//
//  Created by Xinrui Lu on 7/23/18.
//  Copyright © 2018 AXL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class YearViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var yearTextPassed : String?
    
    let baseURL = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    
    let orderYearlyDataModel = OrderDataByYear()
    
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var orderYearTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        year.text = yearTextPassed
        getOrderData(url: baseURL)
        
        
        orderYearTabelView.delegate = self
        orderYearTabelView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getOrderData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON {
                response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got the yearly order data")
                    let orderJSON : JSON = JSON(response.result.value!)
                    
                    print(orderJSON)
                    self.parseYearlyOrderData(json: orderJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    
                }
        }
        
    }
    
    func parseYearlyOrderData(json: JSON) {
        let orderData = json["orders"]
        // get orderData length
        let length :Int = orderData.count
        var count2017 = 0
        print("*****")
        
        var first_name_2017 : [String] = []
        var last_name_2017 : [String] = []
        var orderID_2017:[Any] = []
        
        for entry in 0...(length-1) {
            /**
             *  created date
             **/
            let yearJSON = orderData[entry]["created_at"]
            
            let year = yearJSON.string!
            let indexEndOfYear = year.index(year.startIndex, offsetBy: 3)
            let year_ready = String(year[...indexEndOfYear])
            
            let customerJSON = orderData[entry]["customer"]
            //print(customerJSON)
            //print(year_ready)
            print(entry)
            let orderIDJSON = orderData[entry]["id"]
            print(orderIDJSON)
            
            if (year_ready == "2017") {
                
                count2017 = count2017 + 1
                
                /** update order id
                 **/
                if(orderIDJSON != JSON.null)
                {
                    orderID_2017.append(orderIDJSON)
                } else {
                    orderID_2017.append("n/a")
                }
                
                /** update customer name
                 **/
                if(customerJSON != JSON.null) {
                    first_name_2017.append(customerJSON["first_name"].string!)
                    last_name_2017.append(customerJSON["last_name"].string!)
                } else {
                    first_name_2017.append("n/a")
                    last_name_2017.append("n/a")
                }
                
                
            }
            
        }
        
        
        orderYearlyDataModel.orderAmount = count2017
        orderYearTabelView.reloadData()
        orderYearlyDataModel.customerFirstName = first_name_2017
        orderYearlyDataModel.customerLastName = last_name_2017
        
        orderYearlyDataModel.orderID = orderID_2017
        
        orderYearTabelView.reloadData()
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderDetailCell", for: indexPath)
//        let orderID = ["123123123", "234234234", "345345345"]
//        let customer = ["Ann", "Bella", "Carry"]
        // cusomer Name
        cell.detailTextLabel?.text = orderYearlyDataModel.customerFirstName[indexPath.row] + " " + orderYearlyDataModel.customerLastName[indexPath.row]
        // order ID
        
        cell.textLabel?.text = "\(orderYearlyDataModel.orderID[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(orderYearlyDataModel.orderAmount)
        return orderYearlyDataModel.orderAmount
    }

  

}
