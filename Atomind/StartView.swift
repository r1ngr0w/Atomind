//
//  StartView.swift
//  Atomind
//
//  Created by AFP FED 05 on 15/12/25.
//

import SwiftUI
// --- 2. PAGINA PRINCIPALE (StartView) ---
struct StartView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // A. Sfondo Bianco
                Color.white.ignoresSafeArea()
                
                // B. LIVELLO LOGO
                VStack {
                    // Spazio per spingere il logo sotto la scritta verde
                    Spacer().frame(height: 400)

                    Image("logo")
                        .resizable()
                        // * MODIFICHE QUI PER RIDURRE LA GRANDEZZA *
                        .aspectRatio(contentMode: .fit) // Mantiene le proporzioni e non taglia
                        .frame(width: 370) // Imposta una larghezza fissa (diminuisci questo numero se è ancora grande)
                        .opacity(0.2)      // Opacità al 50%
                        // *******
                    
                    Spacer()
                }
                .ignoresSafeArea() // Importante se usiamo scaledToFill
                .allowsHitTesting(false) // IMPEDISCE AL LOGO DI BLOCCARE IL CLICK
                
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
                    
                    // --- BOTTONE (NavigationLink) ---
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
                        .contentShape(Rectangle()) // Rende il click solido
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
        }
    }
}

// Rinominate anche le Preview per riflettere il cambio nome
struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

