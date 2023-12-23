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
    
    // Assuming BorrowedBooksView expects a BookViewModel instance
    init(bookViewModel: BookViewModel) {
        self.bookViewModel = bookViewModel
    }
    
    @State private var selectedCategory = 0
    @State private var borrowedBooks: [Book] = []
    @State private var lentBooks: [Book] = []

    var body: some View {
        VStack {
            
            Image("book")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .padding(.all,30)

            // Kullanıcı adı
            Text(Auth.auth().currentUser?.displayName ?? "")
                .font(.headline)
                .foregroundColor(.primary)
                .padding()

            // Picker
            Picker(selection: $selectedCategory, label: Text("")) {
                Text("Ödünç Aldıklarım").tag(0)
                Text("Ödünç Verdiklerim").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Kitap Listesi
            if selectedCategory == 0 {
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
            } else {
                List(lentBooks) { book in
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text(book.author)
                            .font(.subheadline)
                        // Diğer kitap bilgilerini ekleyebilirsiniz
                    }
                }
                .onAppear {
                    fetchLentBooks()
                }
            }
        }
        .background(Color(red: 1.2, green: 1.1, blue: 0.9)) // Arka plan rengi
        .foregroundColor(.white) // Metin rengi
        .edgesIgnoringSafeArea(.all)
    }

    // Diğer fonksiyonlar burada

    func fetchBorrowedBooks() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        let dbRef = Database.database().reference().child("users").child(userId).child("books")

        dbRef.queryOrdered(byChild: "isBorrowed").queryEqual(toValue: true).observe(.value) { snapshot in
            var books: [Book] = []

            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let data = snapshot.value as? [String: Any],
                   let bookData = try? JSONSerialization.data(withJSONObject: data),
                   let decodedBook = try? JSONDecoder().decode(Book.self, from: bookData) {
                    books.append(decodedBook)
                }
            }

            borrowedBooks = books
        }
    }

    func fetchLentBooks() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        let dbRef = Database.database().reference().child("users").child(userId).child("books")

        dbRef.queryOrdered(byChild: "isBorrowed").queryEqual(toValue: false).observe(.value) { snapshot in
            var books: [Book] = []

            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let data = snapshot.value as? [String: Any],
                   let bookData = try? JSONSerialization.data(withJSONObject: data),
                   let decodedBook = try? JSONDecoder().decode(Book.self, from: bookData) {
                    books.append(decodedBook)
                }
            }

            lentBooks = books
        }
    }
}


struct BorrowedBooksView_Previews: PreviewProvider {
    static var previews: some View {
        BorrowedBooksView(bookViewModel: BookViewModel()) // BookViewModel örneği ekleyin
    }
}




