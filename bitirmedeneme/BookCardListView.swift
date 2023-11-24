//
//  BookCardListView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 23.11.2023.
//

import SwiftUI

struct Card: View {
    var book: Book

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageDataString = book.imageDataString,
               let imageData = Data(base64Encoded: imageDataString),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
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

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(bookViewModel.books) { book in
                    NavigationLink(destination: BookDetailView(book: book, bookViewModel: bookViewModel)) {
                        Card(book: book)
                    }
                    .buttonStyle(PlainButtonStyle()) // NavigationLink için düzgün bir düğme stili
                }
                .padding()
            }
        }
        .navigationBarTitle("Kitaplar")
    }
}
