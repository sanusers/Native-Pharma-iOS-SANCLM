//
//  HomeLineChartView.swift
//  E-Detailing
//
//  Created by San eforce on 04/01/24.
//

import Foundation
import UIKit
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
    var valueArr : [Int]
    override init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        date = [Date]()
        valueArr = [Int]()
        super.init()
    }


    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            // Convert the value to a Date if needed
        var returnStr = [String]()
        var returnStrIndex = [Int]()
        var dayCountArr = [Int]()
        var tempDate = date
        var removedIndex = Int()
        
        
        date.enumerated().forEach { dateElementIndex, dateElement in
                returnStrIndex.append(dateElementIndex)
        }
        
        returnStrIndex.reversed().forEach { index in
           let aDate = tempDate[index]
           let count = numberOfDaysInMonth(for: aDate)
           returnStr.append("01st - 15th    16th - \(count!)th")
           // tempDate.remove(at: index)
           // removedIndex = index
        }

        guard let axis = axis else {
            return ""
        }

        // Get the entries (values) for the labels
        let entries = axis.entries

        // Find the index of the current value in the entries array
        if let currentIndex = entries.firstIndex(of: value) {
            // Do something based on the current index
            print("Current index: \(currentIndex)")
            return returnStr[currentIndex]
        }
      return ""

        }



}

class HomeLineChartView: UIView, ChartViewDelegate {
    
    var viewController : UIViewController?
    let lineChartView = LineChartView()
    var values: [ChartDataEntry] = []
    var date = [Date]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
       // self.addCustomView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineChartView.frame = self.bounds
        //CGRect(x: 10, y: self.width / 2 - (self.height / 2) / 2, width: self.width - 20, height: self.height / 2)
        
    }
    
    func setupUI() {
        self.addSubview(lineChartView)
        setupLineChart()

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
        
        _ = dayCountArr[0]
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
        
        xAxis.granularityEnabled = true
        xAxis.granularity = 10
       // xAxis.axisMinimum = 0
        //xAxis.axisMaximum = 7
        xAxis.centerAxisLabelsEnabled = true
        lineChartView.autoScaleMinMaxEnabled = true
        lineChartView.extraLeftOffset = 10.0
        lineChartView.extraRightOffset = 10.0
        xAxis.wordWrapEnabled = false
        
        
        xAxis.setLabelCount(date.count, force: true) // Set the number of labels

        let xValuesNumberFormatter = CustomValueFormatter()
        xValuesNumberFormatter.date = date

        var valueArr = [Int]()


        month1Values.forEach { dataEntry in
            valueArr.append(Int(dataEntry.x))
        }

        month2Values.forEach { dataEntry in
            valueArr.append(Int(dataEntry.x))
        }

        month3Values.forEach { dataEntry in
            valueArr.append(Int(dataEntry.x))
        }



        xValuesNumberFormatter.valueArr = valueArr
        xAxis.valueFormatter = xValuesNumberFormatter

        
        lineChartView.xAxis.yOffset = 40
        // Customize the font
        xAxis.labelFont = UIFont(name: "Satoshi-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)

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
        let vc = PopOverVC.initWithStory(preferredFrame: CGSize(width: lineChartView.width / 3.5 , height: lineChartView.height / 3.7), on: view, onframe: CGRect(), pagetype: .HomeGraph)
               // vc.delegate = self
               // vc.selectedIndex = indexPath.row
            self.viewController?.navigationController?.present(vc, animated: true)
    }
    
    func toAddCustomXaxis() {
        let overlayView = UIView()
        overlayView.backgroundColor = .appSelectionColor // Customize the overlay view's background color
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(overlayView)
        NSLayoutConstraint.activate([
         overlayView.topAnchor.constraint(equalTo: lineChartView.bottomAnchor, constant: -35), // Adjust this constraint based on your layout
            overlayView.leadingAnchor.constraint(equalTo: lineChartView.leadingAnchor, constant: +40),
            overlayView.trailingAnchor.constraint(equalTo: lineChartView.trailingAnchor, constant: -10),
            overlayView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
     }

     func numberOfDaysInMonth(for date: Date) -> Int? {
         let calendar = Calendar.current
         if let range = calendar.range(of: .day, in: .month, for: date) {
             return range.count
         }
         return nil
     }
}
