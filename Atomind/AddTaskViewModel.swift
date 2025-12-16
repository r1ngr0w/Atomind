//
//  AddTaskViewModel.swift
//  ATOMIND2
//
//  Created by Eman on 12/12/25.

//------------AddTask View

/*
 ruolo: È il "cervello" della schermata. Tiene i dati (data selezionata, nome task) separati dalla grafica.
 
 */
import Foundation
import SwiftUI
import Combine
// Enum per sapere se stiamo modificando Start o End
enum DateField {
    case start
    case end
}
class AddTaskViewModel: ObservableObject {
    // Dati della schermata
    @Published var taskName: String = ""
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date().addingTimeInterval(3600) // Default: +1 ora
    
    // Stato del calendario
    @Published var currentMonth: Date = Date()
    @Published var showCalendar: Bool = true
    @Published var activeField: DateField = .start
    
    
    func resetState() {
        taskName = ""
        startDate = Date()
        endDate = Date().addingTimeInterval(3600)
        currentMonth = Date()
        showCalendar = true
        activeField = .start
    }
    
    // Logica per cambiare mese
    func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }
}
