import SwiftUI
import SwiftData // 1. IMPORTANTE: Serve per il database
//-------------CALENDARIO (add task view)
struct AddTaskView: View {
    @StateObject var viewModel = AddTaskViewModel()
    
    // Serve per chiudere la schermata
    @Environment(\.dismiss) var dismiss
    
    // La "penna" per scrivere nel database
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationView {
            ZStack {
                // Sfondo Grigio Chiaro
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
                        
                        // --- 2. SEZIONE DATA E ORA ---
            VStack(spacing: 0) {
                            
                     
                            // --- RIGA UNICA (START) ---
                            // Contiene: Etichetta, Data (Apre Calendario), Ora (DatePicker nativo)
                            HStack {
                                Text("Start")
                                    .foregroundStyle(.primary)
                                Spacer()
                                
                                // A. PILLOLA DATA (Clicca per Aprire/Chiudere Calendario)
                                Button(action: {
                                    withAnimation {
                                        viewModel.showCalendar.toggle()
                                        // Aggiorna il mese se apri il calendario
                                        if viewModel.showCalendar {
                                            viewModel.currentMonth = viewModel.startDate
                                        }
                                    }
                                }) {
                                    Text(viewModel.startDate.format("MMM yyyy"))
                                        .font(.subheadline)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        // Colore Blu se calendario attivo
                                        .background(viewModel.showCalendar ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
                                        .foregroundStyle(viewModel.showCalendar ? .blue : .primary)
                                        .cornerRadius(8)
                                }
                                
                                // B. PILLOLA ORA (DatePicker Compatto)
                                DatePicker("", selection: $viewModel.startDate, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            .padding()
                            
                            // --- CALENDARIO DINAMICO (Visibile solo se showCalendar è true) ---
                            if viewModel.showCalendar {
                                CustomCalendarView(
                                    selectedDate: $viewModel.startDate,
                                    currentMonth: $viewModel.currentMonth
                                )
                                .padding(.horizontal)
                                .padding(.bottom)
                                .transition(.move(edge: .top).combined(with: .opacity))
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
            
            // --- QUI CI SONO I BOTTONI ADD E CANCEL ---
            .toolbar {
                // Tasto Sinistro: CANCEL
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.resetState() // Pulisce i campi
                        dismiss()              // Chiude la schermata
                    }
                }
                
                // Tasto Destro: ADD
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        saveTaskToDatabase() // Salva nel DB
                        dismiss()            // Chiude la schermata
                    }
                    .fontWeight(.bold)
                    // Disabilitato se non hai scritto il nome
                    .disabled(viewModel.taskName.isEmpty)
                }
            }
        }
    }
    
    // Funzione di Salvataggio
    func saveTaskToDatabase() {
        // Calcola la fine automaticamente (+1 ora) dato che abbiamo tolto la riga End
        let autoEndDate = Calendar.current.date(byAdding: .hour, value: 1, to: viewModel.startDate) ?? viewModel.startDate
        
        let newTask = TaskItem(
            title: viewModel.taskName,
            startDate: viewModel.startDate,
            endDate: autoEndDate
        )
        
        context.insert(newTask)
        print("✅ Salvataggio effettuato: \(newTask.title)")
    }
}

#Preview {
    AddTaskView()
        .modelContainer(for: TaskItem.self, inMemory: true)
}
