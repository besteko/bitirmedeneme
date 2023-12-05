//
//  BookCardListView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 23.11.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct Card: View {
    var book: Book

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageUrl = book.imageUrl, !imageUrl.isEmpty {
                WebImage(url: URL(string: imageUrl))
                    .resizable()
                    .placeholder(Image("book_placeholder")) // Placeholder görsel
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5)) // Fade Transition with duration
                    .scaledToFill()
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(10)
            } else {
                Image(systemName: "book")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(10)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 8) // Metinlere yatay iç boşluk ekleyin

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct BookCardListView: View {
    @StateObject var bookViewModel: BookViewModel = BookViewModel()
    @Binding var searchText: String // searchText parametresi ekledik

    @State private var filteredBooks: [Book] = [] // filteredBooks'u burada tanımladık

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(filteredBooks) { book in
                    NavigationLink(destination: BookDetailView(book: book, bookViewModel: bookViewModel)) {
                        Card(book: book)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
            }
            .padding(.horizontal)
        }
        .onAppear {
            // İlk başta tüm kitapları göster
            filteredBooks = bookViewModel.books
        }
        .onChange(of: bookViewModel.books) { _ in
            // Kitaplar değiştiğinde, search text'i kullanarak filtrele
            filterBooks()
        }
    }

    private func filterBooks() {
        if searchText.isEmpty {
            // Eğer search text boşsa, tüm kitapları göster
            filteredBooks = bookViewModel.books
        } else {
            // Eğer search text doluysa, kitapları isim ve yazarına göre filtrele
            filteredBooks = bookViewModel.books.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.author.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}





