//
//  PropertyItemCell.swift
//  CodyRela
//
//  Created by Neil Jain on 12/1/18.
//  Copyright © 2018 Neil Jain. All rights reserved.
//

import UIKit

class PropertyItemCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    func configure(with value: PropertyItem) {
        self.nameLabel.text = (value.name ?? "") + "" + "(\(value.referrals?.count ?? 0))"
        self.priceLabel.text = value.price
        self.addressLabel.text = value.address
    }
    
}
