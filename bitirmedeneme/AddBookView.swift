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
            VStack(spacing: 16) {
                Image("addbooktab")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.top, 8)
                
                Section(header: Text("Kitap Bilgilerini Giriniz").font(.headline).foregroundColor(.blue)) {
                    TextField("Kitap Adı", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Yazar", text: $author)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Tür", text: $genre)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                Section{
                    Button(action: {
                        // Resim seçiciyi aç
                        isImagePickerPresented.toggle()
                    }) {
                        HStack {
                            Image(systemName: "photo")
                            Text("Kitap Fotoğrafı Seç")
                                .foregroundColor(.brown)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
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
                            .cornerRadius(8)
                    }
                }

                Section {
                    Button("Kitabı Ekle") {
                        addBook()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8)
                }
                .background(Color(red: 1.2, green: 1.1, blue: 0.9))
            }
            .padding()
            //.navigationBarTitle("Kitap Ekle", displayMode: .inline)
        }


    }
    private func addBook() {
        guard !title.isEmpty, !author.isEmpty, !genre.isEmpty else {
                showAlert(message: "Lütfen tüm kitap bilgilerini girin.")
                return
            }
        
        guard selectedImage != nil else {
                showAlert(message: "Lütfen bir kitap fotoğrafı seçin.")
                return
            }

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















