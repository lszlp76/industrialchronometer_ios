//
//  SettingIcon.swift
//  industrialchronometer
//
//  Created by ulas özalp on 26.02.2022.
//

import Foundation
import UIKit
struct SettingIcon {
    let label : String
    let icon : UIImage?
    let iconBackgroundColor: UIColor?
    let width : Float?
    let heigth : Float?
    var handler : (() -> Void)?
    var switchHide : Bool
}

struct Section {
    let title : String
    let option : [SettingIcon]
  
    
}
enum SettingsOption {
    case staticCell(setting: SettingIcon)
    case switchCell(setting: SettingSwitchIcon)
}

struct SettingSwitchIcon {
   
    var isOn : Bool
    
    
}
