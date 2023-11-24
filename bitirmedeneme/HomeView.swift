//
//  HomeView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var bookViewModel = BookViewModel()

    var body: some View {
        TabView {
            NavigationView {
                BookCardListView()
                    .navigationBarTitle("Ana Sayfa")
            }
            .tabItem {
                Label("Ana Sayfa", systemImage: "house")
            }

            NavigationView {
                AddBookView(bookViewModel: bookViewModel)
                    .navigationBarTitle("Kitap Ekle")
            }
            .tabItem {
                Label("Kitap Ekle", systemImage: "book")
            }

            NavigationView {
                ProfileView(bookViewModel: bookViewModel)
                    .navigationBarTitle("Profil")
            }
            .tabItem {
                Label("Profil", systemImage: "person")
            }

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


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}




