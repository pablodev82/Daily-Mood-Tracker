//
//   EmotionView.swift
//  MoodTrackerApp
//
//  Created by Admin on 06/03/2026.
//

import SwiftUI

struct EmotionView: View {
    
    let emotions = [
        ("😀","Contento"),
        ("😂","Emoción"),
        ("😨","Nervioso"),
        ("😡","Enojado"),
        ("🤔","Pensativo"),
        ("🤢","Malestar"),
        ("😢","Triste"),
        ("💪","Fuerte"),
        ("😇","Bendito")
    ]
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        
        GeometryReader { geometry in
                    VStack(spacing: 0) {
                        HeaderView()
                            
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 25) {
                                Text("Hola ¿cómo estás?")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .padding(.top, 10)
                                
                                Text("🧠 Elije una emoción 👇")
                                    .font(.title3)
                                
                                LazyVGrid(columns: columns, spacing: 15) {
                                    ForEach(emotions, id: \.1) { emotion in
                                        NavigationLink(destination: SubEmotionView()) {
                                            VStack {
                                                Text(emotion.0)
                                                    .font(.system(size: 50))
                                                
                                                Text(emotion.1)
                                                    .font(.callout)
                                                    .bold()
                                                    .foregroundColor(.black)
                                                    .lineLimit(1)
                                                    .minimumScaleFactor(0.5)
                                            }
                                            .frame(width: 100, height: 120)
                                            .background(Color("BackView").opacity(0.2))
                                            .cornerRadius(20)
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                                
                                Text("🙏 Estas Emociones 🙏\nson pasajeras")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 20)
                                    .padding(.bottom, 30)
                            }
                            .frame(minWidth: geometry.size.width)
                        }
                    }
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("")
                .navigationBarBackButtonHidden(false)
               .navigationBarHidden(true)
            }
        }

 
struct EmotionView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView()
    }
}
