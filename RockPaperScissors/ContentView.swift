//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Alex on 28.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["🤜🏼", "🤚🏼", "✌🏼"]
    @State private var currentChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var questionCount = 1
    @State private var isShowingAlert = false
    
    let maxQuestions = 10
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("\(questionCount <= maxQuestions ? "Round \(questionCount)" : " Game Over")")
                .font(.title)
                        
            VStack(spacing: 20) {
                Text("Move: \(moves[currentChoice])")
                    .font(.system(size: 60))
                Text("You must \(shouldWin ? "Win" : "Lose")")
                    .font(.title)
            }
            .padding(20)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
            
            Spacer()
            
            Section("Make your choice:") {
                HStack(spacing: 20) {
                    ForEach(0..<3) { number in
                            Button(moves[number], action: { buttonTapped(number) })
                    }
                    .buttonStyle(.bordered)
                    .font(.system(size: 80))
                }
            }
            
            Spacer()
            
            Text("Your score: \(score)")
                .font(.title)
            
            Spacer()
            Spacer()
        }
        .alert("Game Over", isPresented: $isShowingAlert) {
            Button("Restart", action: { reset() })
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    private func buttonTapped(_ answer: Int) {
        let winningMove = (currentChoice + 1) % 3
        let losingMove = (currentChoice + 2) % 3
        let correctAnswer = shouldWin ? winningMove : losingMove
        
        if answer != currentChoice {
            if answer == correctAnswer {
                score += 1
            } else {
                score -= 1
            }
        }
        
        questionCount += 1
        
        if questionCount > maxQuestions {
            isShowingAlert = true
        } else {
            nextRound()
        }
    }
    
    private func nextRound() {
        currentChoice = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    private func reset() {
        score = 0
        questionCount = 1
        nextRound()
    }
}

#Preview {
    ContentView()
}
