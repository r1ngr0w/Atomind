//
//  TaskDetailView.swift
//  Atomind
//
//  Created by AFP FED 23 on 18/12/25.
//

import SwiftUI

struct TaskDetailView: View {
    let task: TaskItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // Header con Icona e Titolo
                HStack(spacing: 15) {
                    Image(systemName: "pills.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Circle().fill(Color.green))
                    
                    Text(task.title)
                        .font(.largeTitle)
                        .bold()
                }
                .padding(.top)

                // Box Data e Ora
                VStack(alignment: .leading, spacing: 12) {
                    Text("WHEN")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(.green)
                        Text(task.startDate.format("EEEE, d MMMM yyyy"))
                    }
                    
                    HStack {
                        Image(systemName: "clock")
                            .foregroundStyle(.green)
                        Text(task.startDate.format("HH:mm"))
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)

                // Box Note
                VStack(alignment: .leading, spacing: 12) {
                    Text("MY NOTES")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                    
                    Text(task.notes.isEmpty ? "No additional notes for this task." : task.notes)
                        .font(.body)
                        .lineSpacing(4)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.05), radius: 10)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.gray.opacity(0.05))
    }
}
