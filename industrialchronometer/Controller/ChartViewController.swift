//
//  ChartViewController.swift
//  industrialchronometer
//
//  Created by ulas özalp on 3.02.2022.
//

import UIKit
import Charts
import TinyConstraints

class ChartViewController: UIViewController {
    
    
    var lineChartView : LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBackground
        return chartView
    }()
    //  let button :UIButton = UIButton (frame: CGRect (x: 100, y: 100, width:150 , height: 180))
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(functionName), name: Notification.Name("NewFunctionName"), object: nil)
        
        
    setData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
           self.view.addSubview(lineChartView)
            lineChartView.centerInSuperview()
            lineChartView.width(to: self.view)
            lineChartView.heightToWidth(of: self.view)
        
    }
    @objc func functionName (notification: NSNotification){
       
        lineChartView.clearValues()
        lineChartView.leftAxis.removeAllLimitLines()
        lineChartView.setNeedsDisplay()
    
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("Entrii\(entry)")
    }
    
    
    
    func setData(){
        
        
        
        var dataFromChrono: [Float]
        dataFromChrono = TransferService.sharedInstance.lapDataToTransfer
        print("değer \(dataFromChrono)")
        if  dataFromChrono.count != 0
        {
            var YValues : [ChartDataEntry] = [ChartDataEntry(x: 0.0, y: 0.0)]//
            var x = 0.0
            var sumData = 0.0
            
            print("değer \(dataFromChrono)")
           
         
            
            while Int(x) < dataFromChrono.count {
                YValues.append(ChartDataEntry (x: x+1, y: Double(dataFromChrono[Int(x)])))
                
                sumData += Double(dataFromChrono[Int(x)])
                
                x += 1
            }
            var meanData = ( (sumData) / Double((dataFromChrono.count)) )  //ilk data 0.0 olduğu için
            let set1 = LineChartDataSet (entries: YValues, label: "Cycle time" )
            
            let data = LineChartData(dataSet: set1)
            
            var tmax, tmin, tave : ChartLimitLine
            
            tmax = ChartLimitLine (limit: Double(dataFromChrono.max()!), label: "Max.Cyc Time")
            tmin = ChartLimitLine (limit: Double(dataFromChrono.min()!),label: "Min.Cyc Time")
            tave = ChartLimitLine(limit: Double(meanData), label: "Mean Cycle Time")
            
            tmax.lineWidth = 2.0
            tmin.lineWidth = 1.0
            tave.lineWidth = 1.0
            tave.lineColor = UIColor.green
            tmax.lineColor = UIColor.red
            tmin.lineColor = UIColor.red
            print("max değer \(dataFromChrono.max()!*100)")
            let yAxis = lineChartView.leftAxis
            yAxis.removeAllLimitLines()
            yAxis.addLimitLine(tmax)
            yAxis.addLimitLine(tmin)
            yAxis.addLimitLine(tave)
            yAxis.drawLimitLinesBehindDataEnabled = true
            
            lineChartView.data = data
            
        }
        
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
