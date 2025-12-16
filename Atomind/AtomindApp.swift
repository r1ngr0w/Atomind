//
//  AtomindApp.swift
//  Atomind
//
//  Created by Eman on 15/12/25.
//

import SwiftUI
import SwiftData

@main
struct ATOMMIND2App: App {
    var body: some Scene {
        WindowGroup {
            // PRIMA c'era ContentView(), ORA rimettiamo la tua vista
            PrescriptionReadyView()
        }
        .modelContainer(for: TaskItem.self)
    }
}

/*
 
 DebugTaskList() // <--- Usiamo la tua lista brutta per testare
 
 HomeView() // <--- Il collega mette qui la sua vista bellissima!
 */

