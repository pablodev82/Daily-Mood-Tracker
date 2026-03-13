//
//  MoodTrackerAppApp.swift
//  MoodTrackerApp
//
//  Created by Admin on 06/03/2026.
//
 

import SwiftUI

@main
struct DailyMoodApp: App {
    @StateObject private var appState = AppState()
    @State private var showOnboarding = !UserDefaults.standard.bool(forKey: "onboardingCompleted")
    
    var body: some Scene {
        WindowGroup {
            if showOnboarding {
                OnboardingView(showOnboarding: $showOnboarding)
                    .environmentObject(appState)
                    .onDisappear {
                        showOnboarding = false
                    }
            } else {
                ContentView()
                    .environmentObject(appState)
            }
        }
    }
}

// MARK: - AppState (igual que antes)
class AppState: ObservableObject {
    @Published var userEmotions: [Emotion] = []
    @Published var userName: String = "Usuario"
    
    let defaultEmotions: [Emotion] = [
        Emotion(name: "Alegría", nameEN: "Joy", icon: "😊", colorHex: "#FFD700"),
        Emotion(name: "Tristeza", nameEN: "Sadness", icon: "😢", colorHex: "#4169E1"),
        Emotion(name: "Ira", nameEN: "Anger", icon: "😠", colorHex: "#FF4444"),
        Emotion(name: "Calma", nameEN: "Calm", icon: "😌", colorHex: "#87CEEB"),
        Emotion(name: "Energía", nameEN: "Energetic", icon: "⚡️", colorHex: "#32CD32"),
        Emotion(name: "Amor", nameEN: "Love", icon: "❤️", colorHex: "#FF69B4")
    ]
    
    init() {
        loadEmotions()
    }
    
    func loadEmotions() {
        if let savedEmotions = UserDefaults.standard.data(forKey: "userEmotions"),
           let decoded = try? JSONDecoder().decode([Emotion].self, from: savedEmotions) {
            userEmotions = decoded
        } else {
            userEmotions = defaultEmotions
        }
    }
    
    func getEmotion(by id: UUID) -> Emotion? {
        return userEmotions.first { $0.id == id }
    }
}
