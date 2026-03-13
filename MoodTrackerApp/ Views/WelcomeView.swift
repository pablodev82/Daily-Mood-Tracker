//
//  WelcomeView.swift
//  MoodTrackerApp
//
//  Created by Admin on 06/03/2026.
//

import SwiftUI

struct WelcomeView: View {
    @State private var animate = false
    
    var body: some View {
        VStack {  // ← Ya NO lleva NavigationView aquí
            VStack(spacing: 10) {
                
                VStack {
                    Text("Daily Mood tracker")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 40)
                        
                    
                    Image("Circle")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
                        .scaleEffect(animate ? 1.1 : 1.0)
                        .animation(Animation.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: animate)
                        .onAppear { animate = true }
                        .onDisappear { animate = false }
                }
            
                VStack {
                    Text("Explora el poder \nde tu Mente 🧠🚀😎")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                }
                .padding(20)
                 
                Text("Realice un seguimiento de su enfoque, equilibre sus emociones y mejore su estabilidad mental de manera efectiva")
                    .font(.body)
                    .padding(30)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                 
                Text("🙏")
                    .font(.custom("", size: 80))
                    
                NavigationLink(destination: EmotionView()) {
                    Text("Get Start")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("BackView").opacity(0.7))
                        .cornerRadius(20)
                }
            }
        }
        .padding(40)
        .navigationBarHidden(true)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WelcomeView()
        }
    }
}
