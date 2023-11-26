//
//  TabBarView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 23.11.2023.
//
import SwiftUI

struct TabBarView: View {
    @ObservedObject var bookViewModel: BookViewModel
    @Binding var searchText: String
    
    var body: some View {
        TabView {
            // Ana Sayfa
            NavigationView {
                BookCardListView(bookViewModel: bookViewModel, searchText: $searchText)
                    .navigationBarTitle("Ana Sayfa")
            }
            .tabItem {
                Label("Ana Sayfa", systemImage: "house")
            }

            // Kitap Ekle
            NavigationView {
                AddBookView(bookViewModel: bookViewModel)
                    .navigationBarTitle("Kitap Ekle")
            }
            .tabItem {
                Label("Kitap Ekle", systemImage: "book")
            }

            // Profil
            NavigationView {
                ProfileView(bookViewModel: bookViewModel)
                    .navigationBarTitle("Profil")
            }
            .tabItem {
                Label("Profil", systemImage: "person")
            }

            // Ödünç Al
            NavigationView {
                BorrowedBooksView(bookViewModel: bookViewModel)
                    .navigationBarTitle("Ödünç Al/Kirala")
            }
            .tabItem {
                Label("Ödünç Al", systemImage: "person.2.square.stack")
            }
        }
        .environmentObject(bookViewModel)
    }
}




