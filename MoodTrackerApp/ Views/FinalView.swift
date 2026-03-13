//
//  FinalView.swift
//  MoodTrackerApp
//
//  Created by Admin on 06/03/2026.
//

import SwiftUI

struct FinalView: View {
    @State private var animateEmoji = false
    @State private var rotatePlanet = false
    
    
    var body: some View {
        VStack(spacing: 25) {
            HStack(spacing: 15)  {
                Image("Circle")
                    .resizable()
                    .frame(width: 90, height: 90, alignment: .trailing)

                Text("Daily Mood \nTracker")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
     

            HStack(spacing: 15) {
                Text("💪")
                    .font(.system(size: 55))
                    .scaleEffect(animateEmoji ? 1.2 : 1)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animateEmoji)
                    .onAppear {
                        animateEmoji = true
                    }
                    
                Text("Hoy fui al gym \ny me siento fuerte")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            
            Text("""
            Soy dinámico
            Soy perfeccionista
            Soy mi mejor versión
            """)
                .font(.title3)
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                

            Text("El Mundo es tuyo ve por él")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding() // padding antes del background para espacio interno
                .background(Color.green.opacity(0.2))
                .cornerRadius(20)

            Image("Tierra")
                .resizable()
                .scaledToFit()
                .frame(width: 160)
                .rotationEffect(.degrees(rotatePlanet ? 360 : 0))
                .animation(Animation.easeInOut(duration: 10).repeatForever(autoreverses: true), value: rotatePlanet)
                .onAppear {
                    rotatePlanet = true
                }
            
            Spacer()

            NavigationLink(destination: WelcomeView()) {
                Text("Back to Home")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("BackView").opacity(0.7))
                    .cornerRadius(20)
                    .scaleEffect(1)
                    .opacity(animateEmoji ? 1 : 0)
                    .offset(y: animateEmoji ? 0 : 40)
                    .animation(.easeOut(duration: 1), value: animateEmoji)
            }

            Spacer() // empuja todo hacia arriba
        }
        .padding(60)
        .navigationBarHidden(true)
    }
}

struct FinalView_Previews: PreviewProvider {
    static var previews: some View {
        FinalView()
    }
}
