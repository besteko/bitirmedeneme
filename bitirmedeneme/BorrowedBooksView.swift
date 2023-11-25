//
//  BorrowedBooksView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 21.11.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct BorrowedBooksView: View {
    @ObservedObject var bookViewModel: BookViewModel
    @State private var borrowedBooks: [Book] = []

    var body: some View {
        VStack {
            List(borrowedBooks) { book in
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.author)
                        .font(.subheadline)
                    // Diğer kitap bilgilerini ekleyebilirsiniz
                }
            }
            .onAppear {
                fetchBorrowedBooks()
            }
        }
    }

    func fetchBorrowedBooks() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        // bookViewModel içindeki books dizisini filtrele
        borrowedBooks = bookViewModel.books.filter { $0.isBorrowed && $0.userId != userId }
    }
}


struct BorrowedBooksView_Previews: PreviewProvider {
    static var previews: some View {
        BorrowedBooksView(bookViewModel: BookViewModel()) // BookViewModel örneği ekleyin
    }
}


