//
//  OneDayWeatherTableViewCell.swift
//  AIBChallenge
//
//  Created by Yasin Akinci on 14/10/2018.
//  Copyright © 2018 Yasin Akinci. All rights reserved.
//

import UIKit

class OneDayWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var mainDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
