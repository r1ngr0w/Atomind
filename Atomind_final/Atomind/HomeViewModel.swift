import Foundation
import SwiftData
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    // Logic to format the date nicely for the list
    func formatTaskDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        return formatter.string(from: date)
    }
    
    // Logic to delete a task
    func deleteTask(at offsets: IndexSet, from tasks: [TaskItem], context: ModelContext) {
        for index in offsets {
            let taskToDelete = tasks[index]
            context.delete(taskToDelete)
        }
    }
}
