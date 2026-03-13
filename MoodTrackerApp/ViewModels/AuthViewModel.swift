//
//  AuthViewModel.swift
//  MoodTrackerApp
//
//  Created by Admin on 06/03/2026.
//
//
//import Foundation
//import FirebaseAuth
//
//class AuthViewModel: ObservableObject {
//
//    @Published var user: User?
//
//    func login(email: String, password: String) {
//
//        Auth.auth().signIn(withEmail: email, password: password) { result, error in
//
//            if let user = result?.user {
//                DispatchQueue.main.async {
//                    self.user = user
//                }
//            }
//        }
//    }
//
//    func register(email: String, password: String) {
//
//        Auth.auth().createUser(withEmail: email, password: password) { result, error in
//
//            if let user = result?.user {
//                DispatchQueue.main.async {
//                    self.user = user
//                }
//            }
//        }
//    }
//}
