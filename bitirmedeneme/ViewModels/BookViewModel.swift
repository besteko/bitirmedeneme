//
//  BookViewModel.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published private(set) var genres: [String] = []

    private var dbRef: DatabaseReference?

    init() {
        configureDatabase()
        fetchBooks()
    }

    private func configureDatabase() {
        dbRef = Database.database().reference().child("books")
    }

    private func fetchBooks() {
        dbRef?.observe(.value, with: { [weak self] snapshot in
            var newBooks: [Book] = []
            var newGenres: [String] = []

            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let data = snapshot.value as? [String: Any],
                   let bookData = try? JSONSerialization.data(withJSONObject: data),
                   let decodedBook = try? JSONDecoder().decode(Book.self, from: bookData) {
                    newBooks.append(decodedBook)

                    // Kitap türünü genres listesine ekle
                    if let genre = decodedBook.genre,
                       !genre.isEmpty {
                        newGenres.append(contentsOf: genre.components(separatedBy: ", "))
                    }
                }
            }

            self?.books = newBooks
            self?.genres = Array(Set(newGenres.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) })) // Duplicates'ları temizle
        })
    }

    func addBook(book: Book, completion: @escaping (Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            let error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı oturumu açmamış."])
            completion(error)
            return
        }

        var updatedBook = book
        updatedBook.userId = userId

        let bookRef = dbRef?.childByAutoId()
        bookRef?.setValue(updatedBook.dictionary) { (error, _) in
            completion(error)
        }
    }

    func removeBook(bookID: String, completion: @escaping (Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            let error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı oturumu açmamış."])
            completion(error)
            return
        }

        let bookRef = dbRef?.child(bookID)
        bookRef?.removeValue { (error, _) in
            completion(error)
        }
    }

    func returnBook(book: Book, completion: @escaping (Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            let error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı oturumu açmamış."])
            completion(error)
            return
        }

        guard let updatedBookIndex = books.firstIndex(where: { $0.id == book.id }) else {
            let error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Kitap bulunamadı."])
            completion(error)
            return
        }

        // İade işlemlerini burada gerçekleştirin
        // Örneğin: books[updatedBookIndex].isBorrowed = false

        // Güncellenmiş kitabı Firebase veritabanına yazma
        let bookRef = dbRef?.child(book.id ?? "")
        bookRef?.setValue(books[updatedBookIndex].dictionary) { (error, _) in
            completion(error)
        }
    }
}





