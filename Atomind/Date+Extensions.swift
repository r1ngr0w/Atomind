//
//  Date+Extensions.swift
//  ATOMIND2
//
//  Created by Eman on 12/12/25.


//----------date for the calendar--------- 
/*Contiene gli "attrezzi" per manipolare le date
 (es. "dammi tutti i giorni del mese"). È codice che potrebbe servire a tutto il team, non solo a te.

 */
import SwiftUI

import Foundation

extension Date {
    func getAllDays() -> [Date] {
        let calendar = Calendar.current
        // Ottieni l'intervallo di giorni nel mese corrente
        guard let range = calendar.range(of: .day, in: .month, for: self),
              let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: self)) else {
            return []
        }

        // Genera le date per ogni giorno del mese
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)!
        }
    }

    // Funzione rapida per formattare la data in stringa (es. "April 2025")
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "it_IT") // O "en_US" in base alla lingua app
        return formatter.string(from: self)
    }
}
