//
//  MoodViewModel.swift
//  MoodTrackerApp
//
//  Created by Admin on 06/03/2026.
//

import Foundation

class MoodViewModel: ObservableObject {
    @Published var moods: [Mood] = defaultMoods
    @Published var entries: [MoodEntry] = []
    
    func addEntry(mood: Mood, note: String) {
        let entry = MoodEntry(moodEmoji: mood.emoji,
                              moodName: mood.name,
                              note: note,
                              date: Date())
        
        entries.append(entry)
    }
}
