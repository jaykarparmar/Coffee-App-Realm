//
//  OrdersTableViewCell.swift
//  Coffee App Realm
//
//  Created by Jaykar Parmar on 16/10/22.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCoffeeType: UILabel!
    @IBOutlet weak var lblCoffeeSize: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
