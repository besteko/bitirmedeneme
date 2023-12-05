//
//  HomeView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @StateObject var bookViewModel = BookViewModel()
    @State private var filteredBooks: [Book] = []

    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    if isHomeView {
                        HStack {
                            Image("bookstack")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 50)
                                .padding()
                            SearchBar(searchText: $searchText, placeholder: "", onCommit: {
                                // Metin girişi tamamlandığında yapılacak işlemler
                                // Burada kitapları arama işlemini tetikleyebilirsiniz.
                                filterBooks()
                                print("filter books")
                            })
                            .padding(.bottom, 10)
                        }
                    }
                    BookCardListView(bookViewModel: bookViewModel, searchText: $searchText)
                        //.navigationBarTitle("Ana Sayfa")
                }
            }
            .tabItem {
                Label("Ana Sayfa", systemImage: "house")
            }

            NavigationView {
                AddBookView(bookViewModel: bookViewModel)
                    //.navigationBarTitle("Kitap Ekle")
            }
            .tabItem {
                Label("Kitap Ekle", systemImage: "book")
            }

            NavigationView {
                ProfileView(bookViewModel: bookViewModel)
                    //.navigationBarTitle("Profil")
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
        .background(Color.white)
        .accentColor(.orange)
        .environmentObject(bookViewModel)
    }
    private func filterBooks() {
            // searchText boşsa, tüm kitapları göster
            if searchText.isEmpty {
                filteredBooks = bookViewModel.books
            } else {
                print("books title: ", bookViewModel.books.filter({$0.title.localizedStandardContains(searchText)}))
                print("books author: ", bookViewModel.books.filter({$0.author.localizedStandardContains(searchText)}))
                // Başlık veya yazar adına göre filtreleme yap
                filteredBooks = bookViewModel.books.filter { book in
                    book.title.localizedCaseInsensitiveContains(searchText) ||
                    book.author.localizedCaseInsensitiveContains(searchText)
                }
            }
        }


    private var isHomeView: Bool {
        // Burada sadece HomeView seçili olduğunda true döndüren bir mantık ekleyebilirsiniz.
        return true
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}













