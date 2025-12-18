import Foundation
import SwiftData

@Model
final class TaskItem {
    var title: String
    var notes: String
    var startDate: Date
    var endDate: Date
    
    init(title: String, notes: String = "", startDate: Date = Date(), endDate: Date = Date()) {
        self.title = title
        self.notes = notes
        self.startDate = startDate
        self.endDate = endDate
    }
}
