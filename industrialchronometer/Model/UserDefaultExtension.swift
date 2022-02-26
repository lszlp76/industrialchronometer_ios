//
//  UserDefaultExtension.swift
//  industrialchronometer
//
//  Created by ulas özalp on 26.02.2022.
//

import Foundation
extension UserDefaults {
    /*
     USer defaults ta anahtar nokta set etme işlemini doğrudan değil bir değişkene atayarak yap
     aksi durumda o değeri tutmuyor. let olarak değil var olarak yazdırman lazım
     */
    func setValueForSwitch(value : Bool?){
        if value != nil{
           var PauseLap = UserDefaults.standard.set(value, forKey: "PauseLap")
        } else {
           UserDefaults.standard.removeObject(forKey: "PauseLap")
             }
    }
    
    func getValueForSwitch() -> Bool? {
        return UserDefaults.standard.bool(forKey: "PauseLap")
    }
}
