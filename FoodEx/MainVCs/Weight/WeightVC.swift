//
//  PausePlanVC.swift
//  FoodEx
//
//  Created by Ivan Taranov on 3/27/19.
//  Copyright © 2019 KorLab. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip
import Charts
import NumberPicker

class WeightVC: UIViewController {

    @IBOutlet weak var chart: LineChartView!
    @IBOutlet weak var startWeightL: UILabel!
    @IBOutlet weak var currentWeightL: UILabel!
    @IBOutlet weak var totalLossL: UILabel!
    @IBOutlet weak var daysSinceStartL: UILabel!
    @IBOutlet weak var dietDaysL: UILabel!
    @IBOutlet weak var missedDays: UILabel!
    
    private var firstWeightRecord: WeightRecord? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChart()
    }
    
    func setupChart() {
        chart.pinchZoomEnabled = false
        chart.doubleTapToZoomEnabled = false
        chart.setScaleEnabled(false)

        chart.xAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawGridLinesEnabled = true
        chart.leftAxis.drawGridLinesEnabled = false
        chart.xAxis.labelPosition = .bottom
        chart.leftAxis.drawLabelsEnabled = false
        chart.legend.enabled = false
        chart.highlightPerTapEnabled = true
        
        chart.xAxis.valueFormatter = self
//        chart.xAxis.axisMinLabels = 1
        
//        chart.xAxis.setLabelsToSkip(1)
    }
    
    func updateChartWithData(_ weightRecords: [WeightRecord]) {
        var lineChartEntry = [ChartDataEntry]()
        
        let calendar = Calendar.current
        
        var maximumWeight = 0.0
        var totalPeriod = 0
        // must be sure, that it's really first WeightRecord
        firstWeightRecord = weightRecords[0]
        let firstDate = calendar.startOfDay(for: firstWeightRecord!.date)
        
        for weightRecord in weightRecords {
            // TODO: add support for LB     let kg =
            
            let newDate = calendar.startOfDay(for: weightRecord.date)
            
            let day = calendar.dateComponents([.day], from: firstDate, to: newDate)
            totalPeriod = day.day!
            
            if weightRecord.weight.value > maximumWeight {
                maximumWeight = weightRecord.weight.value
            }
            
            let value = ChartDataEntry(x: Double(day.day!), y: weightRecord.weight.value)
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(entries: lineChartEntry, label: "Number")
        line1.colors = [UIColor.primary]
        line1.circleColors = [UIColor.primaryDark]
        line1.circleRadius = 2.5
        line1.circleHoleRadius = 0
        let data = LineChartData()
        data.addDataSet(line1)
        chart.data = data
        
        
        chart.dragEnabled = true
        chart.xAxis.axisMinimum = -2
        chart.xAxis.axisMaximum = Double(totalPeriod) + 2.0
        chart.rightAxis.axisMaximum = maximumWeight + 10
        chart.setVisibleXRangeMaximum(7)
        chart.setVisibleXRangeMinimum(1)
        
        showLabelsInfo(weightRecords)
    }

    
    func showLabelsInfo(_ weightRecords: [WeightRecord]) {
        if weightRecords.count == 0 {
            return
        }
        
        let latestWeight = weightRecords[weightRecords.count - 1]
        
        startWeightL.text = String(format: "%.01f", (firstWeightRecord?.weight.value)!) + " kg."
        currentWeightL.text =  String(format: "%.01f", (latestWeight.weight.value)) + " kg."
        totalLossL.text = String(format: "%.01f", (firstWeightRecord!.weight.value - latestWeight.weight.value)) + " kg."
        
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: firstWeightRecord!.date)
        let date2 = calendar.startOfDay(for: latestWeight.date)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        let daysSinceStart = components.day
        // TODO: load total diet days amount since start
        let dietDaysTotal = 0
        daysSinceStartL.text = String(daysSinceStart!)
        dietDaysL.text = String(dietDaysTotal)
        missedDays.text = String(daysSinceStart! - dietDaysTotal)
    }
    
    
    @IBAction func onWeightRecordingClicked(_ sender: Any) {
        let numberPicker = NumberPicker(delegate: self, maxNumber: 150.0, step: 0.1) // set max numberне
        numberPicker.bgGradients = [UIColor.primaryDark, UIColor.primaryLighter]
        numberPicker.tintColor = .white
        numberPicker.heading = "Weight, kg."
        numberPicker.defaultSelectedNumber = 70 // set default selected number
        
        self.present(numberPicker, animated: true, completion: nil)
    }
    
    @IBAction func onHelpClicked(_ sender: Any) {
        FireFunctions.callFunction(.getMyWeightHistory, "", callback: {
            response in
            
            let weightRecords = (response["weightRecords"] as! [[String : Any]]).map {WeightRecord(weight: Weight(value: ($0["weight"] as! [String : Any])["value"] as! Double, type: ($0["weight"] as! [String : Any])["type"] as! Int), date: Date(timeIntervalSince1970: $0["date"] as! Double)) }

            self.updateChartWithData(weightRecords)
        })
    }
    
}

extension WeightVC: NumberPickerDelegate {
    
    func selectedNumber(_ number: Double) {
        // TODO: add new weight recording
        // TODO: add LB type support
        FireFunctions.callFunction(.saveNewWeightRecording, ["weight": Weight(value: number, type: 0).dict], callback: { response in
            print(response)
        })
    }
}


extension WeightVC : IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        print(value)
        let format = DateFormatter()
        format.dateFormat = "dd"
        var valueDate = Calendar.current.date(byAdding: .day, value: Int(value), to: firstWeightRecord!.date)
        let formattedDate = format.string(from: valueDate!)
        return formattedDate
    }
}
