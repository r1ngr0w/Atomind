import SwiftUI
import SwiftData

struct ContentView: View {
    // 1. We observe the database to see if there are any tasks
    @Query var tasks: [TaskItem]
    
    var body: some View {
        Group {
            if tasks.isEmpty {
                // 2. SCENARIO A: No tasks? Show the Welcome Screen
                // StartView already has its own NavigationStack and links to AddTaskView
                StartView()
            } else {
                // 3. SCENARIO B: We have tasks? Show the List
                HomeView()
            }
        }
        // Optional: Add a smooth transition effect when switching views
        .animation(.easeInOut, value: tasks.isEmpty)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TaskItem.self, inMemory: true)
}
