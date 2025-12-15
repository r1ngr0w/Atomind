//
//  AddTaskView.swift
//  ATOMIND2
//
//  Created by AFP FED 22 on 12/12/25.
//
// Aggiunto per sicurezza per riconoscere i colori di sistema

import Foundation
import SwiftUI
import Combine
import SwiftData // <--- 1. IMPORTANTE: Serve per il database

struct AddTaskView: View {
    @StateObject var viewModel = AddTaskViewModel()
    
    // Questa serve per chiudere la schermata
    @Environment(\.dismiss) var dismiss
    
    // <--- 2. IMPORTANTE: La "penna" per scrivere nel database
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        
                        // --- 1. NOME TASK ---
                        HStack {
                            Image(systemName: "pills.fill")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .padding(12)
                                .background(Circle().fill(Color.green))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                TextField("Task name", text: $viewModel.taskName)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundStyle(.gray.opacity(0.3))
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                        // --- 2. SEZIONE DATE ---
                        VStack(spacing: 0) {
                            
                            // Time Zone (Estetico)
                            HStack {
                                Text("Time Zone")
                                Spacer()
                                Text("Cupertino")
                                    .foregroundStyle(.secondary)
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundStyle(.tertiary)
                            }
                            .padding()
                            
                            Divider().padding(.leading)
                            
                            // --- RIGA START ---
                            dateRow(
                                label: "Start",
                                date: viewModel.startDate,
                                isActive: viewModel.activeField == .start && viewModel.showCalendar
                            )
                            .onTapGesture {
                                viewModel.activeField = .start
                                withAnimation { viewModel.showCalendar = true }
                                viewModel.currentMonth = viewModel.startDate
                            }
                            
                            // --- CALENDARIO DINAMICO ---
                            if viewModel.showCalendar {
                                CustomCalendarView(
                                    selectedDate: viewModel.activeField == .start ? $viewModel.startDate : $viewModel.endDate,
                                    currentMonth: $viewModel.currentMonth
                                )
                                .padding(.horizontal)
                                .padding(.bottom)
                                .transition(.move(edge: .top).combined(with: .opacity))
                            } else {
                                Divider().padding(.leading)
                            }
                            
                            // --- RIGA END ---
                            dateRow(
                                label: "End",
                                date: viewModel.endDate,
                                isActive: viewModel.activeField == .end && viewModel.showCalendar
                            )
                            .onTapGesture {
                                viewModel.activeField = .end
                                withAnimation { viewModel.showCalendar = true }
                                viewModel.currentMonth = viewModel.endDate
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationTitle("New Reminder")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            // --- TASTI TOOLBAR (Cancel / Add) ---
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        // <--- 3. RESETTA I DATI PRIMA DI CHIUDERE
                         viewModel.resetState()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        // <--- 4. SALVA NEL DATABASE VERO
                        saveTaskToDatabase()
                        dismiss() // Chiude dopo aver salvato
                    }
                    .fontWeight(.bold)
                    // Opzionale: Disabilita se non c'è nome
                    .disabled(viewModel.taskName.isEmpty)
                }
            }
        }
    }
    
    // Funzione locale per gestire il salvataggio SwiftData
    func saveTaskToDatabase() {
        let newTask = TaskItem(
            title: viewModel.taskName,
            startDate: viewModel.startDate,
            endDate: viewModel.endDate
        )
        
        context.insert(newTask) // Scrive nel database
        print("Salvataggio effettuato: \(newTask.title)")
    }
    
    // Componente Helper Grafico
    @ViewBuilder
    func dateRow(label: String, date: Date, isActive: Bool) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(.primary)
            Spacer()
            
            Text(date.format("MMM yyyy"))
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isActive ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
                .foregroundStyle(isActive ? .blue : .primary)
                .cornerRadius(8)
            
            Text(date.format("h:mm a"))
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
        .padding()
        .contentShape(Rectangle())
    }
}

#Preview {
    // Serve il container in memoria per l'anteprima
    AddTaskView()
        .modelContainer(for: TaskItem.self, inMemory: true)
}
