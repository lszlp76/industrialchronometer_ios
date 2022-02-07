//
//  ViewController.swift
//  industrialchronometer
//
//  Created by ulas özalp on 31.01.2022.
//

import UIKit



class ViewController: UIViewController , UITabBarControllerDelegate{

    
    
    
   
    
  
    let radioController: RadioButtonController = RadioButtonController()
    var m = 0 ,h = 0, lapNumber = 0, modul = 0.0 , milis = 0, counter  = 0
    var hh = "",mm = "", ss = ""
    var timeUnit = ""
    
    var startTime : Date? = nil
    var stopTime : Date? = nil
    var laps = [Laps]()
    
    var lapsVal = LapsVal.init(cycleTime: [])//lapsVal LapsVal içinde float bir dizi olacak
    
    var timer = Timer()
    
    var isPlaying = false
    var titleButton = "Start"
    let dataTransfer = TransferService.sharedInstance
    
    
    @IBOutlet weak var btnHndrMin: UIButton!
    @IBOutlet weak var btnSecond: UIButton!
    
    @IBOutlet weak var aveCycTimeLabel: UILabel!
    @IBOutlet weak var maxCycTimeLabel: UILabel!
    @IBOutlet weak var minCycTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetTimer: UIButton!
    @IBOutlet weak var outputText: UITextView!
    
    @IBOutlet weak var observationTimer: UILabel!
    @IBOutlet weak var cycPerMinuteLabel: UILabel!
    
    @IBOutlet weak var cycPerHourLabel: UILabel!
    @IBOutlet weak var lapButton: UIButton!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBAction func btnSecondClicked(_ sender: UIButton) {
        modul = 100.0
        milis = 60
        timeUnit = "Sec."
        radioController.buttonArrayUpdated(buttonSelected: sender )
    }
    
    @IBAction func btnHdrtMinClicked(_ sender: UIButton) {
        modul = 60.0
        milis = 100
        timeUnit =  "Cmin."
        radioController.buttonArrayUpdated(buttonSelected: sender )
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = "00:00:00"
      
        self.tabBarController?.delegate = self
    
        tabBarItem.title = "Chrono"
        
        resetTimer.isEnabled = false
        lapButton.isEnabled = false
        saveButton.isEnabled = false
        timeLabel.adjustsFontSizeToFitWidth = true
        radioController.buttonsArray = [btnSecond,btnHndrMin]
        
        // ilk açıldığında default olarak seçilen buton
        //      radioController.defaultButton = btnSecond
        
        
    }
    @IBAction func takeLap(_ sender: Any) {
        
        
        
        var delta , delta0 , delta1  : Float
        let lap = Laps(hour: h, minute: m, second: counter)
        delta = 0
        delta0 = 0
        delta1 = 0
        laps.append(lap)
        if lapNumber > 0 {
            
            
            delta1 = (Float(laps[lapNumber].hh)/60 + Float(laps[lapNumber].mm) + Float(laps[lapNumber].ss)/Float(milis) )
            delta0 = ( Float(laps[lapNumber-1].hh/60) + Float(laps[lapNumber-1].mm) + Float(laps[lapNumber-1].ss)/Float(milis))
            
            delta = (delta1-delta0 )
            
          
        
            lapsVal.cycleTime.append(delta) // iki lap arasındaki farkı cycletime dizisine atıyor
        }
        
        else {
          
            delta = (Float(laps[0].hh/60) + Float(laps[0].mm) + Float(laps[0].ss)/Float(milis))
            
            
            lapsVal.cycleTime.append(delta) // iki lap arasındaki farkı cycletime dizisine atıyor
           
            
        }
        
        let max =  (lapsVal.GetMaximumOfLaps(laps: lapsVal.cycleTime) ) * (Float(milis))
       
        let min =  (lapsVal.GetMinimumOfLaps(laps: lapsVal.cycleTime)) * (Float(milis))
        let ave = ( lapsVal.GetMeanOfLaps(laps: lapsVal.cycleTime) ) * (Float(milis))
        minCycTimeLabel.text = "Min.Cycle Time : \(String( format: "%.2f",min )) \(timeUnit)"
        maxCycTimeLabel.text = "Max.Cycle Time : \(String( format: "%.2f",max )) \(timeUnit)"
        aveCycTimeLabel.text = "Ave.Cycle Time : \(String( format: "%.2f",ave ) )\(timeUnit)"
        
        var cycPerMinute = lapsVal.CalculateCycleTimePerMinute(laps: lapsVal.cycleTime)
       
        var cycPerHour = lapsVal.CalculateCycleTimePerHour(laps: lapsVal.cycleTime)
        
        
        cycPerMinuteLabel.text = String( format: "%.2f",(cycPerMinute) )
        cycPerHourLabel.text = String( format: "%.2f",(cycPerHour) )
      
        
        
        outputText.text = "\(lapNumber + 1) -  \((lap.LapToString(laps: laps[lapNumber]))  ) Cyc.time : \(String (format: "%.2f",(lapsVal.cycleTime[lapNumber] * Float( milis)))) \(timeUnit) \n\n " + outputText.text!

        
        dataTransfer.lapDataToTransfer.append(lapsVal.cycleTime[lapNumber] * Float(milis))
        
        lapNumber += 1
    }
  
    

    
    @IBAction func resetTimer(_ sender: Any) {
        
        //alert yaratma
        let resetAlert = UIAlertController (title:"Clear All Data", message: "Would you like to reset your study ?", preferredStyle: .alert)
        
        //butonları ekleme
        resetAlert.addAction(UIAlertAction(title: "Reset", style: .default,handler: { UIAlertAction in
            self.startButton.isEnabled = true
            self.radioController.buttonsArray[0].isEnabled = true
            self.radioController.buttonsArray[1].isEnabled = true
            self.timer.invalidate()
            self.isPlaying = false
            self.counter = 0
            self.h = 0
            self.m = 0
            self.timeLabel.text = "00:00:00"
            self.maxCycTimeLabel.text = "Max.Cycle Time :"
            self.minCycTimeLabel.text = "Min.Cycle Time :"
            self.aveCycTimeLabel.text = "Ave.Cycle Time :"
            self.cycPerHourLabel.text = ""
            self.cycPerMinuteLabel.text = ""
            self.observationTimer.text = ""
            self.milis = 0
            self.modul = 0
            self.outputText.text = ""
            self.laps.removeAll()
            self.lapsVal.cycleTime.removeAll()
            self.lapNumber = 0
            self.radioController.selectedButton?.isSelected = false
            self.stopTime = nil
            self.startTime = nil
            self.isPlaying = false
            self.startButton.setTitle("Start", for: .normal)
            self.dataTransfer.lapDataToTransfer.removeAll()
            
            NotificationCenter.default.post(name: Notification.Name("NewFunctionName"), object: nil)
        }))
        
        resetAlert.addAction(UIAlertAction(title:" Cancel",style: .default,handler: nil))
        
        self.present(resetAlert,animated: true,completion: nil)
        
        
       
        
        /*
         silinecekler
         laps.
         lapsVal.cycleTime.
         */
        
    }
    func PauseTimer() {
        
        takeLap((Any).self)
        timer.invalidate()
        startButton.setTitle("Continue", for: .normal)
        
        stopTime = lapsVal.setMomentTime()
        titleButton = "Start"
        let observationTime =  lapsVal.getObservationTime(start: startTime!, end: stopTime!)
        observationTimer.text = observationTime
              
    
    }
    
    @IBAction func startTimer(_ sender: Any) {
        if (modul > 0 ){
            
            switch (titleButton){
                
            case ("Start"):
                startButton.setTitle("Pause", for: .normal)
                titleButton = "Pause"
                
                
                timer = Timer.scheduledTimer(timeInterval: modul/100, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
               
                if !(isPlaying) {
                    startTime = lapsVal.setMomentTime()
                }
                
                
                lapButton.isEnabled = true
                resetTimer.isEnabled = false
                saveButton.isEnabled = false
                isPlaying = true
                if (modul == 60 ){
                    radioController.buttonsArray[0].isEnabled = false
                }else {
                    radioController.buttonsArray[1].isEnabled = false
                }
                
                break
            case ("Pause"):
                lapButton.isEnabled = false
                resetTimer.isEnabled = true
                saveButton.isEnabled = true
                PauseTimer()
                break
                
            default: break
                
            }
        }
        else {
            let unitAlert = UIAlertController (title:"Time Unit",message: "Choose your time unit", preferredStyle: .alert)
            unitAlert.addAction(UIAlertAction (title: "OK", style: .default,handler: { UIAlertAction in
                return
            }))
            self.present(unitAlert,animated: true,completion: nil)
        }
    }
    
    @objc func UpdateTimer (){
        
        counter += 1
        if ( counter > 0 && Int(counter)%Int(milis) == 0)
        {
            m += 1
            counter = 0
        }
        if ( m >= 60){
            h += 1
            m = 0
        }
        hh = h < 10 ? "0" + String (h) : String (h) + ""
        mm = m < 10 ? "0" + String (m) : String (m) + ""
        ss = counter < 10 ? "0" + String(counter):String( Int(counter)%Int(milis)) + ""
        
        //timeLabel.text = String( format: "%.2f",counter)
        timeLabel.text = String ( hh + ":" + mm + ":" + ss)
    }
    
    func transferLapToChart (lapnumber : Int){

        let destination = storyboard?.instantiateViewController(withIdentifier: "ChartViewController") as! ChartViewController
        
   
    }

        
   
}
/*
 timeInterval değeri 1 ise 1 snde 1 artırır. 0.6 yaparsan cmin oluyor
 counter 1 artırırsan saniye veya saat formatına çevireblirsin
 */

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if let segu  = segue.destination as? ChartViewController {
//            segu.delegate = self
//            segu.deger = getKey()
//        }
