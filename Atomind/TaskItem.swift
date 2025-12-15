//
//  TaskItem.swift
//  ATOMIND2
//
//  Created by Eman on 12/12/25.
//UUID= id universaleper ogni task esistente. Se ci saranno due task uguali di nomi , all'occhio della task sarà diverso
//------task salvate e contenenti le informazioni

import Foundation

import SwiftData

@Model //database
class TaskItem: Identifiable {
    var id: UUID
    var title: String
    var startDate: Date
    var endDate: Date
    var isCompleted: Bool
    
    // Inizializzatore
    init(title: String, startDate: Date, endDate: Date, isCompleted: Bool = false) {
        self.id = UUID() // Genera un ID unico automatico //
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.isCompleted = isCompleted
    }
    
    
    
    
    
    
}
