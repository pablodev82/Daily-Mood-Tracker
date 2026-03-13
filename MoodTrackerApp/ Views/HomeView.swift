//
//   HomeView.swift
//  MoodTrackerApp
//
//  Created by Admin on 06/03/2026.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        VStack(spacing:30) {
            
            Text("💪")
                .font(.system(size:60))
            
            Text("Hoy fui al gym y me siento Fuerte")
                .font(.title3)
            
            Text("Actitud lo es todo")
                .font(.title)
                .bold()
            
            NavigationLink(destination: FinalView()) {
                
                Text("Continue")
                    .foregroundColor(.black)
                    .padding()
                    .frame(width:200)
                    .background(Color("BackView").opacity(0.7))
                    .cornerRadius(20)
            }
        }
    }
}

struct _HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
