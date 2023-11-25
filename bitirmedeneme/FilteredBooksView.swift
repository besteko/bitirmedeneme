//
//  FiltretedBooksView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//

// FilteredBooksView.swift

import SwiftUI

struct FilteredBooksView: View {
    @ObservedObject var bookViewModel: BookViewModel
    var selectedGenre: String

    @State private var searchText = ""

    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)

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
            if error == nil {
                // Kitap başarıyla kaldırıldı
            }
        }
    }

    var filteredBooks: [Book] {
        let genreFilteredBooks = bookViewModel.books.filter { $0.genre == selectedGenre }
        if searchText.isEmpty {
            return genreFilteredBooks
        } else {
            return genreFilteredBooks.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
}





