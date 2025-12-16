//
//  TakeitView.swift
//  Atomind
//
//  Created by AFP FED 46 on 15/12/25.
//

import SwiftUI

// ==========================================
// 2. IL COMPONENTE BOTTONE (Grafica Pillola)
// ==========================================
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
                .frame(width: 90, height: 65)
                
                Text("Take")
                    .font(.title2)
                    .fontWeight(.regular)
                    .italic()
                    .foregroundColor(.white)
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
                
                Text("it! ")
                    .font(.title2)
                    .fontWeight(.regular)
                    .italic()
                    .foregroundColor(.white)
            }
        }
        .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 6)
    }
}
