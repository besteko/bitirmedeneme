//
//  BorrowingManager.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 3.01.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

class BorrowingManager: ObservableObject {
    @Published var isBorrowingConfirmed = false
    @Published var borrowedBooks: [BorrowedBook] = []
    @Published var lentBooks: [BorrowedBook] = []

    func borrowBook(book: Book, selectedDurationIndex: Int, address: String, selectedDate: Date) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        let borrowedBook = BorrowedBook(
            id: book.id ?? "",
            bookId: book.id ?? "",
            userId: userId,
            borrowedDate: selectedDate,
            returnDate: Calendar.current.date(byAdding: .weekOfYear, value: selectedDurationIndex + 1, to: selectedDate) ?? selectedDate,
            title: book.title,
            author: book.author
        )

        saveBorrowedBook(borrowedBook: borrowedBook)
        isBorrowingConfirmed = true
    }

    func saveBorrowedBook(borrowedBook: BorrowedBook) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        let dbRef = Database.database().reference().child("users").child(userId).child("borrowedBooks").child(borrowedBook.id ?? "")
        let borrowedBookData: [String: Any] = [
            "id": borrowedBook.id ?? "",
            "bookId": borrowedBook.bookId,
            "userId": borrowedBook.userId,
            "borrowedDate": borrowedBook.borrowedDate.timeIntervalSince1970,
            "returnDate": borrowedBook.returnDate.timeIntervalSince1970,
            "title": borrowedBook.title,
            "author": borrowedBook.author
        ]

        dbRef.setValue(borrowedBookData) { error, _ in
            if let error = error {
                print("Kitap ödünç alınırken hata oluştu: \(error)")
            } else {
                print("Kitap başarıyla ödünç alındı!")
            }
        }
    }

    func fetchBorrowedBooks() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        let dbRef = Database.database().reference().child("users").child(userId).child("borrowedBooks")

        dbRef.observe(.value) { snapshot in
            var books: [BorrowedBook] = []

            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let data = snapshot.value as? [String: Any],
                   let bookData = try? JSONSerialization.data(withJSONObject: data),
                   let decodedBook = try? JSONDecoder().decode(BorrowedBook.self, from: bookData) {
                    books.append(decodedBook)
                }
            }

            // Güncellenen kitap listesini yerel değişkene ata
            self.borrowedBooks = books
        }
    }

    func fetchLentBooks() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        let dbRef = Database.database().reference().child("users").child(userId).child("lentBooks")

        dbRef.observe(.value) { snapshot in
            var books: [BorrowedBook] = []

            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let data = snapshot.value as? [String: Any],
                   let bookData = try? JSONSerialization.data(withJSONObject: data),
                   let decodedBook = try? JSONDecoder().decode(BorrowedBook.self, from: bookData) {
                    books.append(decodedBook)
                }
            }

            // Güncellenen kitap listesini yerel değişkene ata
            self.lentBooks = books
        }
    }
}

