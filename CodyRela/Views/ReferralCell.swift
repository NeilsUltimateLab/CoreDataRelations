//
//  ReferralCell.swift
//  CodyRela
//
//  Created by Neil Jain on 12/1/18.
//  Copyright © 2018 Neil Jain. All rights reserved.
//

import UIKit

class ReferralCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var interestedInLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    func configure(with referral: Referral) {
        self.nameLabel.text = referral.name
        self.interestedInLabel.text = "\(referral.interestedIn?.count ?? 0)"
    }
    
}
