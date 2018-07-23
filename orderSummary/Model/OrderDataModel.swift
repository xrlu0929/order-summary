//
//  OrderDataModel.swift
//  orderSummary
//
//  Created by Xinrui Lu on 7/22/18.
//  Copyright © 2018 AXL. All rights reserved.
//

import UIKit

class OrderDataModel {
    var createdYear : [String] = []
    var province: [String] = []
    
    
    func processProvince (input : [String]) -> (Dictionary<String, Any>) {
        let length = input.count
        
        var provinceDict: [String: Int] = [:]
        
        for e in 0...(length-1) {
            if provinceDict[input[e]] != nil {
                provinceDict[input[e]] = provinceDict[input[e]]! + 1
            } else {
                provinceDict[input[e]] = 1
            }
        }
        
        return provinceDict
    }
}
