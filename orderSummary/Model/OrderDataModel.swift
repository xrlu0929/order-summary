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
    
    var orderAmount17 = 0
    var orderAmount16 = 0
    
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
    
    func processYearData(input:[String]) -> [Int]{
        let length = input.count
        
        var sixteen = 0
        var seventeen = 0
        
        for i in 0...(length-1) {
            if (input[i] == "2016") {
                sixteen = sixteen + 1
            } else {
                seventeen = seventeen + 1
            }
        }
        
//        orderAmount16 = sixteen
//        orderAmount17 = seventeen
        
        return [sixteen, seventeen]

    }
}
