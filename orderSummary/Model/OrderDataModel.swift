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
    var province_ready: [String] = []
    
    var orderByProvince: [Int] = []
    var provinceOrderDic:Dictionary<String, Any> = [:]
    
    
    var orderAmount17 = 0
    var orderAmount16 = 0
    
    func processProvince (input : [String]) -> (Dictionary<String, Int>) {
        let length = input.count
        
        var provinceDict: [String: Int] = [:]
        
        
        for e in 0...(length-1) {
            if provinceDict[input[e]] != nil {
                provinceDict[input[e]] = provinceDict[input[e]]! + 1
                
            } else {
                provinceDict[input[e]] = 1
                
            }
            
            province.append(input[e])
        }
        
        provinceOrderDic = provinceDict
        
        return provinceDict
    }
    
    
    func provinceUIUpdate (input : [String]) -> [String] {
        let length = input.count
        
        var result : [String] = []
        
        for e in 0...(length-1) {
            if result.contains(input[e]) {
                continue
            } else {
                result.append(input[e])
            }
        }
        
        return result

    }
    
    func provinceOrderUIUpdate (input : [String], dic: Dictionary<String, Int>) -> [Int] {
        var result : [Int] = []
        
        let length = dic.count
        
        for e in 0...(length-1) {
            if dic[input[e]] != nil {
                result.append(dic[input[e]]!)
            } else {
                result.append(0)
            }
        }
        
        return result
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
