//
//  BookCardGridView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 6.12.2023.
//

import SwiftUI

struct BookCardGridView: View {
    @State private var isDetailViewPresented = false
    @ObservedObject var bookViewModel: BookViewModel
    @Binding var searchText: String

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(bookViewModel.filterBooks(with: searchText)) { book in
                    NavigationLink(destination: BookDetailView(isPresented: $isDetailViewPresented, bookViewModel: BookViewModel(selectedBook: book))) {
                        Card(book: book)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .padding(.horizontal)
    }
}

