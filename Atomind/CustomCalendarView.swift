import SwiftUI
#if os(iOS)
import UIKit
#endif
//-------------------------------CALENDARIO(solo mese e giorno)----------------
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
                // Nota: Se "format" ti dà errore qui, significa che non ce l'hai nell'altro file.
                // In quel caso dimmelo e ti dico dove mettere l'estensione.
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
                            #if os(iOS)
                            let impact = UIImpactFeedbackGenerator(style: .light)
                            impact.impactOccurred()
                            #endif
                            
                            withAnimation(.spring()) {
                                // Mantiene l'ora corrente quando cambi giorno
                                let currentHour = Calendar.current.component(.hour, from: selectedDate)
                                let currentMinute = Calendar.current.component(.minute, from: selectedDate)
                                
                                if let newDate = Calendar.current.date(bySettingHour: currentHour, minute: currentMinute, second: 0, of: date) {
                                    selectedDate = newDate
                                } else {
                                    selectedDate = date
                                }
                            }
                        }
                }
            }
            // --- NESSUNA BARRA TIME QUI SOTTO ---
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
    
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
