//
//  HeaderView.swift
//  MoodTrackerApp
//
//  Created by Admin on 08/03/2026.
//

// HeaderView.swift - Ejemplo CORRECTO
import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image("Circle")
                .resizable()
                .frame(width: 90, height: 90)
            Text("Daily Mood \nTracker")
                .font(.title)
                .bold()
        }
        // Sin NavigationView aquí ✅
    }
}

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .font(.title)
                .foregroundColor(.black)
                .frame(width: 40, height: 40, alignment: .center)
                .background(Circle().fill(Color.blue.opacity(0.2)))
        }
        .padding(.leading)
        
    }
}

extension View {
    func withCustomBackButton() -> some View {
        self.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
        CustomBackButton()
    }
}
