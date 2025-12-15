//
//  ContentView.swift
//  Atomind
//
//  Created by Eman on 12/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // 1. Questa riga LEGGE automaticamente dal Database
    // Appena salvi un task, questa lista si aggiorna da sola!
    @Query var tasks: [TaskItem]   //<--------------------per roberto
    
    // Serve per aprire/chiudere la tua schermata di creazione
    @State private var showCreateTask = false
    
    var body: some View {
        NavigationView {
            List {
                if tasks.isEmpty {
                    Text("Nessun task nel database.")
                        .foregroundStyle(.gray)
                } else {
                    // 2. Mostriamo tutti i task salvati
                    ForEach(tasks) { task in  // <--------- per roberto
                        //----// roberto qui metterà la sua "CardBellissimaView(task: task)"
                        //eliminare il Text(task.title) (istruzione per roberto)
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.headline)
                            HStack {
                                Text("Inizio: \(task.startDate.format("dd MMM HH:mm"))")
                                Text("•")
                                Text("Fine: \(task.endDate.format("HH:mm"))")
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        }
                    }
                    // Opzionale: Swipe per cancellare (così pulisci il DB se vuoi)
                    .onDelete { indexSet in
                        // Codice per eliminare (non essenziale ora ma utile)
                    }
                }
            }
            .navigationTitle("Database Viewer")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showCreateTask = true // Apre la tua schermata
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            // 3. Qui colleghiamo la TUA schermata AddTaskView
            .sheet(isPresented: $showCreateTask) {
                AddTaskView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TaskItem.self, inMemory: true)
}

