//
//   Mood.swift
//  MoodTrackerApp
//
//  Created by Admin on 06/03/2026.
//

import Foundation

struct Mood: Identifiable, Codable {
    var id = UUID()
    var emoji: String
    var name: String
}

let defaultMoods = [
    Mood(emoji: "😀", name:  "Feliz"),
    Mood(emoji: "😢", name:  "Triste"),
    Mood(emoji: "😡", name:  "Enojado"),
    Mood(emoji: "😨", name:  "Ansioso"),
    Mood(emoji: "🤔", name:  "Pensativo"),
    Mood(emoji: "💪", name:  "Fuerte")
]
