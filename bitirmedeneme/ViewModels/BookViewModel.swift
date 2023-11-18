//
//  BookViewModel.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//
import Foundation
import Firebase


class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var filteredBooks: [Book] = []

    private var db = Firestore.firestore()

    func fetchBooks(forUserId userId: String) {
        db.collection("books").whereField("userId", isEqualTo: userId).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Hata: \(error?.localizedDescription ?? "Bilinmeyen bir hata oluştu.")")
                return
            }

            self.books = documents.compactMap { queryDocumentSnapshot in
                try queryDocumentSnapshot.data(as: Book.self)
            }
            self.filteredBooks = self.books // İlk yüklemede tüm kitapları göster
        }
    }

    func addBook(book: Book, completion: @escaping (Error?) -> Void) {
        do {
            var mutableBook = book
            mutableBook.userId = Auth.auth().currentUser?.uid
            let _ = try? db.collection("books").addDocument(from: mutableBook) { _, error in
                completion(error)
            }
        } catch {
            print("Hata: \(error.localizedDescription)")
            completion(error)
        }
    }

    func filterBooks(by query: String, category: String) {
        if query.isEmpty && category == "Tümü" {
            filteredBooks = books // Tüm kitapları göster
        } else if !query.isEmpty && category == "Tümü" {
            filteredBooks = books.filter { $0.title.localizedCaseInsensitiveContains(query) }
        } else if query.isEmpty && category != "Tümü" {
            filteredBooks = books.filter { $0.genre == category }
        } else {
            filteredBooks = books.filter { $0.title.localizedCaseInsensitiveContains(query) && $0.genre == category }
        }
    }
}


