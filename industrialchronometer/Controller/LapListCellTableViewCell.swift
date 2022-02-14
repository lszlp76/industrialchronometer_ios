//
//  LapListCellTableViewCell.swift
//  industrialchronometer
//
//  Created by ulas özalp on 14.02.2022.
//

import UIKit

class LapListCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lapNumberLabel: UILabel!
    @IBOutlet weak var lapValueLabel: UILabel!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
