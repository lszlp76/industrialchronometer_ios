//
//  FileListViewController.swift
//  industrialchronometer
//
//  Created by ulas özalp on 10.02.2022.
//

import UIKit

class FileListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate{
    
    let refreshControl = UIRefreshControl() // pulldown updating için
    var fileListArray : [String] = []
    @IBOutlet weak var fileList: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        fileList.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fileList.delegate = self
        fileList.dataSource = self
        
        fileListArray =  TransferService.sharedInstance.getSavedFile()
        
       
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        fileList.addSubview(refreshControl)
        
        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        longPressGesture.minimumPressDuration = 1.0
        longPressGesture.delegate = self
        self.fileList.addGestureRecognizer(longPressGesture)
        
        fileList.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func shareFiles(fileNameSelected : String){
       
        // Make the activityViewContoller which shows the share-view
        let activityViewController = UIActivityViewController(activityItems: TransferService.sharedInstance.shareFileWith(fileNameSelected: fileNameSelected), applicationActivities: nil)

        // Show the share-view
        self.present(activityViewController, animated: true, completion: nil)
    }
    @objc func refresh(){
        print("refreshing")
        fileList.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.fileList.dequeueReusableCell(withIdentifier: "fileNameCell", for: indexPath)
        
        cell.textLabel?.text = fileListArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var fileNameSelected = fileListArray[indexPath.row]
        shareFiles(fileNameSelected: fileNameSelected)
        
    }
    
    @objc func longPress(_ longPressGestureRecognizer : UILongPressGestureRecognizer){
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: fileList)
            if let indexPath = fileList.indexPathForRow(at: touchPoint) {
                let fileNameSelected = fileListArray[indexPath.row]
                fileListArray.remove(at: indexPath.row) // dosya adı seçliir
                
                let alert = UIAlertController (title: "File Delete", message: "You will lose your \(fileNameSelected) file" ,preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { UIAlertAction in
                    TransferService.sharedInstance.deleteDataFile (fileNameSelected: fileNameSelected)
                    self.fileList.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
