//
//  CustomCalendarView.swift
//  ATOMIND2
//
//  Created by Eman on 12/12/25.
//
//----------------------CALENDAR-----------------

//--apple's style calendar --


import Foundation
import SwiftUI
#if os(iOS)
import UIKit // Serve per la vibrazione su iPhone
#endif

struct CustomCalendarView: View {
    // VARIABILI (BINDING)
    @Binding var selectedDate: Date
    @Binding var currentMonth: Date
    
    // DEFINIZIONE GRIGLIA
    private let daysOfWeek = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack(spacing: 20) {
            
            // --- 1. HEADER (Mese + Frecce) ---
            HStack {
                Text(currentMonth.format("MMMM yyyy"))
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack(spacing: 20) {
                    Button(action: { changeMonth(-1) }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.blue)
                    }
                    Button(action: { changeMonth(1) }) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.blue)
                    }
                }
            }
            .padding(.horizontal)
            
            // --- 2. GRIGLIA GIORNI ---
            LazyVGrid(columns: columns, spacing: 15) {
                // Intestazione giorni
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray.opacity(0.5))
                }
                
                // Spazi vuoti iniziali
                if let firstDay = currentMonth.getAllDays().first {
                    let firstWeekday = Calendar.current.component(.weekday, from: firstDay)
                    ForEach(0..<(firstWeekday - 1), id: \.self) { _ in
                        Text("")
                    }
                }
                
                // I numeri dei giorni
                ForEach(currentMonth.getAllDays(), id: \.self) { date in
                    let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
                    let isToday = Calendar.current.isDateInToday(date)
                    
                    Text("\(Calendar.current.component(.day, from: date))")
                        .font(.system(size: 16, weight: isSelected ? .bold : .regular))
                        .foregroundStyle(isSelected ? .white : (isToday ? .blue : .primary))
                        .frame(width: 35, height: 35)
                        .background(
                            Circle()
                                .fill(isSelected ? Color.blue : Color.clear)
                        )
                        .onTapGesture {
                            // --- CORREZIONE QUI SOTTO ---
                            // Questo codice viene eseguito SOLO su iOS (iPhone/iPad)
                            #if os(iOS)
                            let impact = UIImpactFeedbackGenerator(style: .light)
                            impact.impactOccurred()
                            #endif
                            
                            withAnimation(.spring()) {
                                selectedDate = date
                            }
                        }
                }
            }
            
            Divider()
            
            // --- 3. TIME PICKER INTEGRATO ---
            HStack {
                Text("Time")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .padding(5)
                    .background(Color.gray.opacity(0.1)) // Sostituito systemGray6 per compatibilità Mac
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
    
    // Funzione interna per scorrere i mesi
    private func changeMonth(_ value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newDate
        }
    }
}

// ANTEPRIMA XCODE
#Preview {
    ZStack {
        Color.gray.opacity(0.1).ignoresSafeArea()
        CustomCalendarView(selectedDate: .constant(Date()), currentMonth: .constant(Date()))
            .padding()
    }
}
