//
//  ViewController.swift
//  industrialchronometer
//
//  Created by ulas özalp on 31.01.2022.
//

import UIKit



class ViewController: UIViewController , UITabBarControllerDelegate, UITableViewDelegate, UITableViewDataSource{
    
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
    var numberOfLap = 0 // laplistesinde lap numarasını göstermek için lazım
    var totalTimeArrayForLapList : [String] = [] // laplistede total time görünmesi için
    var lapListLapNumberValue : [Int] = []    // laplistesinde lap numarasını göstermek için lazım
    
    @IBOutlet weak var lapListTableView: UITableView!
    
    
    @IBOutlet weak var btnHndrMin: UIButton!
    @IBOutlet weak var btnSecond: UIButton!
    
    @IBOutlet weak var aveCycTimeLabel: UILabel!
    @IBOutlet weak var maxCycTimeLabel: UILabel!
    @IBOutlet weak var minCycTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetTimer: UIButton!
    // @IBOutlet weak var outputText: UITextView!
    
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
    
    @IBAction func saveToFile(_ sender: Any) {
        
        var csvString = "Lap Time \(timeUnit)" //("\(lapsVal.cycleTime) \n")
        
        for totalString in lapsVal.cycleTime
        {
            csvString = csvString.appending("\(String(totalString)) \n")
        }
        
        // file Name enter
        let fileNameAlert = UIAlertController (title: "Save Datas", message: "", preferredStyle: .alert)
        fileNameAlert.addTextField { (textField) in
            textField.placeholder = "Your file name..."
        }
        
        fileNameAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak fileNameAlert] (_) in
            guard let textField = fileNameAlert?.textFields?[0],
                  let fileName = textField.text
                    
                    
            else {return}
            if (fileName.isEmpty){
                return
            }
            else {
                TransferService.sharedInstance.saveTo(name: fileName, csvString: csvString)
            }
            
            
            
        }))
        
        fileNameAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(fileNameAlert, animated: true, completion: nil)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ulas"
        
        timeLabel.text = "00:00:00"
        
        
        self.tabBarController?.delegate = self
        
        tabBarItem.title = "Chrono"
        
        resetTimer.isEnabled = false
        resetTimer.backgroundColor = UIColor(red : 0.77, green: 0.87, blue: 0.96, alpha: 1.00)
        lapButton.isEnabled = false
        lapButton.backgroundColor = UIColor(red : 0.77, green: 0.87, blue: 0.96, alpha: 1.00)
        saveButton.isEnabled = false
        saveButton.backgroundColor = UIColor(red : 0.77, green: 0.87, blue: 0.96, alpha: 1.00)
        timeLabel.adjustsFontSizeToFitWidth = true
        radioController.buttonsArray = [btnSecond,btnHndrMin]
        btnSecond.titleLabel?.font = UIFont(name: "DS-Digital", size: 17.0)
        btnHndrMin.titleLabel?.font =  UIFont(name: "DS-Digital", size: 17.0)
        
        cycPerHourLabel.layer.borderWidth = 1
        cycPerHourLabel.layer.cornerRadius = 10
        cycPerHourLabel.layer.borderColor = UIColor.red.cgColor
        
        cycPerMinuteLabel.layer.borderWidth = 1
        cycPerMinuteLabel.layer.cornerRadius = 10
        cycPerMinuteLabel.layer.borderColor = UIColor.red.cgColor
        
        observationTimer.layer.borderWidth = 1
        observationTimer.layer.cornerRadius = 10
        observationTimer.layer.borderColor = UIColor.red.cgColor
        
        minCycTimeLabel.layer.borderWidth = 1
        maxCycTimeLabel.layer.borderWidth = 1
        aveCycTimeLabel.layer.borderWidth = 1
        minCycTimeLabel.layer.cornerRadius = 10
        maxCycTimeLabel.layer.cornerRadius = 10
        aveCycTimeLabel.layer.cornerRadius = 10
        minCycTimeLabel.layer.borderColor = UIColor.red.cgColor
        maxCycTimeLabel.layer.borderColor = UIColor.red.cgColor
        aveCycTimeLabel.layer.borderColor = UIColor.red.cgColor
        
        
        // ilk açıldığında default olarak seçilen buton
        //      radioController.defaultButton = btnSecond
        
        lapListTableView.delegate = self
        lapListTableView.dataSource = self
        
    }
    @objc func selectorName () {
        
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
        minCycTimeLabel.text = "\(String( format: "%.2f",min )) \(timeUnit)"
        maxCycTimeLabel.text = "\(String( format: "%.2f",max )) \(timeUnit)"
        aveCycTimeLabel.text = "\(String( format: "%.2f",ave )) \(timeUnit)"
        
//        minCycTimeLabel.text = "Min.Cycle Time : \(String( format: "%.2f",min )) \(timeUnit)"
//        maxCycTimeLabel.text = "Max.Cycle Time : \(String( format: "%.2f",max )) \(timeUnit)"
//        aveCycTimeLabel.text = "Ave.Cycle Time : \(String( format: "%.2f",ave ) )\(timeUnit)"
//
        var cycPerMinute = lapsVal.CalculateCycleTimePerMinute(laps: lapsVal.cycleTime)
        
        var cycPerHour = lapsVal.CalculateCycleTimePerHour(laps: lapsVal.cycleTime)
        
        
        cycPerMinuteLabel.text = String( format: "%.2f",(cycPerMinute) )
        cycPerHourLabel.text = String( format: "%.2f",(cycPerHour) )
        
        
        //**** to be change
        /*
         outputText.text = "\t\t\(lapNumber + 1) \t\t\t \((lap.LapToString(laps: laps[lapNumber]))  ) \t\t \(String (format: "%.2f",(lapsVal.cycleTime[lapNumber] * Float( milis)))) \(timeUnit) \n\n " + outputText.text!
         */
        dataTransfer.timeUnitToTransfer = timeUnit
        dataTransfer.lapDataToTransfer.append(lapsVal.cycleTime[lapNumber] * Float(milis))
        
        lapNumber += 1
        lapListLapNumberValue.insert(lapNumber, at: 0)
        print ("lap number \(lapListLapNumberValue)")
        lapListTableView.reloadData()
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
            self.totalTimeArrayForLapList.removeAll()
            self.laps.removeAll()
            self.lapsVal.cycleTime.removeAll()
            self.lapNumber = 0
            self.radioController.selectedButton?.isSelected = false
            self.stopTime = nil
            self.startTime = nil
            self.isPlaying = false
            self.startButton.setTitle("Start", for: .normal)
            self.dataTransfer.lapDataToTransfer.removeAll()
            self.lapListTableView.reloadData()
            
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
                lapButton.backgroundColor = UIColor(red: 0.85, green: 0.11, blue: 0.38, alpha: 1.00)
                resetTimer.isEnabled = false
                resetTimer.backgroundColor = UIColor(red : 0.77, green: 0.87, blue: 0.96, alpha: 1.00)
                saveButton.isEnabled = false
                saveButton.backgroundColor = UIColor(red : 0.77, green: 0.87, blue: 0.96, alpha: 1.00)
                isPlaying = true
                if (modul == 60 ){
                    radioController.buttonsArray[0].isEnabled = false
                }else {
                    radioController.buttonsArray[1].isEnabled = false
                }
                
                break
            case ("Pause"):
                lapButton.isEnabled = false
                lapButton.backgroundColor = UIColor(red : 0.77, green: 0.87, blue: 0.96, alpha: 1.00)
                resetTimer.isEnabled = true
                resetTimer.backgroundColor = UIColor(red: 0.85, green: 0.11, blue: 0.38, alpha: 1.00)
                saveButton.isEnabled = true
                saveButton.backgroundColor  = UIColor(red: 0.85, green: 0.11, blue: 0.38, alpha: 1.00)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapsVal.cycleTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lapCell = self.lapListTableView.dequeueReusableCell(withIdentifier: "lapList", for: indexPath) as! LapListCellTableViewCell
        
        // her ekleme yaparken sayıyı bir arttıracak
        stopTime = lapsVal.setMomentTime()
        
        
        totalTimeArrayForLapList.append( lapsVal.getObservationTime(start: startTime!, end: stopTime!))
        totalTimeArrayForLapList = Array(totalTimeArrayForLapList.reversed())
      
        
        
//        if #available(iOS 14.0, *) {
//            var contentLapList = lapCell.defaultContentConfiguration()
//            var reverseOrderedLaps : [Float] = Array(lapsVal.cycleTime.reversed())
//
//            lapCell.lapValueLabel!.text = (String (format: "%.2f",(reverseOrderedLaps[indexPath.row] * Float( milis))))
//
//            lapCell.lapNumberLabel.text = String (reverseOrderedLaps.count)
//            lapCell.contentConfiguration = contentLapList
//        } else {
            var reverseOrderedLaps : [Float] = Array(lapsVal.cycleTime.reversed())
            
            lapCell.lapValueLabel.text = (String (format: "%.2f",(reverseOrderedLaps[indexPath.row] * Float( milis))))
            lapCell.lapNumberLabel.text = String(lapListLapNumberValue[indexPath.row])
            lapCell.totalTimeLabel.text = totalTimeArrayForLapList[indexPath.row]
            
            
        //}
        
        return lapCell
        
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
