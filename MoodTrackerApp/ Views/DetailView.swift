//
//   DetailView.swift
//  MoodTrackerApp
//
//  Created by Admin on 06/03/2026.
//
import SwiftUI

struct DetailView: View {
    
    @State private var text = ""
    
    var body: some View {
        
        VStack(spacing:20) {
            
            HStack  {
                Image("Circle")
                    .resizable()
                    .frame(width: 90, height: 90, alignment: .trailing)
                    
                Text("Daily Mood \nTracker")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
            }
            .padding(.trailing, 110)
            .padding(.bottom, 50)
            
            Text("Anota como te \nsientes Hoy 👇")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Text("escribe que es lo que te paso hoy \n ✏️  y lo que mas recuerdas ✏️")
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $text)
                .frame(height:200)
                .padding()
                .background(Color.orange.opacity(0.8))
                .cornerRadius(20)
            
            Spacer()
            
            NavigationLink(destination: FinalView()) {
                
                Text("Continue")
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 200)
                    .background(Color("BackView").opacity(0.7))
                    .cornerRadius(20)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
        
    }
}

struct _DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
