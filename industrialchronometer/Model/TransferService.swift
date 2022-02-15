//
//  TransferService.swift
//  industrialchronometer
//
//  Created by ulas özalp on 7.02.2022.
//

import Foundation


class TransferService {
    
    static let sharedInstance = TransferService()
    
    var lapDataToTransfer : [Float] = []
    var timeUnitToTransfer : String = ""
    var fileList : [String] = []
    
    
    func saveTo (name: String , csvString:  String )
    {
        
        //dosyaları bulunduğu yerden alığ bir string dizi yaratıyor.
        // bu diziye daha sonra filelistetableview içinde bir array a atayacaksın
        let fileManager = FileManager.default
      
        do{
            let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)
           
            let defaultFld = path.appendingPathComponent("Industrial Chronometer")
            let defaultFolder = defaultFld.absoluteString
            if !(fileManager.fileExists(atPath: (defaultFolder))){
                try fileManager.createDirectory(at: path.appendingPathComponent("Industrial Chronometer"), withIntermediateDirectories: true, attributes: nil)
            }
            
            let fileURL = defaultFld.appendingPathComponent("\(name).csv")
                //create file
                try csvString.write(to: fileURL, atomically : true , encoding : .utf8 )
                    
               
            print("file created! in \(defaultFld)")
            } catch {
                print ("error creating file -> \(error)")
            }
           
            
          
       
    }
    func getSavedFile () ->  [String] {
        
        let fileManager = FileManager.default
        fileList.removeAll()
        do{
            let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)
           
            let defaultFld = path.appendingPathComponent("Industrial Chronometer")
            
            
            do {
                let items = try fileManager.contentsOfDirectory(at: defaultFld ,includingPropertiesForKeys: nil)
               
                for item in items
                        
                {
                    self.fileList.append(item.lastPathComponent)
                    //print("Found \(item)")
                }
                        
            } catch {
                print ("error reading file -> \(error)")
            }
            
        }catch {
            print ("error reading file -> \(error)")
        }
        return self.fileList
    }
    private init (){}
    
    func deleteDataFile ( fileNameSelected : String){
        
        let fileManager = FileManager.default
    
        do {
            let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)
           
            let defaultFld = path.appendingPathComponent("Industrial Chronometer")
            let defaultFolder = defaultFld.absoluteString
            do {
                let items = try fileManager.contentsOfDirectory(at: defaultFld ,includingPropertiesForKeys: nil)
               
                for item in items
                        
                {
                    if (item.lastPathComponent == fileNameSelected){
                        try fileManager.removeItem(at: item)
                        print("silindi")
                    }
                }
                        
            } catch {
                print ("error reading file -> \(error)")
            }
           
            
        }catch {
            print ("error reading file -> \(error)")
        }
        
        
    }
    func shareFileWith(fileNameSelected: String) -> [Any]{
        
        let fileManager = FileManager.default
        var fileToShare = [Any]()
        do {
            let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)
           
            let defaultFld = path.appendingPathComponent("Industrial Chronometer")
            let defaultFolder = defaultFld.absoluteString
            do {
                let items = try fileManager.contentsOfDirectory(at: defaultFld ,includingPropertiesForKeys: nil)
                
                for item in items
                        
                {
                    if (item.lastPathComponent == fileNameSelected){
                        
                        
                        fileToShare.append(item)
                    }
                }
                
               
            } catch {
                print ("error reading file -> \(error)")
            }
           
            
        }catch {
            print ("error reading file -> \(error)")
        }
        
        return fileToShare
    }
}
