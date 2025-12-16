//
//  PrescriptionReadyView.swift
//  Atomind
//
//  Created by AFP FED 46 on 15/12/25.
//

import SwiftUI

// --- Estensione Colori ---
extension Color {
    static let atomindGreenText = Color(red: 0.15, green: 0.55, blue: 0.10)
    static let pillColor = Color(red: 0.28, green: 0.58, blue: 0.22)
}

// ==========================================
// 1. PRIMA SCHERMATA (Entry Point)
// ==========================================
struct PrescriptionReadyView: View {
    var body: some View {
        // Questa è l'unica NavigationStack principale
        NavigationStack {
            VStack {
                // Spazio superiore
                Spacer().frame(height: 50)
                
                // --- LOGO (atomindLogo) ---
                Image("atomindLogo") // Assicurati di avere questa immagine negli Assets
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
                
                // --- NAVIGAZIONE verso StartView ---
                NavigationLink(destination: StartView()) {
                    TakeitView() // Il tuo bottone personalizzato
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




// --- Preview ---
struct PrescriptionReadyView_Previews: PreviewProvider {
    static var previews: some View {
        PrescriptionReadyView()
    }
}
