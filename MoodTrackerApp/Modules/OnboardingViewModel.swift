//
//  OnboardingViewModel.swift
//  MoodTrackerApp
//
//  Created by Admin on 12/03/2026.
//

import SwiftUI
import Combine

class OnboardingViewModel: ObservableObject {
    @Published var currentPage = 0
    @Published var userName = ""
    @Published var isNameValid = false
    @Published var notificationEnabled = false
    @Published var selectedEmotions: Set<UUID> = []
    @Published var onboardingCompleted = false
    
    var canProceedFromNamePage: Bool {
        !userName.isEmpty && userName.count >= 2
    }
    
    var canProceedFromEmotionsPage: Bool {
        selectedEmotions.count >= 3
    }
    
    func completeOnboarding(appState: AppState) {
        appState.userName = userName
        UserDefaults.standard.set(true, forKey: "username")
        
        UserDefaults.standard.set(true, forKey: "onboardingCompleted")
        
        if notificationEnabled {
            requestNotificationPermission()
        }
        
        onboardingCompleted = true
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    self.scheduleDailyReminder()
                }
            }
        }
    }
    
    private func scheduleDailyReminder() {
        let content = UNMutableNotificationContent()
        content.title = "Daily Mood "
        content.body = "¿Como te sientes hoy? Registra tu estado de animo"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}
