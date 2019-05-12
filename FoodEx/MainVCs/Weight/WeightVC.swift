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

class WeightVC: UIViewController {

    @IBOutlet weak var chart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateChartWithData()
        setupChart()
    }
    
    func setupChart() {
        chart.pinchZoomEnabled = false
        chart.doubleTapToZoomEnabled = false
        chart.dragEnabled = true
        chart.setScaleEnabled(false)
        chart.setVisibleXRangeMaximum(7)
        chart.setVisibleXRangeMinimum(7)

        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.labelPosition = .bottom
        chart.leftAxis.drawLabelsEnabled = false
        chart.legend.enabled = false
        chart.highlightPerTapEnabled = false
    }
    
    func updateChartWithData() {
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0 ..< 30 {
            let value = ChartDataEntry(x: Double(i), y: 70 + Double(i))
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number")
        line1.colors = [UIColor.primary]
        line1.circleColors = [UIColor.primaryDark]
        line1.circleRadius = 2.5
        line1.circleHoleRadius = 0
        let data = LineChartData()
        data.addDataSet(line1)
        chart.data = data
    }
}
