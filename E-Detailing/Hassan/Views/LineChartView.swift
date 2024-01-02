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

    
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            // Convert the value to a Date if needed
            let date = Date(timeIntervalSince1970: value)

            // Extract the day from the date
            let day = Calendar.current.component(.day, from: date)

            // Get the number of days in the month
            let range = Calendar.current.range(of: .day, in: .month, for: date)
            let daysInMonth = range?.count ?? 31

            // Determine the label based on the day
            var label = ""
            if value >= 1 && value <= 15 {
                label = "01st - 15th"
            } else if value > 15 && Int(value) <= daysInMonth {
                label = "16th - \(daysInMonth)th"
            }

            return label
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
    
   func toAddCustomXaxis() {
       let overlayView = UIView()
       overlayView.backgroundColor = .appTextColor // Customize the overlay view's background color
       overlayView.translatesAutoresizingMaskIntoConstraints = false
       self.addSubview(overlayView)
       NSLayoutConstraint.activate([
        overlayView.topAnchor.constraint(equalTo: lineChartView.bottomAnchor, constant: -35), // Adjust this constraint based on your layout
           overlayView.leadingAnchor.constraint(equalTo: lineChartView.leadingAnchor, constant: +25),
           overlayView.trailingAnchor.constraint(equalTo: lineChartView.trailingAnchor, constant: -10),
           overlayView.heightAnchor.constraint(equalToConstant: 1)
       ])
       
    }

    
    
    func setupLineChart() {
        toAddCustomXaxis()
       // toAddCustomXaxis()
        
        lineChartView.delegate = self
        lineChartView.legend.enabled = false
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.scaleXEnabled = false
        lineChartView.scaleYEnabled = false
        // Sample data
        
        
        
        let values: [ChartDataEntry] = [
            ChartDataEntry(x: 2, y: 30),
            ChartDataEntry(x: 10, y: 40),
            ChartDataEntry(x: 20, y: 35),
            ChartDataEntry(x: 30, y: 45)
            // Add more data entries as needed
        ]

        // Customize X-axis
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.setLabelCount(4, force: true) // Set the number of labels
        xAxis.axisMinimum = 1
        xAxis.axisMaximum = 30
      //  xAxis.valueFormatter = CustomValueFormatter()
        
        lineChartView.xAxis.yOffset = 40
        lineChartView.xAxis.spaceMin = 20
        lineChartView.xAxis.spaceMax = 20
        // Customize the font
        xAxis.labelFont = UIFont(name: "Satoshi-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
        //xAxis.xOffset = 15.0
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
        

        //to hide x , y indicator axis - labels
        yAxis.drawLabelsEnabled = true
        xAxis.drawLabelsEnabled = true
      
        
        //to hide x , y indicator axis - lines
          yAxis.drawAxisLineEnabled = false
          xAxis.drawAxisLineEnabled = false
          lineChartView.rightAxis.enabled = false
        
        //to hide x , y indicator axis - grid lines
        yAxis.drawGridLinesEnabled = true
        xAxis.drawGridLinesEnabled = false
        yAxis.gridLineWidth = 1
        lineChartView.gridBackgroundColor = .appSelectionColor
        
        // Configure the grid lines to be dotted
        yAxis.gridLineDashLengths = [3, 3]  // Adjust the lengths as needed
        yAxis.gridLineDashPhase = 0  // Adjust the phase if needed
        
     
      
        
        lineChartView.drawBordersEnabled = false
        lineChartView.drawMarkers = false
        lineChartView.drawGridBackgroundEnabled = false
        
   
       
   
 

    
        
        // Apply the changes
        lineChartView.notifyDataSetChanged()
        
    }
    

    
    
    //        // Disable drawing grid lines
    //        let limitLine = ChartLimitLine(limit: 0, label: "")
    //        limitLine.lineColor = UIColor.clear
    //        limitLine.lineWidth = 0
    //
    //        lineChartView.rightAxis.addLimitLine(limitLine)
    //        lineChartView.leftAxis.addLimitLine(limitLine)
    //
    //        xAxis.accessibilityElementsHidden = true
    //        yAxis.accessibilityElementsHidden = true
    
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

               
            }
        }
    }
    
    
    func toShoPopup() {
        
      //  print("Tapped -->")
//                let vc = PopOverVC.initWithStory(preferredFrame: CGSize(width: 300, height: 200), on: chartView, pagetype: .HomeGraph)
//               // vc.delegate = self
//               // vc.selectedIndex = indexPath.row
//                self.lineChartVC.navigationController?.present(vc, animated: true)
    }
    
}
