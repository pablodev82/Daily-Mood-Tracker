//
//  SubEmotionView.swift
//  MoodTrackerApp
//
//  Created by Admin on 06/03/2026.
//

import SwiftUI

struct SubEmotionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let options = [
        "Ira","Frustrado","Alegría","Bendecido",
        "Irritación","Odio","Molesto","Positivo","Festivo"
    ]
    
    let columns = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        
    ]
    
    var body: some View {
        VStack(spacing: 30) {
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
            
            
            Text("No te plieges. No lo diluyas. \n No intentes hacerlo logico. \n No adaptes tu propia alma a la costumbres de los demas. \n En lugar de todo eso, sigue tu propia obsesion inplacablemente")
                .font(.title3)
                .bold()
                .padding(20)
                .multilineTextAlignment(.center)
            
            Text("Elige una opción 👇")
                .font(.title)
                .fontWeight(.bold)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(options, id:\.self) { option in
                    NavigationLink(destination: DetailView()) {
                        Text(option)
                            .foregroundColor(.black)
                            .font(.callout)
                            .bold()
                            .frame(width: 90, height: 110)
                            .background(Color.orange).opacity(0.7)
                            .cornerRadius(25)
                    }
                }
            }
            
            
            Spacer()
        }
        .padding()
        
    }
}

struct SubEmotionView_Previews: PreviewProvider {
    static var previews: some View {
        SubEmotionView()
    }
}
