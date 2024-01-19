import Foundation

struct Section {
    var date: String
    var items: [TodayCallsModel]
    var isCallExpanded: Bool
    var collapsed: Bool
    
    init(items: [TodayCallsModel] , collapsed: Bool = true, isCallExpanded: Bool = false, date: String) {
    self.items = [TodayCallsModel]()
    self.collapsed = collapsed
    self.isCallExpanded = false
    self.date = date
  }
}
    
var obj_sections : [Section] = []
