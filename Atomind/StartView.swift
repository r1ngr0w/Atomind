//
//  StartView.swift
//  Atomind
//
//  Created by AFP FED 46 on 15/12/25.
//

import SwiftUI

// ==========================================
// 3. SECONDA SCHERMATA (StartView)
// ==========================================
/*
struct StartView: View {
    // Nascondiamo il pulsante "Back" standard per pulizia (opzionale)
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // A. Sfondo Bianco
            Color.white.ignoresSafeArea()
            
            // B. LIVELLO LOGO (Sfondo sfumato)
            VStack {
                // Spazio per spingere il logo sotto la scritta verde
                Spacer().frame(height: 400)

                Image("logo") // Assicurati di avere questa immagine negli Assets
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 370)
                    .opacity(0.2)
                
                Spacer()
            }
            .ignoresSafeArea()
            .allowsHitTesting(false) // Il logo non blocca i click
            
            // C. LIVELLO CONTENUTO (Titolo e Bottone)
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
                
                // --- BOTTONE verso NewTaskView ---
                NavigationLink(destination: NewTaskView()) {
                    HStack(spacing: 12) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 14))
                        Text("Create a new task")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .foregroundColor(.blue)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 30)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(40)
                    .contentShape(Rectangle())
                }
                
                Spacer().frame(height: 50)
                
                // PUNTINI
                HStack(spacing: 8) {
                    Circle().fill(Color.gray.opacity(0.3)).frame(width: 8, height: 8)
                    Circle().fill(Color.black).frame(width: 8, height: 8)
                    Circle().fill(Color.gray.opacity(0.3)).frame(width: 8, height: 8)
                }
                .padding(.bottom, 20)
            }
        }
        // Opzionale: Nasconde il bottone "Back" nativo se vuoi che sembri una nuova home
        // .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    StartView()
}
*/
