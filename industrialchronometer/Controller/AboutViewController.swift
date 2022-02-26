//
//  AboutViewController.swift
//  industrialchronometer
//
//  Created by ulas özalp on 3.02.2022.
//

import UIKit

class AboutViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    
    
    var settingIcon = [SettingIcon]()
    
    @IBOutlet weak var tableView: UITableView!
    var chosen : ( Int,Int) = (0,0)
    let menu = [["Pause button takes lap when it's triggered"],["Policy","About","Rate App"]]
    var switchON = false
    
    let userDefaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        let settings = (UserDefaults.standard.bool(forKey: "PauseLap"))
        print("user deafut \(settings)")
    }
    func configureAboutList () {
        self.settingIcon =
        [SettingIcon(icon: UIImage(named: "pauseLap"), iconBackgroundColor: UIColor.blue,width: 20.0,heigth: 20.0),
         SettingIcon(icon: UIImage(named: "terms"), iconBackgroundColor: UIColor.red,width: 20.0,heigth: 20.0),
         SettingIcon(icon: UIImage(named: "about"), iconBackgroundColor: UIColor.green,width: 20.0,heigth: 20.0),
         SettingIcon(icon: UIImage(systemName: "star.fill"), iconBackgroundColor: UIColor.orange,width: 20.0,heigth: 20.0)
        
         
        ]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureAboutList() // tableview deki ikonları setleme
        
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let headerTitles = ["Settings", "About"]
        return headerTitles[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LapListCellTableViewCell
        tableView.rowHeight = 50
        
        
        
        //cell?.aboutLabel.textColor = UIColor(cgColor: CGColor.init(red: 45/255, green: 34/255, blue: 227/255, alpha: 1))
        cell?.aboutLabel.sizeToFit()
        
        if indexPath.section == 0 {
            cell?.icon.tintColor = settingIcon[indexPath.row].iconBackgroundColor
            cell?.icon.image = settingIcon[indexPath.row].icon
            cell?.icon.frame.size.width = CGFloat(settingIcon[indexPath.row].width!)
            cell?.icon.frame.size.height = CGFloat(settingIcon[indexPath.row].heigth!)
            cell?.icon.layer.borderColor = UIColor.lightGray.cgColor
            cell?.icon.layer.cornerRadius = 10
            cell?.icon.layer.borderWidth = 0
            cell?.selectionStyle = .none
            

        }else{
            cell?.icon.tintColor = settingIcon[indexPath.row+1].iconBackgroundColor
            cell?.icon.image = settingIcon[indexPath.row+1].icon
            cell?.icon.layer.borderWidth = 0
            cell?.icon.layer.borderColor = UIColor.lightGray.cgColor
            cell?.icon.layer.cornerRadius = 10
            cell?.icon.frame.size.width = CGFloat(settingIcon[indexPath.row+1].width!)
            cell?.icon.frame.size.height = CGFloat(settingIcon[indexPath.row+1].heigth!)
           
        }
        
        
        
        
        
        if userDefaults.getValueForSwitch() == false
        {
            cell?.toggleSwitch.setOn(false, animated: true) // sayfa açıldığında swici off tutacak
        }else if userDefaults.getValueForSwitch() == true {
            cell?.toggleSwitch.setOn(true, animated: true)
        }
        cell?.aboutLabel.text = self.menu[indexPath.section][indexPath.row]
        if (indexPath.section == 1) {
            cell?.toggleSwitch.isHidden = true
            
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
   
        chosen = (indexPath.row,indexPath.section)
        
        if chosen != (0,0) {
            self.performSegue(withIdentifier: "toWebPage", sender: nil)
        }else
        {
            
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WebViewController
        destinationVC.chosen = chosen
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
/*
 gönderilecek notification
 */

