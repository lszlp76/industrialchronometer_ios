//
//  AboutViewController.swift
//  industrialchronometer
//
//  Created by ulas özalp on 3.02.2022.
//

import UIKit
import StoreKit

class AboutViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    
    
    var settingIcon = [Section]()
    
    @IBOutlet weak var tableView: UITableView!
    var chosen : ( Int,Int) = (0,0)
    var switchON : Bool?  // krono çalışmaz ise true olacak. timerStart a göre
    var selectedSwitchIndex: Int?
        
    let userDefaults = UserDefaults.standard
    
    override func willMove(toParent parent: UIViewController?) {
        print("ok")
    }
    func configureAboutList () {
        
        
        self.settingIcon.append(Section(title: "Settings", option: [
            
        
            
            /*SettingIcon(label: "Pause button takes lap when it's triggered",icon: UIImage(named: "pauseLap"), iconBackgroundColor: UIColor.blue,width: 20.0,heigth: 20.0, handler: { },switchHide: true),*/
            
                                                                    SettingIcon(label: "Screen saver on",icon: UIImage(systemName: "circle"), iconBackgroundColor: UIColor.red, width :20.0,heigth :20.0, handler: {},switchHide: true), SettingIcon(label: "Time unit second",icon: UIImage(systemName: "circle"), iconBackgroundColor: UIColor.red, width :20.0,heigth :20.0, handler: {},switchHide: true),
           SettingIcon(label: "Time unit hunderths of minute",icon: UIImage(systemName: "circle"), iconBackgroundColor: UIColor.red, width :20.0,heigth :20.0, handler: {},switchHide: true)
                                                                    
                                                                    
                                                                   ]))
        self.settingIcon.append(Section(title: "General", option: [SettingIcon(label: "Policy",icon: UIImage(named: "terms"), iconBackgroundColor: UIColor.blue,width: 20.0,heigth: 20.0, handler: { },switchHide: false),
                                                                 SettingIcon(label:"About",icon: UIImage(named: "about"), iconBackgroundColor: UIColor.red, width :20.0,heigth :20.0, handler: {},switchHide: false),
                                                                 SettingIcon(label: "Rate App",icon: UIImage(systemName: "star.fill"), iconBackgroundColor: UIColor.red,width: 20.0,heigth: 20.0,handler: {},switchHide: false)]))
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
      
        configureAboutList() // tableview deki ikonları setleme
        
        print("korno kapalı ise switch on true olacak \(TimerStartControl.timerStartControl.timerStarted)")
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
         
        //header.textLabel?.textColor = UIColor(cgColor: CGColor.init(red: 45/255, green: 34/255, blue: 227/255, alpha: 1))
       
        header.textLabel?.font = UIFont(name: "DS-DIGITAL-BOLD", size: 17.0)
   
        
     
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headerTitles = (settingIcon[section].title)
    
        return headerTitles
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingIcon.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingIcon[section].option.count
    }
    @objc func timeUnitOnOFF (){
        switchON = false
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LapListCellTableViewCell
        
        
        tableView.rowHeight = 50
        

        
        //cell?.aboutLabel.textColor = UIColor(cgColor: CGColor.init(red: 45/255, green: 34/255, blue: 227/255, alpha: 1))
        cell?.aboutLabel.sizeToFit()
        cell?.aboutLabel?.font = UIFont(name: "DS-DIGITAL", size: 18.0)
        cell?.aboutLabel?.textColor = UIColor(cgColor: CGColor.init(red: 0/255, green: 117/255, blue: 227/255, alpha: 1))
        
        
        cell?.icon.tintColor = settingIcon[indexPath.section].option[indexPath.row].iconBackgroundColor
        cell?.icon.image =
        settingIcon[indexPath.section].option[indexPath.row].icon
        cell?.icon.frame.size.width =
        CGFloat(settingIcon[indexPath.section].option[indexPath.row].width!)
        cell?.icon.frame.size.height = CGFloat(settingIcon[indexPath.section].option[indexPath.row].heigth!)
        
        cell?.icon.layer.borderColor = UIColor.lightGray.cgColor
        cell?.icon.layer.cornerRadius = 10
        cell?.icon.layer.borderWidth = 0
        cell?.selectionStyle = .none
        cell?.aboutLabel.text = settingIcon[indexPath.section].option[indexPath.row].label
        
        cell?.toggleSwitch.tag = indexPath.row // give tag to each toggle switch
        
        let isSelected = indexPath.row == selectedSwitchIndex
        cell?.toggleSwitch.isOn = isSelected
        
        
        if TimerStartControl.timerStartControl.timerStarted == true {
            cell?.toggleSwitch.isEnabled = false
        }else
        {
            cell?.toggleSwitch.isEnabled = true
        }
       
      
        if settingIcon[indexPath.section].option[indexPath.row].switchHide == false // satırda switch istemiyoruz
        {
            cell?.toggleSwitch.isHidden = true
          
          
        }
        
        cell?.toggleSwitch.addTarget(self, action: #selector(self.toggleTriggered), for: .primaryActionTriggered)
        
        
        /*üst kapalı alt açık
         
         
         */
        if indexPath.section < 1{
        switch indexPath.row{
    
        /*case 0:
        if userDefaults.getValueForSwitch(keyName: "PauseLap") == false
        {
            cell?.toggleSwitch.setOn(false, animated: true) // sayfa açıldığında swici off tutacak
        }else if userDefaults.getValueForSwitch(keyName: "PauseLap") == true {
            cell?.toggleSwitch.setOn(true, animated: true)
        }
         */
           
        case 0:
            if userDefaults.getValueForSwitch(keyName: "ScreenSaver") == false
            {
                cell?.toggleSwitch.setOn(false, animated: true) // sayfa açıldığında swici off tutacak
            }else if userDefaults.getValueForSwitch(keyName: "ScreenSaver") == true {
                cell?.toggleSwitch.setOn(true, animated: true)
          
            }
        case 1 :
            if userDefaults.getValueForSwitch(keyName: "SecondUnit") == true {
                cell?.toggleSwitch.setOn(true, animated: true)
                
            }else {
                cell?.toggleSwitch.setOn(false, animated: true)
            }
        case 2 :
            if userDefaults.getValueForSwitch(keyName: "CminUnit") == true {
                cell?.toggleSwitch.setOn(true, animated: true)
            }else{
                cell?.toggleSwitch.setOn(false, animated: true)
            }
       
        default:
            return cell!
        }
            
        }
        
        
        return cell!
        
    }
    @objc func toggleTriggered (_ sender: UISwitch) {
        
        print("sender \(sender.tag)")
        if sender.tag == 0 {
            NotificationCenter.default.post(name: .screenSaverOff, object: nil)
            
           
        }
        else if sender.tag == 1{
            
        
            
            
            NotificationCenter.default.post(name: .timeUnitSelection, object: nil)
         //   NotificationCenter.default.post(name: .pauseLapOff, object: nil)
//
//           if !(sender.isOn) {
//                sender.setOn(false, animated: true)
//
//            }else
//            {
//                sender.setOn(true, animated: true)
//
//            }
            print("Second ")
        }
       
        else if sender.tag == 2 {
            NotificationCenter.default.post(name: .timeUnitSelection, object: nil)
            
            print("cmin")
        }
        if sender.tag > 0 {
            guard (sender.isOn ) else {
               
                // selectedSwştchIndex i nil yapıyor eğer switch kapatıldı ise
                selectedSwitchIndex = nil
                tableView.reloadData()
                return
            }
            selectedSwitchIndex = sender.tag
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        chosen = (indexPath.row,indexPath.section)
        print(chosen)
        if chosen.1 > 0  && chosen.0 < 2 {
            self.performSegue(withIdentifier: "toWebPage", sender: nil)
        }
        
         else if chosen.0 == 2  && chosen.1 == 1 {
             rateApp()
             print("rate me")
            // link = "itms-apps://itunes.apple.com/app/" + "GZ94AWJKRA"
         }
         
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WebViewController
        destinationVC.chosen = chosen
        
    }
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" +  "GZ94AWJKRA") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
   
}
