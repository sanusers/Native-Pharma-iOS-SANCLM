//
//  HomeVC.swift
//  E-Detailing
//
//  Created by PARTH on 21/04/23.
//

import UIKit
import FSCalendar
import UICircularProgressRing
import Charts

class HomeVC: UIViewController {
    
    @IBOutlet weak var collection_Layout: UICollectionViewFlowLayout! {
        didSet {
            
            collection_Layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }

    //MARK: - OUTLETS..............!!
    @IBOutlet weak var details_View: UIView!
    @IBOutlet weak var profile_setUp_Back: UIView!
    @IBOutlet weak var profile_set_View: UIView!
    @IBOutlet weak var background_View: UIView!
    @IBOutlet weak var btn_notifiction: UIButton!
    @IBOutlet weak var btn_refresh: UIButton!
    @IBOutlet weak var btn_profile: UIButton!
    @IBOutlet weak var celender_View: UIView!
    @IBOutlet weak var sengment_View: UIView!
    @IBOutlet weak var sengment_Controller: UISegmentedControl!
    @IBOutlet weak var table_View: UIView!
    @IBOutlet weak var UITable: UITableView!
    @IBOutlet weak var call_Table_View: UIView!
    @IBOutlet weak var call_Table: UITableView!
    @IBOutlet weak var btn_Add_Call: UIButton!
    @IBOutlet weak var btn_Add_Activity: UIButton!
    @IBOutlet weak var btn_Final_sub: UIButton!
    @IBOutlet weak var btn_table_refresh: UIButton!
    @IBOutlet weak var outBox_View: UIView!
    @IBOutlet weak var btn_clear_call: UIButton!
    @IBOutlet weak var outBox_Table: UITableView!
    @IBOutlet weak var char_View: LineChartView!
    @IBOutlet weak var btn_presentation: UIButton!
    @IBOutlet weak var btn_activity: UIButton!
    @IBOutlet weak var btn_resports: UIButton!
    @IBOutlet weak var menu_Table: UITableView!
    @IBOutlet weak var menu_View: UIView!
    @IBOutlet weak var menu_Hide: NSLayoutConstraint!
    @IBOutlet weak var menu_width: NSLayoutConstraint!
    @IBOutlet weak var menu_Table_View: UIView!
    @IBOutlet var doctor_Call_View: UIView!
    @IBOutlet weak var chemist_Call_View: UIView!
    @IBOutlet weak var stockiest_Call_View: UIView!
    @IBOutlet weak var celender_background: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var btn_celender: UIButton!
    @IBOutlet var isSelcted: [UIImageView]!
    @IBOutlet weak var doc_Call: UICircularProgressRing!
    @IBOutlet weak var chemist_Calls: UICircularProgressRing!
    @IBOutlet weak var stocki_Calls: UICircularProgressRing!
    @IBOutlet weak var profile_Image: UIImageView!
    @IBOutlet var lbl_Count: [UILabel]!
    @IBOutlet weak var chart_Background: UIView!
    @IBOutlet weak var btn_next_month: UIButton!
    @IBOutlet weak var btn_pre_month: UIButton!
    @IBOutlet weak var event_Collection: UICollectionView!
    @IBOutlet var btn_tags: [UIButton]!
    @IBOutlet weak var lbl_Chart_Title: UILabel!
    @IBOutlet weak var btn_Menu_Open: UIButton!
    @IBOutlet var outletArr: [UIButton]!
    
    var marker = MarkerView()
    
    // For temporery....!!
    var isDoc = false
    var isChemist = false
    var isStock = false
    
    // Some array for Local Database
    let arrImage = [UIImage(named: "tourplan"),UIImage(named: "calls"),UIImage(named: "gallery"),UIImage(named: "dateentry"),UIImage(named: "application"),UIImage(named: "report_black"),UIImage(named: "nearme")]
    let arrTitle = ["Tour Plan","Calls","Create Presentation","Missed date Entry","Leave Applicatiuon","Report","Near Me"]
    let eventArr = ["Weekly off","Field Work","Non-Field Work","Holiday","Missed Released","Missed","Re Entry","Leave","TP Devition Released","TP Devition","Leave Aprroval Pending","Approval Pending"]
    var arrName = ["Aravind Raj","Tom Latham","Dharany","Shiva Mehta","Saheb Das"]
    
    // Array for Chart Data..........!!
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    let doc_Data = [20.0,40.0,25.0,60.0,40.0,70.0]
    let chemist_Data = [50.0,20.0,60.0,70.0,10.0,15.0]
    let stock_Data = [30.0,40.0,45.0,20.0,10.0,14.6]
    
    // Event Dates..............!!
    var datesWithEvent = ["2023-10-03", "2023-04-06", "2023-05-12", "2023-03-25"]
    var datesWithMultipleEvents = ["2023-04-08", "2023-05-16", "2023-06-20", "2023-05-28"]

    // Date formate..........!!
    fileprivate lazy var dateFormatter2: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }()
    
    // Menu Buttons........!!
//    private lazy var edit = UIAction(title: "Edit") { action in
//        print("Edit")
//    }
//    private lazy var delete = UIAction(title: "Delete") { [self] action in
//        print("Delete")
//    }
//    private lazy var element : [UIAction] = [edit,delete]
    
    var isDelete = false
    
    var currentMonth = Date() {
        didSet {
            update()
        }
    }

    
//MARK: - View Did Load..............!!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_Menu_Open.setImage(UIImage(named: "Menu"), for: .normal)
        outletArr.forEach({$0.setTitle("", for: .normal)}) // Remove Button Title
        outBox_Table.estimatedRowHeight = 80
        outBox_Table.rowHeight = UITableView.automaticDimension
        
        if #available(iOS 15.0, *) {
            outBox_Table.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        
        self.hideKeyboardWhenTappedAround()
        self.setChart(dataPoints: months, values : doc_Data)
        self.tap_On_View()
        self.segment()
        self.calender()
        self.progressView()
        self.properties()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setUpMoreBtnAlert(sourceView:UIView){
        
        let alertVc = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertVc.modalPresentationStyle = .popover
        alertVc.addAction(UIAlertAction(title: "Edit", style: .default,handler: { action in
            
        }))
        
        alertVc.addAction(UIAlertAction(title: "Delete", style: .destructive,handler: { action in
            
        }))
        
        if let popoverController = alertVc.popoverPresentationController {
            popoverController.sourceView = sourceView //to set the source of your alert
            popoverController.sourceRect = sourceView.bounds // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
            self.present(alertVc, animated: true)
        }
        else
        {
            self.present(alertVc, animated: true)
        }
    }
    
//MARK: - Actions.......................!!
    
    // Btn Action............................................>!!
    
    
    @IBAction func notificationAction(_ sender: UIButton) {
        
        let leaveVC = UIStoryboard.mainVC
        self.navigationController?.pushViewController(leaveVC, animated: true)
        
    }
    
    
    @IBAction func masterSyncAction(_ sender: UIButton) {
        
        let masterSyncVC = UIStoryboard.masterSyncVC
        self.navigationController?.pushViewController(masterSyncVC, animated: true)
        
       // self.present(masterSyncVC, animated: true)
    }
    
    // Seg Action............................................>!!
    @IBAction func seg_Action(_ sender: UISegmentedControl) {
        
        sengment_Controller.underlinePosition()
        if sengment_Controller.selectedSegmentIndex == 0 {
            
            UITable.isHidden = false
            [outBox_View,call_Table_View].forEach({$0.isHidden = true})
            
        } else if sengment_Controller.selectedSegmentIndex == 1 {
            
            [UITable,outBox_View].forEach({ $0?.isHidden = true})
            call_Table_View.isHidden = false
            
        } else {
            
            [UITable,call_Table_View].forEach({$0?.isHidden = true})
            outBox_View.isHidden = false
        }
    }
    
    
    // Table Reload Action.....................................>!!
    @IBAction func table_Reload_Action(_ sender: UIButton) {
        
        DispatchQueue.main.async { [self] in
            call_Table.reloadData()
        }
    }
    
    @IBAction func click_onClosebtn(_ sender: Any) {
        profile_setUp_Back.isHidden = true
    }
    
    // Menu Action............................................>!!
    @IBAction func menu_Action(_ sender: UIButton) {
        
        if sender.imageView?.image == UIImage(named: "Menu") {
            
            menu_View.isHidden = false
            UIView.transition(with: sender as UIView, duration: 0.5, options: .transitionFlipFromRight, animations: { [self] in
                [menu_View,menu_Table_View].forEach({$0.alpha = 1})
                menu_Hide.constant = 0
                menu_width.constant = 360
                sender.setImage(UIImage(named: "cancel"), for: .normal)
            }, completion: nil)
            
        } else {
            
            UIView.transition(with: sender as UIView, duration: 0.5, options: .transitionFlipFromRight, animations: { [self] in
                [menu_View,menu_Table_View].forEach({$0.alpha = 0})
                menu_Hide.constant = -500
                menu_width.constant = 0
                sender.setImage(UIImage(named: "Menu"), for: .normal)
            }, completion: nil)
        }
    }
    
    
    // Calendar action........................................>!!
    @IBAction func celender_Action(_ sender: UIButton) {
        
        if celender_background.isHidden == true {
            
            celender_background.isHidden = false
            celender_background.alpha = 0
            UIView.animate(withDuration: 0.5) { [self] in
                celender_background.alpha = 1
            }
            
        } else if celender_background.isHidden == false {
            
            UIView.animate(withDuration: 0.5) { [self] in
                celender_background.alpha = 0
                celender_background.isHidden = true
            }
        }
    }
    
    
    // Profile setup Action........................>!!
    @IBAction func profile_setUp_Action(_ sender: UIButton) {
        
        if profile_setUp_Back.isHidden == true {
            
            profile_setUp_Back.isHidden = false
            profile_set_View.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.profile_set_View.alpha = 1
            }
            
        } else if profile_setUp_Back.isHidden == false {
            
            profile_setUp_Back.isHidden = true
        }
    }

    
    // Next Month Action................................>!!
    @IBAction func next_Month_Action(_ sender: UIButton) {
        
        if let next_Month = Calendar.current.date(byAdding: .month, value: 1, to: calendarView.currentPage) {

            calendarView.setCurrentPage(next_Month, animated: true)
            currentMonth = next_Month
        }
    }
    
    
    // Pre Month Action.................................>!!
    @IBAction func pre_Month_Action(_ sender: UIButton) {
        
        if let pre_Month = Calendar.current.date(byAdding: .month, value: -1, to: calendarView.currentPage) {

            calendarView.setCurrentPage(pre_Month, animated: true)
            currentMonth = pre_Month
        }
    }
    
    // View Tap Action.................................>!!
    @objc func tap_On_View(sender: UITapGestureRecognizer) {

        marker.isHidden = true
        if sender.view == doctor_Call_View {
    
            isDoc = true
            isStock = false
            isChemist = false
            isSelcted[1].isHidden = true
            isSelcted[2].isHidden = true
            isSelcted[0].isHidden = false
            isSelcted[0].alpha = 0
            UIView.animate(withDuration: 0.5) { [self] in
                isSelcted[0].alpha = 1
                lbl_Chart_Title.text = "Average Doctor Calls"
                setChart(dataPoints: months, values: doc_Data)
            }
            
        } else if sender.view == chemist_Call_View {

            isChemist = true
            isStock = false
            isDoc = false
            isSelcted[0].isHidden = true
            isSelcted[2].isHidden = true
            isSelcted[1].isHidden = false
            isSelcted[1].alpha = 0
            UIView.animate(withDuration: 0.5) { [self] in
                isSelcted[1].alpha = 1
                lbl_Chart_Title.text = "Average Chamist Calls"
                setChart(dataPoints: months, values: chemist_Data)
            }
            
        } else if sender.view == stockiest_Call_View {
            
            isStock = true
            isDoc = false
            isChemist = false
            isSelcted[1].isHidden = true
            isSelcted[0].isHidden = true
            isSelcted[2].isHidden = false
            isSelcted[2].alpha = 0
            UIView.animate(withDuration: 0.5) { [self] in
                isSelcted[2].alpha = 1
                lbl_Chart_Title.text = "Average Stockiest Calls"
                setChart(dataPoints: months, values: stock_Data)
            }
        }
    }
    
    
//MARK: - Functions.........................!!
    private func update() {
        
        
    }
    
    // Chart View.............................................>!!
    private func setChart(dataPoints: [String], values : [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "")
        chartDataSet.circleRadius = 5
        chartDataSet.circleHoleRadius = 2
        chartDataSet.drawCirclesEnabled = true
        chartDataSet.circleColors = [NSUIColor.black]
        chartDataSet.circleHoleColor = NSUIColor.black
        chartDataSet.drawValuesEnabled = false
        chartDataSet.highlightEnabled = true
        chartDataSet.setColor(.black)
        
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        char_View.delegate = self
        char_View.data = chartData
        
        char_View.setVisibleXRangeMinimum(12.0)
        char_View.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        char_View.xAxis.setLabelCount(months.count, force: true)
        char_View.xAxis.labelPosition = .bottom
        char_View.xAxis.drawGridLinesEnabled = false
        char_View.xAxis.avoidFirstLastClippingEnabled = true
        char_View.animate(xAxisDuration: 1.8, easing: .none)
        
        char_View.rightAxis.drawAxisLineEnabled = false
        char_View.rightAxis.drawLabelsEnabled = false
        
        char_View.leftAxis.drawAxisLineEnabled = false
        char_View.pinchZoomEnabled = false
        char_View.doubleTapToZoomEnabled = true
        char_View.legend.enabled = false
        char_View.gridBackgroundColor = .black
    }
    
    // Tap to View Func...................................>!!
    private func tap_On_View() {
        
        [doctor_Call_View,chemist_Call_View,stockiest_Call_View].forEach({
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap_On_View(sender:)))
            $0?.addGestureRecognizer(tap)
        })
    }
    
    // Segment func.......................................>!!
    private func segment() {
        
        sengment_Controller.frame = CGRect(x: self.sengment_Controller.frame.minX, y: self.sengment_Controller.frame.minY, width: sengment_Controller.frame.width, height: 50)
        
        let font = UIFont.systemFont(ofSize: 20)
        sengment_Controller.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        sengment_Controller.highlightSelectedSegment()
    }
    
    // Progress View func..................................>!!
    private func progressView() {
    
        [doc_Call,chemist_Calls,stocki_Calls].forEach({view in
            
            view?.startAngle = -90.0
            view?.isClockwise = true
            view?.font = UIFont(name: "Satoshi-Bold", size: 20)!
            view?.fontColor = .white
            view?.outerRingWidth = 5.0
            view?.style = .bordered(width: 0.0, color: .white)
            view?.innerRingColor = .white
            view?.outerRingColor = UIColor(rgb: 10855845)
        })

        doc_Call.minValue = 25
        doc_Call.startProgress(to: 75, duration: 2.0) {
            // Details...
        }
        
        chemist_Calls.maxValue = 10
        chemist_Calls.startProgress(to: 5, duration: 2.0) {
            // Details...
        }
        
        stocki_Calls.maxValue = 10
        stocki_Calls.startProgress(to: 3, duration: 2.0) {
            // Details...
        }
    }
    
    // Properties func........................................>!!
    private func properties() {
        
        [btn_profile,btn_refresh,btn_notifiction].forEach({$0?.Border_Radius(border_height: 0, isborder: false, radius: 25)})
        
        [profile_set_View, celender_View,sengment_View,table_View,call_Table_View,outBox_View,doctor_Call_View,chemist_Call_View,stockiest_Call_View,celender_background,chart_Background].forEach({$0?.Border_Radius(border_height: 0, isborder: false, radius: 10)})
        
        [btn_Add_Call,btn_Final_sub,btn_Add_Activity,btn_clear_call].forEach({$0?.Border_Radius(border_height: 0.7, isborder: true, radius: 10)})
    
        profile_Image.Border_Radius(border_height: 0.0, isborder: false, radius: 50)
        
        background_View.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1)
        
        btn_tags[0].Border_Radius(border_height: 2, isborder: true, radius: 20)
        btn_tags[1].Border_Radius(border_height: 2, isborder: true, radius: 20)
        
        [profile_setUp_Back,celender_background].forEach({$0?.shadow(radius: 3.0)})
        
        lbl_Count[0].text = String(arrName.count)
        lbl_Count[1].text = String(obj_sections.count)
    }
    
    // Calendar View...........................................>!!
    private func calender() {
        
        calendarView.appearance.headerTitleFont = UIFont(name: "Satoshi-Bold", size: 18)
        calendarView.select(Date())
        calendarView.register(FSCalendarCell.self, forCellReuseIdentifier: "date_cell")
        calendarView.appearance.eventOffset = CGPoint(x: calendarView.daysContainer.frame.width / 1, y: calendarView.frame.minY - 22)
    }
    
    // Status bar Style........................................>!!
    override var preferredStatusBarStyle : UIStatusBarStyle {
        
        return .lightContent
    }
}


extension HomeVC : UITableViewDelegate , UITableViewDataSource , CollapsibleTableViewHeaderDelegate {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == UITable {
            return 5
        } else if tableView == outBox_Table {
            return obj_sections.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == UITable {
            return 1
        } else if tableView == call_Table {
            return arrName.count
        } else if tableView == outBox_Table {
            return obj_sections[section].collapsed ? 0 : obj_sections[section].items.count
        } else {
            return arrTitle.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == UITable { //MARK: - Work Plan Table...............................!!
            
            let cell = UITable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! TableCell
            
            cell.background_View.Border_Radius(border_height: 0.9, isborder: true, radius: 10)
            
            [cell.lbl_title, cell.btn_More].forEach({$0?.isHidden = false})
            [cell.btn_submit,cell.txt_View_Remarks].forEach({$0?.isHidden = true})
            
            if indexPath.section == 0 { // Cell 1!!
                
                cell.lbl_title.text = "Select Work Type"
                
            } else if indexPath.section == 1 { // Cell 2!!
                
                cell.lbl_title.text = "Select Head Quarters"
                
            } else if indexPath.section == 2 { // Cell 3!!
                
                cell.lbl_title.text = "Select Cluster"
                
            } else if indexPath.section == 3 { // Cell 4!!
                
                [cell.lbl_title,cell.btn_submit,cell.btn_More].forEach({$0?.isHidden = true})
                cell.txt_View_Remarks.isHidden = false
                
            } else if indexPath.section == 4 { // cell 5!!
                
                [cell.lbl_title,cell.txt_View_Remarks,cell.btn_More].forEach({$0?.isHidden = true})
                cell.btn_submit.isHidden = false
            }
            
            cell.selectionStyle = .none
            return cell
            
        } else if tableView == call_Table { //MARK: - Call List Table...............................!!
          
            let cell = call_Table.dequeueReusableCell(withIdentifier: "call_Cell", for: indexPath) as! CallCell
            cell.pfp_View.Border_Radius(border_height: 0, isborder: false, radius: 25)
            cell.pfp_View.backgroundColor = .random()
            cell.lbl_name.text = arrName[indexPath.row]
            cell.btn_option.tag = indexPath.row + 100
            cell.btn_option.addTarget(self, action: #selector(click_onCallMoreBtn), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
            
        } else if tableView == outBox_Table { //MARK: - Out Box Table...............................!!
           
            let cell = outBox_Table.dequeueReusableCell(withIdentifier: "outbox_Cell", for: indexPath)as! OutboxCell
            
            cell.btn_Option.tag = indexPath.row + 100
            cell.btn_Option.addTarget(self, action: #selector(click_onOutBoxMoreBtn), for: .touchUpInside)
            cell.btn_Option.frame.size.width = 50
            cell.pfp_image.Border_Radius(border_height: 0, isborder: false, radius: 25)
            cell.background_Cell.Border_Radius(border_height: 0, isborder: false, radius: 5)
            cell.pfp_image.backgroundColor = .random()
       //     cell.lbl_name.text = obj_sections[indexPath.section].items[indexPath.row]
            
            cell.selectionStyle = .none
            return cell
            
        } else { //MARK: - Menu Table...............................!!
            
            let cell = menu_Table.dequeueReusableCell(withIdentifier: "menu_Cell", for: indexPath)as! MenuCell
            
            cell.image_View.image = arrImage[indexPath.row]
            cell.lbl_Title.text = arrTitle[indexPath.row]
         
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("vlfopgrem kr 4404")
        if tableView == UITable {
            
            if indexPath.section == 0 {
               
                let workType = DBManager.shared.getWorkType()
                
                
                let selectionVC = UIStoryboard.singleSelectionVC
                selectionVC.selectionData = workType
                self.present(selectionVC, animated: true)
            }
            
            
            if indexPath.section == 2 {
               
                let territory = DBManager.shared.getTerritory()
                
                
                let selectionVC = UIStoryboard.singleSelectionVC
                selectionVC.selectionData = territory
                self.present(selectionVC, animated: true)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == UITable {
            return indexPath.section == 3 ? 110 : 60
        } else if tableView == outBox_Table {
            return UITableView.automaticDimension
        } else {
            return 80
        }
    }
    
    @objc func click_onCallMoreBtn(sender:UIButton) {
        print("Call More")
        setUpMoreBtnAlert(sourceView: sender)
    }
    
    @objc func click_onOutBoxMoreBtn(sender:UIButton) {
        print("OutBox More")
        setUpMoreBtnAlert(sourceView: sender)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == outBox_Table {
            return 50
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        
        if tableView == outBox_Table {
            
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
            header.titleLabel.text = obj_sections[section].date
            header.section = section
            header.delegate = self
            
            if obj_sections[section].collapsed {
                
                header.arrowLabel.text = "Expand"
                
            } else {
                
                header.arrowLabel.text = "Collapse"
            }
            return header
            
        } else {
            
            return view
        }
    }
    
    
    func toggleSection(_ header: UITableViewHeaderFooterView, section: Int) {
        let collapsed = !obj_sections[section].collapsed
        obj_sections[section].collapsed = collapsed
        
        // Reload the whole section
        outBox_Table.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}



extension HomeVC : ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        marker = MarkerView()
        
        marker.isHidden = false
        let lbl_total_value = UILabel()
        let lbl_total_call = UILabel()
        let divider = UIView()
        let lbl_Avg_call = UILabel()
        let lbl_Avg_value = UILabel()
        
        // View
        marker.offset.x = -marker.frame.size.width / 250
        
        if entry.y < 40 || entry.x > 12 {
            
            marker.offset.y = -marker.frame.size.height - 90
        }
        
        marker.frame.size = CGSize(width: 250, height: 90)
        marker.backgroundColor = UIColor(rgb: 50825)
        if isDoc {
            
            marker.backgroundColor = UIColor(rgb: 50825)
            
        } else if isChemist {
            
            marker.backgroundColor = UIColor(rgb: 4040180)
            
        } else if isStock {
            
            marker.backgroundColor = UIColor(rgb: 15815534)
        }
        marker.Border_Radius(border_height: 0.0, isborder: false, radius: 10)
        
        // Total Calls
        lbl_total_call.frame.origin = CGPoint(x: 10, y: 15)
        lbl_total_call.text = "Total calls"
        marker.addSubview(lbl_total_call)
        
        // Total Value Label
        lbl_total_value.frame.origin = CGPoint(x: 13, y: 50)
        lbl_total_value.text = "180"
        
        marker.addSubview(lbl_total_value)
        
        // Divider
        divider.frame = CGRect(x: marker.center.x, y: 5, width: 0.8, height: 80)
        divider.backgroundColor = .white
        marker.addSubview(divider)
        
        // Avg Calls
        lbl_Avg_call.frame.origin = CGPoint(x: marker.center.x + 15, y: 15)
        lbl_Avg_call.text = "Avg calls"
        marker.addSubview(lbl_Avg_call)
        
        // Avg value label
        lbl_Avg_value.frame.origin = CGPoint(x: marker.center.x + 17, y: 50)
        lbl_Avg_value.text = String(entry.y)
        marker.addSubview(lbl_Avg_value)
        
        // Comman properties in total section
        [lbl_total_value,lbl_total_call].forEach({ label in
    
            label.frame.size = CGSize(width: 100, height: 30)
            label.textColor = .white
        })
        
        // Comman properties in avg section
        [lbl_Avg_call,lbl_Avg_value].forEach({ label in
            
            label.frame.size = CGSize(width: 100, height: 30)
            label.textColor = .white
        })
        
        // Comman Properties for all
        [lbl_Avg_call,lbl_Avg_value,lbl_total_call,lbl_total_value].forEach({
            
            $0.font = UIFont(name: "Satoshi-Bold", size: 20)
        })
        char_View.marker = marker
    }
}



extension HomeVC : FSCalendarDelegate , FSCalendarDataSource , FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("tapped")
        let dateformatter = DateFormatter()
        let month = DateFormatter()
        dateformatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM dd, yyyy", options: 0, locale: calendar.locale)
        month.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM yyyy", options: 0, locale: calendar.locale)
        
        btn_celender.setTitle(dateformatter.string(from: date), for: .normal)
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        
        let cell = calendarView.dequeueReusableCell(withIdentifier: "date_cell", for: date, at: position)
        
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let dateString = self.dateFormatter2.string(from: date)
        
        if self.datesWithEvent.contains(dateString) {
            return 1
        }
        if self.datesWithMultipleEvents.contains(dateString) {
            return 3
        }
        return 0
    }
}


extension HomeVC : collectionViewProtocols {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = event_Collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EventCell
        cell.lbl_event.text = eventArr[indexPath.row]
        cell.width1 = collectionView.bounds.width - Constants.spacing
        cell.Border_Radius(border_height: 0.0, isborder: false, radius: 5)
        return cell
    }
}



private enum Constants {
    static let spacing: CGFloat = 1
}



