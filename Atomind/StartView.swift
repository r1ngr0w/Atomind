//
//  StartView.swift
//  Atomind
//
//  Created by AFP FED 05 on 15/12/25.
//

import SwiftUI

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
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 370)
                        .opacity(0.2)
                    
                    Spacer()
                }
                .ignoresSafeArea()
                .allowsHitTesting(false)
                
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
                    // HERE IS THE CHANGE: We point to AddTaskView()
                    NavigationLink(destination: AddTaskView()) {
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
        }
    }
}

// Preview
struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
