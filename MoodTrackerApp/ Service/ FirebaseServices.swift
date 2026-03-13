//
//   FirebaseServices.swift
//  MoodTrackerApp
//
//  Created by Admin on 06/03/2026.
//
//
//import Foundation
//import FirebaseFirestore
//import FirebaseAuth
//
//
//class FirebaseService {
//    
//    let db = Firestore.firestore()
//
//    func saveEntry(mood: String, note: String) {
//
//        guard let userID = Auth.auth().currentUser?.uid else { return }
//
//        db.collection("users")
//            .document(userID)
//            .collection("entries")
//            .addDocument(data: [
//
//                "mood": mood,
//                "note": note,
//                "date": Date()
//            ])
//    }
//}
