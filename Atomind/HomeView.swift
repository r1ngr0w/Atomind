import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @Query(sort: \TaskItem.startDate) var tasks: [TaskItem]
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    // Il NavigationLink avvolge il contenuto per renderlo cliccabile
                    NavigationLink(destination: TaskDetailView(task: task)) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(task.title)
                                .font(.headline)
                                .foregroundStyle(.primary)
                            
                            if !task.notes.isEmpty {
                                Text(task.notes)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                                    .lineLimit(1) // Anteprima breve
                            }
                            
                            Text(viewModel.formatTaskDate(task.startDate))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteTask(at: indexSet, from: tasks, context: context)
                }
            }
            .navigationTitle("My Tasks")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: AddTaskView()) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
        }
    }
}
