//
//  BookUpdateView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 7.12.2023.
//

import SwiftUI

struct BookUpdateView: View {
    @Binding var isEditing: Bool
    @ObservedObject var bookViewModel: BookViewModel
    @State public var updatedTitle: String
    @State public var updatedAuthor: String
    @State public var updatedGenre: String
    @State public var updatedImageUrl: String
    @State public var updatedIsBorrowed: Bool
    @State public var updatedImageDataString: String

    var body: some View {
        VStack {
            TextField("Yeni Başlık", text: $updatedTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Yeni Yazar", text: $updatedAuthor)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Yeni Tür", text: $updatedGenre)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Yeni Fotoğraf URL", text: $updatedImageUrl)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Toggle("Ödünç Alındı mı?", isOn: $updatedIsBorrowed)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                .padding()

            TextField("Yeni Resim Data", text: $updatedImageDataString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Güncelle") {
                if let book = bookViewModel.selectedBook {
                    bookViewModel.updateBookInfo(book: book, completion: { error in
                        print("")
                    }, updatedTitle: updatedTitle, updatedAuthor: updatedAuthor, updatedGenre: updatedGenre, updatedImageUrl: updatedImageUrl, updatedIsBorrowed: updatedIsBorrowed, updatedImageDataString: updatedImageDataString)
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(15)
        }
        .onAppear {
            // View açıldığında güncellenmiş bilgileri, kitap nesnesinden al
            updatedTitle = bookViewModel.selectedBook?.title ?? ""
            updatedAuthor = bookViewModel.selectedBook?.author ?? ""
            updatedGenre = bookViewModel.selectedBook?.genre ?? ""
            updatedImageUrl = bookViewModel.selectedBook?.imageUrl ?? ""
            updatedIsBorrowed = bookViewModel.selectedBook?.isBorrowed ?? false
            updatedImageDataString = bookViewModel.selectedBook?.imageDataString ?? ""
        }
    }

   /* func updateBookInfo() {
        // Güncellenmiş bilgileri kullanarak kitap nesnesini güncelle
        book.title = updatedTitle
        book.author = updatedAuthor
        book.genre = updatedGenre
        book.imageUrl = updatedImageUrl
        book.isBorrowed = updatedIsBorrowed
        book.imageDataString = updatedImageDataString

        // ViewModel üzerinden Firebase'e güncelleme talebini ilet
        bookViewModel.updateBookInfo(book: book) { error in
            if let error = error {
                print("Kitap güncellenirken bir hata oluştu: \(error.localizedDescription)")
            } else {
                print("Kitap başarıyla güncellendi.")
                isEditing = false
            }
        }
    }*/

}








