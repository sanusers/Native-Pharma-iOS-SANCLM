//
//  LineChartView.swift
//  E-Detailing
//
//  Created by San eforce on 30/12/23.
//

import Foundation
import Charts




class CustomValueFormatter:  IndexAxisValueFormatter {
    var dateFormatter: DateFormatter
    var date: Date
    override init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        date = Date()
        super.init()
    }

//    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {

//      }
    
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        

        // Extract the day from the date
        let day = Calendar.current.component(.day, from: date)

        // Get the number of days in the month
        let range = Calendar.current.range(of: .day, in: .month, for: date)
        let daysInMonth = range?.count ?? 31

        let intValue = Int(value)

        

         if intValue >= 1 && intValue <= 15 {
            return "01st - 15th"
        } else if intValue >= 16 && intValue <= 29 {
            return "16th - \(daysInMonth)th"
        } else {
            return ""
        }
    }
}




class LineChartHolderView: BaseView, ChartViewDelegate {
    var lineChartVC : LineChartVC!
    let lineChartView = LineChartView()

    override func didLoad(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.lineChartVC = baseVC as? LineChartVC
        setupUI()
    }
    
    override func didLayoutSubviews(baseVC: BaseViewController) {
        super.didLoad(baseVC: baseVC)
        self.lineChartVC = baseVC as? LineChartVC
        lineChartView.frame = CGRect(x: self.width / 2 - (self.width / 2) / 2 , y: self.width / 2 - (self.height / 2) / 2, width: self.width / 2, height: self.height / 2)
    }
    
    
    func setupLineChart() {
        lineChartView.delegate = self
        lineChartView.legend.enabled = false
        // Sample data
        let values: [ChartDataEntry] = [
            ChartDataEntry(x: 2, y: 30),
            ChartDataEntry(x: 16, y: 40),
            // Add more data entries as needed
        ]

        // Customize X-axis
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.setLabelCount(2, force: true) // Set the number of labels
        xAxis.axisMinimum = 1
        xAxis.axisMaximum = 30
      //  xAxis.valueFormatter = CustomValueFormatter()
        

        // Customize the font
        xAxis.labelFont = UIFont(name: "Satoshi-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
        xAxis.xOffset = 15.0
        // Set the x values date formatter
        let xValuesNumberFormatter = CustomValueFormatter()
       // xValuesNumberFormatter.dateFormatter = dayNumberAndShortNameFormatter // e.g. "wed 26"
        xAxis.valueFormatter = xValuesNumberFormatter
        
        // Customize Y-axis
        // Access the y-axis of your line chart view
        let yAxis = lineChartView.leftAxis // You can use `rightAxis` if needed
        
        yAxis.labelCount = 5 // Set the number of labels
        yAxis.axisMinimum = 20 // Adjust minimum value
        yAxis.axisMaximum = 100 // Adjust maximum value
        
        
        yAxis.labelFont = UIFont(name: "Satoshi-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)

        let dataSet = LineChartDataSet(entries: values, label: "")
        let data = LineChartData(dataSet: dataSet)
        dataSet.setCircleColor(.appTextColor)
        dataSet.circleHoleColor = .appTextColor
        dataSet.circleRadius = 5
        dataSet.colors = [NSUIColor.appTextColor]
        // Customize other properties of the data set if needed
        dataSet.lineWidth = 1.0  // Set the width of the line
        lineChartView.data = data
        

        // Disable drawing grid lines
        let limitLine = ChartLimitLine(limit: 0, label: "")
        limitLine.lineColor = UIColor.clear
        limitLine.lineWidth = 0

        lineChartView.rightAxis.addLimitLine(limitLine)
        lineChartView.leftAxis.addLimitLine(limitLine)
        
        xAxis.accessibilityElementsHidden = true
        yAxis.accessibilityElementsHidden = true
        xAxis.drawGridLinesEnabled = false
     //   xAxis.drawLabelsEnabled = false
      
        // Disable drawing grid lines
        yAxis.drawGridLinesEnabled = false
      //  yAxis.drawLabelsEnabled = false

        // Apply the changes
        lineChartView.notifyDataSetChanged()
        
    }
    

    
    func setupUI() {
        self.addSubview(lineChartView)
        setupLineChart()

        

    }
    
    // Implement the chartValueSelected method to handle tap actions
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        // Iterate through data sets to find the one that corresponds to the highlight
        for set in chartView.data?.dataSets ?? [] {
            if let lineDataSet = set as? LineChartDataSet {
               let entryIndex = lineDataSet.entryIndex(entry: entry)
                    // Handle tap action for the data set circle
                print("Tapped on data set circle in set: \(entry) in set: \(set.label ?? "")")
                print("Tapped -->")
                let vc = PopOverVC.initWithStory(preferredFrame: CGSize(width: 300, height: 200), on: chartView, pagetype: .HomeGraph)
               // vc.delegate = self
               // vc.selectedIndex = indexPath.row
                self.lineChartVC.navigationController?.present(vc, animated: true)
                
               
            }
        }
    }
    
    
    func toShoPopup() {
        
   
    }
    
}
