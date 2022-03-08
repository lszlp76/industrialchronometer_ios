//
//  MPVolumExtension.swift
//  industrialchronometer
//
//  Created by ulas özalp on 26.02.2022.
//

import Foundation
import MediaPlayer
extension MPVolumeView {
    
    static func setVolume(_ volume : Float){
      
        let volumeView = MPVolumeView(frame: .zero)
            
        let slider  = volumeView.subviews.first(where: {$0 is UISlider}) as? UISlider
       
        DispatchQueue.main.asyncAfter(deadline : DispatchTime.now() + 0.1 ) {
            slider?.value = volume
            
        }
        
           
    
}
}

