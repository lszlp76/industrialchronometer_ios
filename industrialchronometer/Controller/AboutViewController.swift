//
//  AboutViewController.swift
//  industrialchronometer
//
//  Created by ulas özalp on 3.02.2022.
//

import UIKit

class AboutViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    var chosen : ( Int,Int) = (0,0)
    let menu = [["Pause button takes lap when it's triggered"],["Policy","About","Rate App"]]
    var switchON = false
    
    let userDefaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        let settings = (UserDefaults.standard.bool(forKey: "PauseLap"))
        print("user deafut \(settings)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
       
      

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
        
        print("index no \(indexPath.row) \(indexPath.section)")
        chosen = (indexPath.row,indexPath.section)
         
        if chosen != (0,0) {
             self.performSegue(withIdentifier: "toWebPage", sender: nil)
         }else
         {
             // do nothing just toggleSwtch will function here
           
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

