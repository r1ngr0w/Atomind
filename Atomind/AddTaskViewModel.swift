import Foundation
import SwiftUI
import Combine

// Definizione necessaria per far funzionare il ViewModel
enum DateField {
    case start
    case end
}

class AddTaskViewModel: ObservableObject {
    // Dati del Task
    @Published var taskName: String = ""
    @Published var notes: String = ""
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date().addingTimeInterval(3600)
    
    // Stato del Calendario
    @Published var currentMonth: Date = Date()
    @Published var showCalendar: Bool = true
    @Published var activeField: DateField = .start
    
    func resetState() {
        taskName = ""
        notes = ""
        startDate = Date()
        endDate = Date().addingTimeInterval(3600)
        currentMonth = Date()
        showCalendar = true
        activeField = .start
    }
    
    func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }
}
