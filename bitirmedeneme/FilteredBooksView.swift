//
//  FiltretedBooksView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//

import SwiftUI

struct FilteredBooksView: View {
    @ObservedObject var bookViewModel: BookViewModel
    var selectedGenre: String

    @State private var searchText = "" // Added state for searchText

    var body: some View {
        VStack {
            SearchBar(searchText: $searchText, placeholder: "Kitap Ara", onCommit: {
                // Metin girişi tamamlandığında yapılacak işlemler
                // Örneğin, kitapları arama işlemi burada tetikleyebilirsiniz.
                filterBooks()
            })

            List(filteredBooks) { book in
                NavigationLink(destination: BookDetailView(book: book, bookViewModel: bookViewModel)) {
                    BookRowView(book: book) {
                        removeBook(book)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationBarTitle("\(selectedGenre) Kitapları")
    }

    private func removeBook(_ book: Book) {
        bookViewModel.removeBook(bookID: book.id ?? "") { error in
            // Kitap kaldırıldıktan sonra yapılacak işlemler
            if error == nil {
                // Kitap başarıyla kaldırıldı, belki başka bir şey yapabilirsiniz
            }
        }
    }

    var filteredBooks: [Book] {
        // Filter the books based on genre and search text
        let genreFilteredBooks = bookViewModel.books.filter { $0.genre == selectedGenre }
        if searchText.isEmpty {
            return genreFilteredBooks
        } else {
            return genreFilteredBooks.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private func filterBooks() {
        // Arama işlemini gerçekleştir
        // Bu fonksiyon, metin girişi tamamlandığında çağrılır
        // Bu noktada kitapları yeniden filtreleyebilir veya başka bir işlem gerçekleştirebilirsiniz.
        filterBooks()
    }
}




