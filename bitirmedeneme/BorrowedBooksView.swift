//
//  BorrowedBooksView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 21.11.2023.
//

import SwiftUI

struct BorrowedBooksView: View {
    @ObservedObject var bookViewModel: BookViewModel

    init(bookViewModel: BookViewModel) {
        self.bookViewModel = bookViewModel
    }

    var body: some View {
        VStack {
            Text("Ödünç Alınan Kitaplar")
                .font(.title)
                .padding()

            List(bookViewModel.books.filter { $0.isBorrowed }) { borrowedBook in
                NavigationLink(destination: BookDetailView(book: borrowedBook, bookViewModel: bookViewModel)) {
                    BookRowView(book: borrowedBook) {
                        // Ödünç alınan kitapları geri verme işlemi burada yapılabilir
                        returnBook(borrowedBook)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
    }

    private func returnBook(_ book: Book) {
        // Ödünç alınan kitabı geri verme işlemleri burada yapılabilir
        // Örneğin: bookViewModel.returnBook(book: book) { error in
        //    if error == nil {
        //        // Kitap başarıyla geri verildi
        //    }
        // }
    }
}

struct BorrowedBooksView_Previews: PreviewProvider {
    static var previews: some View {
        BorrowedBooksView(bookViewModel: BookViewModel())
    }
}

