import SwiftUI
import SwiftData

struct AddTaskView: View {
    @StateObject var viewModel = AddTaskViewModel()
    @State private var navigateToHome = false // Per il reindirizzamento alla lista
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    // 1. INPUT NOME
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
                            Rectangle().frame(height: 1).foregroundStyle(.gray.opacity(0.3))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // 2. CALENDARIO
                    VStack(spacing: 0) {
                        HStack {
                            Text("Start Date").fontWeight(.medium)
                            Spacer()
                            DatePicker("", selection: $viewModel.startDate, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                        .padding()
                        
                        CustomCalendarView(selectedDate: $viewModel.startDate, currentMonth: $viewModel.currentMonth)
                            .padding(.horizontal).padding(.bottom)
                    }
                    .background(Color.white).cornerRadius(12).padding(.horizontal)
                    
                    // 3. SEZIONE NOTE
                    VStack(alignment: .leading, spacing: 8) {
                        Text("NOTES")
                            .font(.caption).fontWeight(.bold).foregroundStyle(.gray).padding(.horizontal, 25)
                        
                        TextField("Add details here...", text: $viewModel.notes, axis: .vertical)
                            .lineLimit(3...6)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12).padding(.horizontal)
                    }
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .navigationTitle("New Reminder")
        .navigationBarTitleDisplayMode(.inline)
        // Questo comando forza lo spostamento alla HomeView quando navigateToHome diventa true
        .navigationDestination(isPresented: $navigateToHome) {
            HomeView()
        }
        .toolbar {
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Add") {
                    saveTask()
                    navigateToHome = true // Vai alla lista
                }
                .fontWeight(.bold)
                .disabled(viewModel.taskName.isEmpty)
            }
        }
    }
    
    func saveTask() {
        let newTask = TaskItem(
            title: viewModel.taskName,
            notes: viewModel.notes,
            startDate: viewModel.startDate
        )
        context.insert(newTask)
    }
}
