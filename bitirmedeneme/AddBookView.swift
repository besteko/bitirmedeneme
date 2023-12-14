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
            ZStack{
                Color(red: 1.2, green: 1.1, blue: 0.9)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 25) {
                    Image("addbooktab")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.top, 20)
                    
                    Section(header: Text("Kitap Bilgilerini Giriniz").font(.headline).foregroundColor(.orange)) {
                        TextField("Kitap Adı", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Yazar", text: $author)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Tür", text: $genre)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Section {
                        Button(action: {
                            // Resim seçiciyi aç
                            isImagePickerPresented.toggle()
                        }) {
                            HStack {
                                Image(systemName: "photo")
                                Text("Kitap Fotoğrafı Seç")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
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
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color(red: 1.2, green: 1.1, blue: 0.9).edgesIgnoringSafeArea(.all))
                //.navigationBarTitle("Kitap Ekle", displayMode: .inline)
            }
        }
    }

    private func addBook() {
        // addBook fonksiyonunun içeriği burada
    }

    private func resetForm() {
        // resetForm fonksiyonunun içeriği burada
    }

    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView(bookViewModel: BookViewModel())
    }
}















