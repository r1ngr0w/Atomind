//
//  PrescriptionReadyView.swift
//  Atomind
//
//  Created by AFP FED 46 on 15/12/25.
//

import SwiftUI

// --- Estensione Colori (Se non è già definita globalmente nel progetto) ---
extension Color {
    static let atomindGreenText = Color(red: 0.15, green: 0.55, blue: 0.10)
    static let pillColor = Color(red: 0.28, green: 0.58, blue: 0.22)
}

// --- QUESTA È LA TUA SCHERMATA PRINCIPALE ---
struct PrescriptionReadyView: View {
    var body: some View {
        // Se nel progetto c'è già una NavigationStack globale in ContentView,
        // potresti dover rimuovere questa NavigationStack e lasciare solo il VStack.
        NavigationStack {
            VStack {
                // Spazio superiore
                Spacer().frame(height: 50)
                
                // --- LOGO ---
                // Assicurati che l'immagine esista negli Assets
                Image("atomindLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .offset(x: 8)
                
                Spacer()
                
                // --- Testo Principale ---
                Text("Hello,\nyour prescription\nis ready!")
                    .font(.system(size: 36, weight: .medium, design: .default))
                    .foregroundColor(.atomindGreenText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                
                // --- NAVIGAZIONE ---
                NavigationLink(destination: NextPageView()) {
                    // Qui richiamiamo il tuo bottone personalizzato
                    TakeitView()
                }
                
                Spacer()
                
                // --- Disclaimer ---
                Text("This is not a medical app")
                    .font(.footnote)
                    .foregroundColor(.atomindGreenText)
                    .opacity(0.8)
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

// --- IL COMPONENTE BOTTONE (TakeitView) ---
struct TakeitView: View {
    var body: some View {
        HStack(spacing: 4) {
            
            // Parte Sinistra ("Take")
            ZStack {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 50,
                    bottomLeading: 50,
                    bottomTrailing: 0,
                    topTrailing: 0
                ))
                .fill(Color.pillColor)
                .frame(width: 100, height: 65)
                
                Text("Take")
                    .font(.title2)
                    .fontWeight(.regular)
                    .italic()
                    .foregroundColor(.white.opacity(0.6))
            }
            
            // Parte Destra ("it!")
            ZStack {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 0,
                    bottomLeading: 0,
                    bottomTrailing: 50,
                    topTrailing: 50
                ))
                .fill(Color.pillColor)
                .frame(width: 90, height: 65)
                
                Text("it!")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .italic()
                    .foregroundColor(.white)
            }
        }
        .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 6)
    }
}

// --- Pagina di destinazione (Esempio) ---
struct NextPageView: View {
    var body: some View {
        VStack {
            Text("Sei entrato!")
                .font(.largeTitle)
                .foregroundColor(.gray)
        }
    }
}

// --- Preview solo per il tuo file ---
struct PrescriptionReadyView_Previews: PreviewProvider {
    static var previews: some View {
        PrescriptionReadyView()
    }
}
