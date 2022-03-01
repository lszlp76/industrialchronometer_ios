//
//  LapListCellTableViewCell.swift
//  industrialchronometer
//
//  Created by ulas özalp on 14.02.2022.
//

import UIKit

class LapListCellTableViewCell: UITableViewCell {
   /** Lap tableview components */
    @IBOutlet weak var lapNumberLabel: UILabel!
    @IBOutlet weak var lapValueLabel: UILabel!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    
    /** About tableView components */
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var icon: UIImageView!
    
   
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func toggleSwitched(_ sender: Any) {
     
       /*
        tıkladığından notification geönderiyor
        */
//            NotificationCenter.default.post(name: .pauseLapOff, object: nil)
//
//        if !toggleSwitch.isOn {
//            toggleSwitch.setOn(false, animated: true)
//
//        }else
//        {
//            toggleSwitch.setOn(true, animated: true)
//
//        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

