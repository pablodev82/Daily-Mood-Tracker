//
//  OnboardingView.swift
//  MoodTrackerApp
//
//  Created by Admin on 12/03/2026.
//
import SwiftUI

// MARK: - Modelo Emotion
struct Emotion: Identifiable, Codable {
    var id = UUID()
    let name: String
    let nameEN: String
    let icon: String
    let colorHex: String
    
    var color: Color {
        Color(hex: colorHex) ?? .purple
    }
    
    // CodingKeys para Codable
    enum CodingKeys: String, CodingKey {
        case id, name, nameEN, icon, colorHex
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        nameEN = try container.decode(String.self, forKey: .nameEN)
        icon = try container.decode(String.self, forKey: .icon)
        colorHex = try container.decode(String.self, forKey: .colorHex)
    }
    
    init(name: String, nameEN: String, icon: String, colorHex: String) {
        self.id = UUID()
        self.name = name
        self.nameEN = nameEN
        self.icon = icon
        self.colorHex = colorHex
    }
}

// MARK: - Color Extension
extension Color {
    init?(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        self.init(
            .sRGB,
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0,
            opacity: 1.0
        )
    }
}

// MARK: - Onboarding ViewModel
//class OnboardingViewModel: ObservableObject {
//    @Published var currentPage = 0
//    @Published var userName = ""
//    @Published var notificationsEnabled = false
//    @Published var selectedEmotions = Set<UUID>()
//    @Published var onboardingCompleted = false
//    
//    var canProceedFromNamePage: Bool {
//        !userName.isEmpty && userName.count >= 2
//    }
//    
//    var canProceedFromEmotionsPage: Bool {
//        selectedEmotions.count >= 3
//    }
//    
//    func completeOnboarding(appState: AppState) {
//        appState.userName = userName
//        UserDefaults.standard.set(userName, forKey: "userName")
//        UserDefaults.standard.set(true, forKey: "onboardingCompleted")
//        
//        if notificationsEnabled {
//            requestNotificationPermission()
//        }
//        
//        onboardingCompleted = true
//    }
//    
//    private func requestNotificationPermission() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
//            DispatchQueue.main.async {
//                if granted {
//                    self.scheduleDailyReminder()
//                }
//            }
//        }
//    }
//    
//    private func scheduleDailyReminder() {
//        let content = UNMutableNotificationContent()
//        content.title = "Daily Mood"
//        content.body = "¿Cómo te sientes hoy? Registra tu estado de ánimo"
//        content.sound = .default
//        
//        var dateComponents = DateComponents()
//        dateComponents.hour = 20
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request)
//    }
//}

// MARK: - Modelo de página
struct OnboardingPage {
    let title: String
    let subtitle: String
    let image: String
    let color: Color
}

// MARK: - Onboarding View Principal
struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @EnvironmentObject var appState: AppState
    @State private var animateContent = false
    @Binding var showOnboarding: Bool 
    
    let pages = [
        OnboardingPage(
            title: "Bienvenido a Daily Mood",
            subtitle: "Tu diario emocional personal",
            image: "face.smiling",
            color: Color("BackView")
        ),
        OnboardingPage(
            title: "Registra tus emociones",
            subtitle: "Lleva un seguimiento de cómo te sientes cada día",
            image: "chart.bar.fill",
            color: .blue
        ),
        OnboardingPage(
            title: "Recibe frases inspiradoras",
            subtitle: "Cada día una frase según tu estado de ánimo",
            image: "quote.bubble.fill",
            color: .green
        )
    ]
    
    var body: some View {
        ZStack {
            // Fondo
            backgroundGradient
            
            VStack {
                // Skip button
                if viewModel.currentPage < pages.count - 1 {
                    HStack {
                        Spacer()
                        Button("Saltar") {
                            withAnimation {
                                viewModel.currentPage = pages.count - 1
                            }
                        }
                        .foregroundColor(.gray)
                        .padding()
                    }
                }
                
                Spacer()
                
                // TabView con páginas
                pagesTabView
                    .frame(height: 450)
                
                Spacer()
                
                // Indicadores de página
                pageIndicators
                    .padding(.bottom, 20)
                
                // Botón siguiente
                nextButton
                    .padding(.bottom, 30)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                animateContent = true
            }
        }
    }
    
    // MARK: - Subvistas
    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                pages[min(viewModel.currentPage, pages.count-1)].color.opacity(0.3),
                Color.white
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        .animation(.easeInOut, value: viewModel.currentPage)
    }
    
    private var pagesTabView: some View {
        TabView(selection: $viewModel.currentPage) {
            // Páginas de bienvenida
            ForEach(0..<pages.count, id: \.self) { index in
                OnboardingPageView(page: pages[index])
                    .tag(index)
            }
            
            // Página de nombre
            NameInputPage(
                userName: $viewModel.userName,
                isValid: viewModel.canProceedFromNamePage
            )
            .tag(pages.count)
            
            // Página de notificaciones
            NotificationsPage(
                isEnabled: $viewModel.notificationEnabled
            )
            .tag(pages.count + 1)
            
            // Página de selección de emociones
            EmotionsSelectionPage(
                selectedEmotions: $viewModel.selectedEmotions,
                emotions: appState.userEmotions,
                isValid: viewModel.canProceedFromEmotionsPage
            )
            .tag(pages.count + 2)
            
            // Página final
            FinalPage(
                userName: viewModel.userName,
                onComplete: {
                    viewModel.completeOnboarding(appState: appState)
                    showOnboarding = false
                }
            )
            .tag(pages.count + 3)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    private var pageIndicators: some View {
        HStack(spacing: 8) {
            ForEach(0..<pages.count + 4, id: \.self) { index in
                Circle()
                    .fill(viewModel.currentPage == index ?
                          pages[min(index, pages.count-1)].color :
                          Color.gray.opacity(0.3))
                    .frame(
                        width: viewModel.currentPage == index ? 20 : 8,
                        height: viewModel.currentPage == index ? 20 : 8
                    )
                    .animation(.spring(), value: viewModel.currentPage)
            }
        }
    }
    
    private var currentButtonEnabled: Bool {
        switch viewModel.currentPage {
        case 0...2: return true
        case 3: return viewModel.canProceedFromNamePage
        case 4: return true
        case 5: return viewModel.canProceedFromEmotionsPage
        default: return true
        }
    }
    
    private var buttonTitle: String {
        viewModel.currentPage < pages.count + 3 ? "Siguiente" : "Comenzar"
    }
    
    private var buttonColors: [Color] {
        let color = pages[min(viewModel.currentPage, pages.count-1)].color
        return [color, color.opacity(0.7)]
    }
    
    private var nextButton: some View {
        Button(action: nextButtonTapped) {
            HStack {
                Text(buttonTitle)
                    .fontWeight(.semibold)
                Image(systemName: "arrow.right")
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: buttonColors),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(15)
            .padding(.horizontal)
            .opacity(currentButtonEnabled ? 1 : 0.5)
        }
        .disabled(!currentButtonEnabled)
    }
    
    func nextButtonTapped() {
        withAnimation(.spring()) {
            if viewModel.currentPage < pages.count + 3 {
                viewModel.currentPage += 1
            } else {
                viewModel.completeOnboarding(appState: appState)
            }
        }
    }
}

// MARK: - Página de bienvenida
struct OnboardingPageView: View {
    let page: OnboardingPage
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: page.image)
                .font(.system(size: 100))
                .foregroundColor(page.color)
                .scaleEffect(animate ? 1 : 0.5)
                .rotationEffect(.degrees(animate ? 0 : -10))
            
            Text(page.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(page.subtitle)
                .font(.title3)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                animate = true
            }
        }
    }
}

// MARK: - Página de nombre
struct NameInputPage: View {
    @Binding var userName: String
    let isValid: Bool
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.purple)
                .scaleEffect(animate ? 1 : 0.8)
            
            Text("¿Cómo te llamas?")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Tu nombre", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .autocapitalization(.words)
            
            if !isValid && !userName.isEmpty {
                Text("Mínimo 2 caracteres")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .onAppear {
            withAnimation(.spring()) {
                animate = true
            }
        }
    }
}

// MARK: - Página de notificaciones
struct NotificationsPage: View {
    @Binding var isEnabled: Bool
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "bell.badge.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .scaleEffect(animate ? 1 : 0.8)
            
            Text("¿Quieres recordatorios?")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Te enviaremos una notificación cada noche para que registres tu estado de ánimo")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Toggle("Activar recordatorios", isOn: $isEnabled)
                .padding(.horizontal, 40)
        }
        .padding()
        .onAppear {
            withAnimation(.spring()) {
                animate = true
            }
        }
    }
}

// MARK: - Página de selección de emociones
struct EmotionsSelectionPage: View {
    @Binding var selectedEmotions: Set<UUID>
    let emotions: [Emotion]
    let isValid: Bool
    @State private var animate = false
    
    let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 120), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundColor(.pink)
                .scaleEffect(animate ? 1 : 0.8)
            
            Text("Selecciona tus emociones favoritas")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Elige al menos 3")
                .font(.caption)
                .foregroundColor(isValid ? .green : .gray)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(emotions) { emotion in
                        EmotionChip(
                            emotion: emotion,
                            isSelected: selectedEmotions.contains(emotion.id)
                        ) {
                            if selectedEmotions.contains(emotion.id) {
                                selectedEmotions.remove(emotion.id)
                            } else {
                                selectedEmotions.insert(emotion.id)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .padding()
        .onAppear {
            withAnimation(.spring()) {
                animate = true
            }
        }
    }
}

// MARK: - Emotion Chip
struct EmotionChip: View {
    let emotion: Emotion
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(emotion.icon)
                    .font(.system(size: 40))
                
                Text(emotion.name)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .frame(width: 90, height: 90)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(isSelected ? emotion.color : emotion.color.opacity(0.2))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isSelected ? Color.white : Color.clear, lineWidth: 2)
            )
            .scaleEffect(isSelected ? 1.05 : 1.0)
            .animation(.spring(), value: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Página final
struct FinalPage: View {
    let userName: String
    let onComplete: () -> Void
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(.green)
                .scaleEffect(animate ? 1 : 0.5)
                .rotationEffect(.degrees(animate ? 0 : 180))
            
            Text("¡Todo listo, \(userName)!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Ya puedes comenzar a registrar tus emociones y descubrir patrones en tu estado de ánimo")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                animate = true
            }
        }
    }
}

// MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(showOnboarding: .constant(true))
            .environmentObject(AppState())
    }
}
