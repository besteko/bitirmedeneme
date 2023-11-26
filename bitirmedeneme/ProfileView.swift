//
//  ProfileView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 21.11.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ProfileView: View {
    @ObservedObject var bookViewModel: BookViewModel
    @State private var user: User?

    var body: some View {
        VStack {
            if let user = user {
                // Kullanıcının bilgilerini göster
                Text("Hoş geldin, \(user.displayName ?? "Bilinmeyen Kullanıcı")!")
                    .font(.title)

                // Kullanıcının eklediği kitapları göster
                List(bookViewModel.books.filter { $0.userId == user.uid }) { book in
                    NavigationLink(destination: BookDetailView(book: book, bookViewModel: bookViewModel)) {
                        BookRowView(book: book, removeBookAction: {})
                    }
                }
                .listStyle(PlainListStyle())
            } else {
                // Kullanıcı yoksa, giriş yapma ekranına yönlendir
                Text("Giriş yapmış bir kullanıcı bulunmamaktadır.")
            }

            Spacer()
        }
        .onAppear {
            // Kullanıcının oturum açmış olup olmadığını kontrol et
            if let currentUser = Auth.auth().currentUser {
                self.user = currentUser
            }
        }
        .padding()
        .navigationBarTitle("Profil")
    }
}
