import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        // L'app si avvia sempre dalla schermata di benvenuto
        PrescriptionReadyView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TaskItem.self, inMemory: true)
}
