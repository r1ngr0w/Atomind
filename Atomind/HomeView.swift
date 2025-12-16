import SwiftUI
import SwiftData

struct HomeView: View {
    // MVVM: We use the ViewModel for logic
    @StateObject private var viewModel = HomeViewModel()
    
    // Database Query
    @Query(sort: \TaskItem.startDate) var tasks: [TaskItem]
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.headline)
                                .strikethrough(task.endDate < Date(), color: .gray) // Example logic
                            
                            Text(viewModel.formatTaskDate(task.startDate))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        // Small circle to indicate status
                        Circle()
                            .fill(Color.blue.opacity(0.5))
                            .frame(width: 10, height: 10)
                    }
                    .padding(.vertical, 4)
                }
                .onDelete { indexSet in
                    viewModel.deleteTask(at: indexSet, from: tasks, context: context)
                }
            }
            .navigationTitle("My Tasks")
            .toolbar {
                
                // Button to add MORE tasks from the Home Screen
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: AddTaskView()) {
                        Image(systemName: "plus")
                        
                        NavigationLink(destination: AddTaskView()){
                            
                        }
                    }
                }
            }
        }
    }
}
