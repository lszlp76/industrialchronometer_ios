//
//  AboutViewController.swift
//  industrialchronometer
//
//  Created by ulas özalp on 3.02.2022.
//

import UIKit

class AboutViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    
    
    var settingIcon = [Section]()
    
    @IBOutlet weak var tableView: UITableView!
    var chosen : ( Int,Int) = (0,0)
    var switchON = false
    
    let userDefaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        let settings = (UserDefaults.standard.bool(forKey: "PauseLap"))
        print("user deafut \(settings)")
    }
    func configureAboutList () {
        
        
        self.settingIcon.append(Section(title: "Settings", option: [SettingIcon(label: "Pause button takes lap when it's triggered",icon: UIImage(named: "pauseLap"), iconBackgroundColor: UIColor.blue,width: 20.0,heigth: 20.0, handler: { print("ulas")},switchHide: true),
                                                                    SettingIcon(label: "ScreenSaver on",icon: UIImage(systemName: "circle"), iconBackgroundColor: UIColor.red, width :20.0,heigth :20.0, handler: {},switchHide: true)
                                                                   ]))
        self.settingIcon.append(Section(title: "About", option: [SettingIcon(label: "Policy",icon: UIImage(named: "pauseLap"), iconBackgroundColor: UIColor.blue,width: 20.0,heigth: 20.0, handler: { print("ulas")},switchHide: false),
                                                                 SettingIcon(label:"About",icon: UIImage(systemName: "circle"), iconBackgroundColor: UIColor.red, width :20.0,heigth :20.0, handler: {},switchHide: false),
                                                                 SettingIcon(label: "Rate App",icon: UIImage(named: "terms"), iconBackgroundColor: UIColor.red,width: 20.0,heigth: 20.0,handler: {},switchHide: false)]))
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureAboutList() // tableview deki ikonları setleme
        
        
        // Do any additional setup after loading the view.
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LapListCellTableViewCell
        
        
        tableView.rowHeight = 50
        
        
        
        cell?.aboutLabel.textColor = UIColor(cgColor: CGColor.init(red: 45/255, green: 34/255, blue: 227/255, alpha: 1))
        cell?.aboutLabel.sizeToFit()
        
        
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
        
      
        
        if settingIcon[indexPath.section].option[indexPath.row].switchHide == false
        {
            cell?.toggleSwitch.isHidden = true
        }
        
        cell?.toggleSwitch.addTarget(self, action: #selector(self.toggleTriggered), for: .primaryActionTriggered)
        
        
        /*üst kapalı alt açık
         
         
         */
        if indexPath.section < 1{
        switch indexPath.row{
    case 0:
        if userDefaults.getValueForSwitch(keyName: "PauseLap") == false
        {
            cell?.toggleSwitch.setOn(false, animated: true) // sayfa açıldığında swici off tutacak
        }else if userDefaults.getValueForSwitch(keyName: "PauseLap") == true {
            cell?.toggleSwitch.setOn(true, animated: true)
        }
           
        case 1:
            if userDefaults.getValueForSwitch(keyName: "ScreenSaver") == false
            {
                cell?.toggleSwitch.setOn(false, animated: true) // sayfa açıldığında swici off tutacak
            }else if userDefaults.getValueForSwitch(keyName: "ScreenSaver") == true {
                cell?.toggleSwitch.setOn(true, animated: true)
            }
       
        default:
            return cell!
        }
            
        }
        
        
        return cell!
        
    }
    @objc func toggleTriggered (_ sender: UISwitch) {
        print("sender \(sender.tag)")
        if sender.tag == 0
        {
           
            NotificationCenter.default.post(name: .pauseLapOff, object: nil)
            
//            if !(sender.isOn) {
//                sender.setOn(false, animated: true)
//
//            }else
//            {
//                sender.setOn(true, animated: true)
//
//            }
        }
        else {
            NotificationCenter.default.post(name: .screenSaverOff, object: nil)
            
           
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        chosen = (indexPath.row,indexPath.section)
        
        if chosen.1 > 0 {
            self.performSegue(withIdentifier: "toWebPage", sender: nil)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WebViewController
        destinationVC.chosen = chosen
        
    }
    
}
