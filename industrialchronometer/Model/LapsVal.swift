//
//  LapsVal.swift
//  industrialchronometer
//  bu struct yakalanan laplerin oluşturduğu float dizi
// içindeki işlemler için kullanılır.
// cycltime dizisi lap sınıfı ile alınan diziyi temsil eder.
//  Created by ulas özalp on 1.02.2022.
//

import Foundation

struct LapsVal{
    
    
    var cycleTime : [Float]
    func CalculateCycleTimePerMinute (laps:[Float] ) -> Float {
        var cycPerMinute : Float = 0.0
       
       
        cycPerMinute = (1 / GetMeanOfLaps(laps: cycleTime))
        
        return cycPerMinute
        
        
    }
    func CalculateCycleTimePerHour(laps:[Float] ) -> Float {
        var cycPerHour : Float = 0.0
        
        cycPerHour = 60 / GetMeanOfLaps(laps: cycleTime)
       
        return cycPerHour
        
    }
   
    func GetMinimumOfLaps (laps : [Float]) -> Float{
        var min = laps[0]
        
        for value in laps[0..<laps.count] {
            if value < min {
                min = value
            } else {
            }
        }
        return min
        }
    func GetMaximumOfLaps(laps : [Float]) -> Float{
        var max = laps[0]
        
        for value in laps[0..<laps.count] {
            if value > max {
                max = value
            } else {
            }
        }
        return max
    }
    func GetMeanOfLaps (laps : [Float]) ->Float {
        
        var sum :Float = 0
         for value in laps[0..<laps.count]{
            sum = value + sum
        }
        return sum / Float(laps.count)
                
    }
    func setMomentTime()-> Date {
        let currentTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        formatter.string(from: currentTime)
        return currentTime
    }
    func getObservationTime(start: Date , end :Date)-> String {
        
        let calendar = Calendar.current
       let diff = calendar.dateComponents([.hour, .minute , .second], from: start,to:end)
        let formattedStringDateDifference = String (format : "%02ld:%02ld:%02ld", diff.hour!,diff.minute!,diff.second!)
        return formattedStringDateDifference
        

    }
}
