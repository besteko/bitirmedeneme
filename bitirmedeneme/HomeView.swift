//
//  HomeView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @ObservedObject var bookViewModel: BookViewModel
    @State private var newBookTitle: String = ""
    @State private var newBookAuthor: String = ""
    @State private var selectedCategory: String = "Tümü"
    @State private var searchQuery: String = ""

    var body: some View {
        VStack {
            Picker(selection: $selectedCategory, label: Text("Kategori Seç")) {
                Text("Tümü").tag("Tümü")
                Text("Roman").tag("Roman")
                Text("Bilim Kurgu").tag("Bilim Kurgu")
                // Diğer kategorileri ekleyin
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            TextField("Kitap Adı veya Türü Ara", text: $searchQuery, onCommit: {
                bookViewModel.filterBooks(by: searchQuery, category: selectedCategory)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            List(bookViewModel.filteredBooks) { book in
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.author)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .onAppear {
                // Kullanıcının kitaplarını yükleyin
                if let userId = Auth.auth().currentUser?.uid {
                    bookViewModel.fetchBooks(forUserId: userId)
                }
            }

            Spacer()

            HStack {
                TextField("Kitap Adı", text: $newBookTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Yazar", text: $newBookAuthor)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    let newBook = Book(title: newBookTitle, author: newBookAuthor, genre: selectedCategory)
                    bookViewModel.addBook(book: newBook)
                    // Yeni kitap ekledikten sonra text field'ları temizle
                    newBookTitle = ""
                    newBookAuthor = ""
                    // Kategoriyi "Tümü" olarak ayarla
                    selectedCategory = "Tümü"
                }) {
                    Text("Kitap Ekle")
                }
                .padding()
            }
        }
        .padding()
        .navigationBarTitle("Kitaplarım")
        .navigationBarItems(trailing: Button(action: {
            do {
                try Auth.auth().signOut()
                // Kullanıcı çıkış yaptıktan sonra uygun işlemleri gerçekleştirin
            } catch {
                print("Çıkış yaparken hata oluştu: \(error.localizedDescription)")
            }
        }) {
            Text("Çıkış Yap")
        })
    }
}
