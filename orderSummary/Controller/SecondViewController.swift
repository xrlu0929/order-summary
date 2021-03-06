//
//  SecondViewController.swift
//  orderSummary
//
//  Created by Xinrui Lu on 7/22/18.
//  Copyright © 2018 AXL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class SecondViewController: UIViewController {
    let baseURL = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    
    let orderDataModel = OrderDataModel()
    
    @IBOutlet weak var orderNum17: UILabel!
    @IBOutlet weak var orderNum16: UILabel!
    
    @IBAction func readMore2017(_ sender: Any) {
        print("go to 2017")
        performSegue(withIdentifier: "gotoDetail17", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoDetail17" {
            let destinationVC = segue.destination as! YearViewController
            
            destinationVC.yearTextPassed = "2017"
        }
        
        else if segue.identifier == "gotoDetail16" {
            
            let destinationVC = segue.destination as! YearViewController

            destinationVC.yearTextPassed = "2016"
            
            self.showToast(message: "Function Coming Soon~!")
            
        }
    }
    
    @IBAction func readMore2016(_ sender: Any) {
        print("go to 2016")
        performSegue(withIdentifier: "gotoDetail16", sender: self)
        
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded second view of tab view")
        getOrderData(url: baseURL)
        // Do any additional setup after loading the view, typically from a nib.
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
                    
                    print("Sucess! Got the order data")
                    let orderJSON : JSON = JSON(response.result.value!)
                    
                    //print(orderJSON)
                    self.parseOrderData(json: orderJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    
                }
        }
        
    }
    
    func parseOrderData(json: JSON) {
        let orderData = json["orders"]
        // get orderData length
        let length :Int = orderData.count
        print("the length of Order is: ", "\(length)")
        
        for entry in 0...(length-1) {
            //print(entry)
            
            /**
             *  created date
             **/
            
            //print(orderData[entry]["created_at"])
            let yearJSON = orderData[entry]["created_at"]
            let year = yearJSON.string!
            let indexEndOfYear = year.index(year.startIndex, offsetBy: 3)
            let year_ready = String(year[...indexEndOfYear])

            orderDataModel.createdYear.append(year_ready)
            //print(orderDataModel.createdYear[entry])
            
        }
        
        //print(orderDataModel.createdYear)
        
        orderDataModel.orderAmount16 = orderDataModel.processYearData(input: orderDataModel.createdYear)[0]
        
        orderDataModel.orderAmount17 = orderDataModel.processYearData(input: orderDataModel.createdYear)[1]
            
        updateYearUI()
    }
    
    
    
    func updateYearUI() {
        orderNum17.text = String(orderDataModel.orderAmount17)
        orderNum16.text = String(orderDataModel.orderAmount16)
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    


}

