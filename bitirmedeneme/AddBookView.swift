//
//  AddBookView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

struct AddBookView: View {
    
    @StateObject var bookViewModel: BookViewModel

        init(bookViewModel: BookViewModel) {
            _bookViewModel = StateObject(wrappedValue: bookViewModel)
        }
    
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var selectedImage: UIImage?
    @State private var selectedImageUrl: String?
    @State private var isImagePickerPresented = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Kitap Adı", text: $title)
                    TextField("Yazar", text: $author)
                    TextField("Tür", text: $genre)
                }

                Section {
                    Button(action: {
                        // Resim seçiciyi aç
                        isImagePickerPresented.toggle()
                    }) {
                        HStack {
                            Image(systemName: "photo")
                            Text("Kitap Fotoğrafı Seç")
                        }
                    }
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(selectedImage: $selectedImage, isPickerPresented: $isImagePickerPresented) { selectedImageUrl in
                            self.selectedImageUrl = selectedImageUrl
                        }
                    }

                    // Seçilen resmi göster
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }

                Section {
                    Button("Kitabı Ekle") {
                        addBook()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Uyarı"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
            }
            //.navigationTitle("Kitap Ekle")
        }
    }
    private func addBook() {
        guard let currentUser = Auth.auth().currentUser else {
            showAlert(message: "Kullanıcı oturumu açmamış.")
            return
        }
        
        
        // Kullanıcının ID'sini al
        let userID = currentUser.uid

        var newBook = Book(
            title: title,
            author: author,
            genre: genre,
            userId: userID,
            imageUrl: selectedImageUrl,
            isBorrowed: false
        )
        
        if let selectedImage = selectedImage {
            bookViewModel.uploadImage(selectedImage) { imageUrl in
                newBook.imageUrl = imageUrl
                self.addBook(newBook: newBook)
            }
        } else {
            self.addBook(newBook: newBook)
        }

        // Firebase Storage'a fotoğrafı yükle

        // Firebase veritabanına ekle
//        let ref = Database.database().reference().child("books").childByAutoId()

        // Veritabanına eklendikten sonra ID'yi al ve kitap nesnesine ekle
//        ref.setValue(newBook.dictionary) { (error, _) in
//            if let error = error {
//                print("Hata oluştu: \(error.localizedDescription)")
//                showAlert(message: "Kitap eklenirken bir hata oluştu.")
//            } else {
//                // Veritabanına eklendikten sonra ID'yi al ve kitap nesnesine ekle
//                let bookID = ref.key
//                newBook.id = bookID

                // Kitabı ViewModel üzerinden ekleyin
//                bookViewModel.addBook(book: newBook) { (error) in
//                    if let error = error {
//                        print("ViewModel'a kitap ekleme hatası: \(error.localizedDescription)")
//                        showAlert(message: "Kitap eklenirken bir hata oluştu.")
//                    } else {
//                        // Kitap başarıyla ViewModel'a eklendi
//                        showAlert(message: "Kitap başarıyla eklendi.")
//                        resetForm() // Formu sıfırla
//                    }
//                }
                
//            }
//        }
    }

    private func addBook (newBook: Book) {
        bookViewModel.addBook(book: newBook) { (error) in
            if let error = error {
                print("ViewModel'a kitap ekleme hatası: \(error.localizedDescription)")
                showAlert(message: "Kitap eklenirken bir hata oluştu.")
            } else {
                // Kitap başarıyla ViewModel'a eklendi
                showAlert(message: "Kitap başarıyla eklendi.")
                resetForm() // Formu sıfırla
            }
        }
    }
    
    private func resetForm() {
        // Formdaki değerleri sıfırla
        title = ""
        author = ""
        genre = ""
        selectedImage = nil
    }

    // showAlert fonksiyonunu tanımla
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}
















