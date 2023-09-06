import Foundation

struct Section {
  var name: String
  var items: [String]
  var collapsed: Bool
    
  init(name: String, items: [String], collapsed: Bool = true) {
    self.name = name
    self.items = items
    self.collapsed = collapsed
  }
}
    
var obj_sections = [
  Section(name: "April 21, 2023", items: ["Jony Deeph", "Michal Grud", "Trever", "Jimmy"]),
  Section(name: "April 25, 2023", items: ["Arvind Kher", "Arvind Ji", "Arvind Raj"]),
  Section(name: "April 30, 2023", items: ["Ansh Mehta", "Arav Pande", "Shreeji Tavde", "Karma Shinde"])
]
