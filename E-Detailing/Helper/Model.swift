import Foundation

struct Section {
  var name: String
    var items: [String : Bool]
  var collapsed: Bool
    
    init(name: String, items: [String : Bool], collapsed: Bool = true) {
    self.name = name
    self.items = items
    self.collapsed = collapsed
  }
}
    
var obj_sections = [
    Section(name: "April 21, 2023", items: ["Jony Deeph" : false, "Michal Grud" : false]),
]
