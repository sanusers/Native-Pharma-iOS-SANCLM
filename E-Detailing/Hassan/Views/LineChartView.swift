//
//  LineChartView.swift
//  E-Detailing
//
//  Created by San eforce on 30/12/23.
//

import Foundation
import Charts




class CustomValueFormatter:  IndexAxisValueFormatter {
    
    func numberOfDaysInMonth(for date: Date) -> Int? {
        let calendar = Calendar.current
        if let range = calendar.range(of: .day, in: .month, for: date) {
            return range.count
        }
        return nil
    }
    
    
    var dateFormatter: DateFormatter
    var date: [Date]
 
    override init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        date = [Date]()
        super.init()
    }

    
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            // Convert the value to a Date if needed
        
        var dayCountArr = [Int]()

        date.forEach { dateElement in
            let count = numberOfDaysInMonth(for: dateElement)
            dayCountArr.append(count ?? 0)
        }
        

        
       return calculateDayRange(totalDaysArray: dayCountArr, currentDaysArray: [Int(value)])
        }
    

    
}




class LineChartHolderView: BaseView, ChartViewDelegate {
    
    
    var lineChartVC : LineChartVC!
    let lineChartView = LineChartView()
    var values: [ChartDataEntry] = []
    var date = [Date]()
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

    func numberOfDaysInMonth(for date: Date) -> Int? {
        let calendar = Calendar.current
        if let range = calendar.range(of: .day, in: .month, for: date) {
            return range.count
        }
        return nil
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
        lineChartView.dragXEnabled = false
        lineChartView.dragYEnabled = false
        
        
//       values = [
//            ChartDataEntry(x: 5, y: 30),
//            ChartDataEntry(x: 15, y: 45),
//            ChartDataEntry(x: 25, y: 27),
//            ChartDataEntry(x: 30, y: 37)
//            // Add more data entries as needed
//        ]

        var dayCountArr = [Int]()
        
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())

        // January 1st of the current year
        let januaryDate = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1))!

        // February 1st of the current year
        let februaryDate = calendar.date(from: DateComponents(year: currentYear, month: 2, day: 1))!

        // March 1st of the current year
        let marchDate = calendar.date(from: DateComponents(year: currentYear, month: 3, day: 1))!
        
        
        date.append(januaryDate)
        date.append(februaryDate)
        date.append(marchDate)
        
        
        date.forEach { dateElement in
            let count = numberOfDaysInMonth(for: dateElement)
            dayCountArr.append(count ?? 0)
        }
        
        let month1TotalDays = dayCountArr[0]
        let month2TotalDays = dayCountArr[1]
        let month3TotalDays = dayCountArr[2]
        
        let month1Values = [
            ChartDataEntry(x: 5, y: 30),
            ChartDataEntry(x: 15, y: 45),
            ChartDataEntry(x: 25, y: 27),
            ChartDataEntry(x: 30, y: 37)
        ]

        let month2Values = [
            ChartDataEntry(x: Double(5 + month2TotalDays), y: 30), // Increment x values by the total days in a month
            ChartDataEntry(x: Double(15 + month2TotalDays), y: 45),
            ChartDataEntry(x: Double(25 + month2TotalDays), y: 27),
            ChartDataEntry(x: Double(30 + month2TotalDays), y: 37)
        ]

        let month3Values = [
            ChartDataEntry(x: Double(5 + month3TotalDays + month2TotalDays), y: 30), // Increment x values for the third month
            ChartDataEntry(x: Double(15 + month3TotalDays + month2TotalDays), y: 45),
            ChartDataEntry(x: Double(25 + month3TotalDays + month2TotalDays), y: 27),
            ChartDataEntry(x: Double(30 + month3TotalDays + month2TotalDays), y: 37)
        ]
        
        
        values.append(contentsOf: month1Values)
        values.append(contentsOf: month2Values)
        values.append(contentsOf: month3Values) // Add 62 to shift to the third month

        
        
        // Customize X-axis
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.setLabelCount(date.count * 2, force: true) // Set the number of labels

        let xValuesNumberFormatter = CustomValueFormatter()
        xValuesNumberFormatter.date = date
        xAxis.valueFormatter = xValuesNumberFormatter
        lineChartView.xAxis.yOffset = 40
        // Customize the font
        xAxis.labelFont = UIFont(name: "Satoshi-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
        //xAxis.xOffset = 15.0
        // Set the x values date formatter
     
       // xValuesNumberFormatter.dateFormatter = dayNumberAndShortNameFormatter // e.g. "wed 26"
      
        
    
        
        
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
        dataSet.drawValuesEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
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
        yAxis.gridLineDashLengths = [4, 4]  // Adjust the lengths as needed
        yAxis.gridLineDashPhase = 0  // Adjust the phase if needed
     //   yAxis.axisLineColor = .appSelectionColor
        yAxis.gridColor = .appGreyColor
     
      
        
        lineChartView.drawBordersEnabled = false
        lineChartView.drawMarkers = false
        lineChartView.drawGridBackgroundEnabled = false

        // Apply the changes
        lineChartView.notifyDataSetChanged()
        
    }
    
    func setupUI() {
        self.addSubview(lineChartView)
        setupLineChart()

        

    }
    
    
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight)
    {
        print("chartValueSelected : x = \(highlight.x) y = \(highlight.y)")
//        var set1 = LineChartDataSet()
//        set1 = (chartView.data?.dataSets[0] as? LineChartDataSet)!
//        set1.setCircleColor(NSUIColor.appGreen)
//        set1.circleHoleColor = .appWhiteColor
        

        
        let index = values.firstIndex(where: {$0.x == highlight.x}) ?? 0  // search index
        
        
        let selectedChartDataEntry = [values[index]]

        let selecteddataSet = LineChartDataSet(entries: selectedChartDataEntry, label: "")
        selecteddataSet.drawValuesEnabled = false
        selecteddataSet.drawVerticalHighlightIndicatorEnabled = false
        selecteddataSet.drawHorizontalHighlightIndicatorEnabled = false
        selecteddataSet.setCircleColor(.appGreen)
        selecteddataSet.circleHoleColor =  .appTextColor
        selecteddataSet.circleRadius = 10
        selecteddataSet.colors = [NSUIColor.appTextColor]
       // let selecteddata = LineChartData(dataSet: selecteddataSet)
        
      //  values.remove(at: index)
        let exsistingdataSet = LineChartDataSet(entries: values, label: "")
        exsistingdataSet.drawValuesEnabled = false
        exsistingdataSet.drawVerticalHighlightIndicatorEnabled = false
        exsistingdataSet.drawHorizontalHighlightIndicatorEnabled = false
        exsistingdataSet.setCircleColor(.appTextColor)
        exsistingdataSet.circleHoleColor =  .appTextColor
        exsistingdataSet.circleRadius = 5
        exsistingdataSet.colors = [NSUIColor.appTextColor]
      //  let exsistingselected = LineChartData(dataSet: exsistingdataSet)
        
      //  values.add(selectedChartDataEntry, at: [index])

        
        
        // Create a LineChartData object and add datasets to it
        let data = LineChartData(dataSets:[selecteddataSet, exsistingdataSet])

        chartView.data = data
   
        chartView.notifyDataSetChanged()
        
      
        
         let dataSetIndex = index

//        guard let dataSet = chartView.data?.dataSets[dataSetIndex] as? LineChartDataSet else {
//            return
//        }
      
        if let lineChartView = chartView as? LineChartView {
            // Get the transformer for the left axis
            let transformer = lineChartView.getTransformer(forAxis: .left)

            // Transform the entry coordinates to pixel coordinates
            let point = transformer.pixelForValues(x: entry.x, y: entry.y)

            // Create a custom view or overlay at the pixel position
            let customView = UIView(frame: CGRect(x: point.x, y: point.y, width: 5, height: 5))
            customView.backgroundColor = UIColor.clear

            lineChartView.subviews.forEach { $0.removeFromSuperview() }
            
            // Add the custom view to the chart view or its superview
            lineChartView.addSubview(customView)
            
            toShoPopup(customView)
        }
        
        
          //  toShoPopup(rectOfSelectedDataPoint)
    }
    
    public func chartValueNothingSelected(_ chartView: ChartViewBase)
    {
        print("chartValueNothingSelected")

    }
    
    
    func toShoPopup(_ view: UIView) {
        
        print("Tapped -->")
        let vc = PopOverVC.initWithStory(preferredFrame: CGSize(width: lineChartView.width / 2.7 , height: lineChartView.height / 5), on: view, onframe: CGRect(), pagetype: .HomeGraph)
               // vc.delegate = self
               // vc.selectedIndex = indexPath.row
                self.lineChartVC.navigationController?.present(vc, animated: true)
    }
    
}


extension Array  {

    mutating func add(_ newElement: Element, at indexes: [Int]) {

        for index in indexes {
            insert(newElement, at: index)
        }
    }
}



func calculateDayRange(totalDaysArray: [Int], currentDaysArray: [Int]) -> String{
    
    var returnStr = ""
    for (index, totalDays) in totalDaysArray.enumerated() {
        guard index < currentDaysArray.count else {
            // Handle the case where there are not enough elements in currentDaysArray
            continue
        }

        let currentDay = currentDaysArray[index]

        // Calculate the adjusted day for the current month
        let adjustedDay = currentDay % totalDays

        // Determine the end day of the range based on the total days in the month
        let endDay = totalDays / 2

        // Check if the adjusted day falls in the range of 01 to 15 or 16 to the end of the month
        if adjustedDay >= 1 && adjustedDay <= 15 {
            print("Month \(index + 1): Day is in the range 01 to 15")
            returnStr = "01st - 15th"
        } else if adjustedDay >= 16 && adjustedDay <= totalDays {
            print("Month \(index + 1): Day is in the range 16 to \(totalDays)")
            returnStr = "16th - \(totalDays)th"
            
        } else {
            print("Month \(index + 1): Invalid day value")
            returnStr = ""
        }
    }
    
    return returnStr
}
