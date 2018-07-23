//
//  ProvinceCell.swift
//  orderSummary
//
//  Created by Xinrui Lu on 7/22/18.
//  Copyright © 2018 AXL. All rights reserved.
//

import UIKit

class ProvinceCell: UITableViewCell {

    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
