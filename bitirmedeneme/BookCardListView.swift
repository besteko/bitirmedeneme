//
//  BookCardListView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 23.11.2023.
//

import SwiftUI
import FirebaseStorage

struct Card: View {
    var book: Book

    var body: some View {
        VStack {
            if let imageDataString = book.imageDataString,
               let imageData = Data(base64Encoded: imageDataString),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            } else {
                Image(systemName: "book")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(book.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text(book.author)
                    .font(.headline)
                    .foregroundColor(.secondary)

                Spacer()
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}
struct BookCardListView: View {
    @ObservedObject var bookViewModel: BookViewModel
    @Binding var searchText: String

    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 16)], spacing: 16) {
                    ForEach(filteredBooks) { book in
                        NavigationLink(destination: BookDetailView(book: book, bookViewModel: bookViewModel)) {
                            Card(book: book)
                                .aspectRatio(2/3, contentMode: .fit) // Düzeltilen kısım
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationBarTitle("Kitaplar")
        }
    }

    private var filteredBooks: [Book] {
        if searchText.isEmpty {
            return bookViewModel.books
        } else {
            return bookViewModel.books.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.author.localizedCaseInsensitiveContains(searchText)
                // Diğer arama kriterlerini ekleyebilirsiniz
            }
        }
    }
}







