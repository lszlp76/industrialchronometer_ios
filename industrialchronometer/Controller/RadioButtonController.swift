//
//  RadioButtonController.swift
//  industrialchronometer
//
//  Created by ulas özalp on 31.01.2022.
//
import UIKit
import Foundation
class RadioButtonController: NSObject {
    var buttonsArray: [UIButton]! {
        didSet {
            for b in buttonsArray {
              //  b.setImage(UIImage(systemName:"circle"), for: .normal)
               // b.setImage(UIImage(systemName:"circle.fill"), for: .selected)
            }
        }
    }
    var selectedButton: UIButton?
    var defaultButton: UIButton = UIButton() {
        didSet {
            buttonArrayUpdated(buttonSelected: self.defaultButton)
            
            
        }
    }

    func buttonArrayUpdated(buttonSelected: UIButton) {
        for b in buttonsArray {
            if b == buttonSelected {
                selectedButton = b
                b.isSelected = true
               
            } else {
                b.isSelected = false
              
            }
        }
    }
}
