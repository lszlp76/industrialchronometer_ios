//
//  ViewController.swift
//  industrialchronometer
//
//  Created by ulas özalp on 31.01.2022.
//

import UIKit

class ViewController: UIViewController {

        let radioController: RadioButtonController = RadioButtonController()

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var btnHndrMin: UIButton!
    @IBOutlet weak var btnSecond: UIButton!
    override func viewDidLoad() {
            super.viewDidLoad()
        timeLabel.adjustsFontSizeToFitWidth = true
            radioController.buttonsArray = [btnSecond,btnHndrMin]
            radioController.defaultButton = btnSecond
        }

    @IBAction func btnSecondClicked(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender )
    }
   
    @IBAction func btnHdrtMinClicked(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender )
        

    }
   
     
}

