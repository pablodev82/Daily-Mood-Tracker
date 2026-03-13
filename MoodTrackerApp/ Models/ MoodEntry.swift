//
//   MoodEntry.swift
//  MoodTrackerApp
//
//  Created by Admin on 06/03/2026.
//

import Foundation

struct MoodEntry: Identifiable, Codable {
     var id = UUID()
     var moodEmoji: String
     var moodName: String
     var note: String
     var date: Date
}
