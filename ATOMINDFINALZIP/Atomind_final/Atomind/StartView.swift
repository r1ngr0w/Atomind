
import SwiftUI
import SwiftData

struct StartView: View {
    // 1. Aggiungiamo la Query per sapere se esistono task
    @Query var tasks: [TaskItem]

    var body: some View {
        NavigationStack {
            ZStack {
                // A. Sfondo Bianco
                Color.white.ignoresSafeArea()
                
                // B. LIVELLO LOGO
                VStack {
                    Spacer().frame(height: 400)
                    Image("logo") // Assicurati che l'asset esista
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 370)
                        .opacity(0.2)
                    Spacer()
                }
                .ignoresSafeArea()
                .allowsHitTesting(false)
                
                // C. LIVELLO CONTENUTO
                VStack(spacing: 0) {
                    
                    Spacer().frame(height: 80)
                    
                    // TITOLO VERDE
                    Text("What are\nyou doing\ntoday?")
                        .font(.system(size: 65, weight: .heavy, design: .default))
                        .foregroundColor(Color(red: 0.25, green: 0.55, blue: 0.20))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 30)
                        .minimumScaleFactor(0.8)
                    
                    Spacer()
                    
                    // --- BOTTONE 1: Create a new task (SEMPRE VISIBILE) ---
                    NavigationLink(destination: AddTaskView()) {
                        HStack(spacing: 12) {
                            Image(systemName: "plus") // Icona Più
                                .font(.system(size: 18, weight: .bold))
                            Text("Create a new task")
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 30)
                        .frame(maxWidth: .infinity) // Bottone largo quanto basta
                        .background(Color(red: 0.25, green: 0.55, blue: 0.20)) // Verde Atomind
                        .cornerRadius(40)
                        .padding(.horizontal, 40)
                    }
                    .padding(.bottom, 20)

                    // --- BOTTONE 2: View Your Tasks (VISIBILE SOLO SE CI SONO TASK) ---
                    if !tasks.isEmpty {
                        NavigationLink(destination: HomeView()) {
                            HStack(spacing: 12) {
                                Image(systemName: "list.bullet")
                                    .font(.system(size: 18, weight: .bold))
                                Text("View your tasks")
                                    .font(.system(size: 18, weight: .semibold))
                            }
                            .foregroundColor(Color(red: 0.25, green: 0.55, blue: 0.20))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 30)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color(red: 0.25, green: 0.55, blue: 0.20), lineWidth: 2)
                            )
                            .cornerRadius(40)
                            .padding(.horizontal, 40)
                        }
                        .padding(.bottom, 20)
                    } else {
                        // Opzionale: Se non ci sono task, mostriamo un testo informativo o spazio vuoto
                        Text("No tasks available yet")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                    }
                    
                    Spacer().frame(height: 30)
                }
            }
        }
    }
}

#Preview {
    StartView()
        .modelContainer(for: TaskItem.self, inMemory: true)
}
