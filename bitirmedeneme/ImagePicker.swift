//
//  ImagePickerView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 21.11.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPickerPresented: Bool

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
                parent.uploadImage(uiImage)
            }
            parent.isPickerPresented = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPickerPresented = false
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func uploadImage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Resim verisi oluşturulamadı.")
            return
        }

        let storage = Storage.storage()
        let storageRef = storage.reference()

        if let user = Auth.auth().currentUser {
            let userUID = user.uid
            let imageRef = storageRef.child("images/\(userUID)/\(UUID().uuidString).jpg")

            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"

            let _ = imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Yükleme hatası: \(error.localizedDescription)")
                } else {
                    imageRef.downloadURL { (url, error) in
                                guard let downloadURL = url else {
                                    if let error = error {
                                        print("URL alınamadı: \(error.localizedDescription)")
                                    }
                                    return
                                }
                                print("Dosya URL'si: \(downloadURL)")

                                // Kitap bilgilerini Firebase Realtime Database'e ekleyin
                                if let userUID = user.uid? {
                                    let book = Book(title: "Sample Book", author: "Sample Author", genre: "Sample Genre", imageUrl: downloadURL.absoluteString, isBorrowed: false)
                                    uploadBookData(book: book, userID: userUID)
                                }
                            }
                }
            }
        }
    }

    func uploadBookData(book: Book, userID: String) {
        let ref = Database.database().reference().child("users").child(userID).child("books")
        let newBookRef = ref.childByAutoId()

        let bookData = BookData(book: book)

        newBookRef.setValue(bookData.dictionaryRepresentation)
    }
}

struct ImagePickerExample: View {
    @State private var selectedImage: UIImage?
    @State private var isPickerPresented = false

    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
            }

            Button("Resim Seç") {
                isPickerPresented.toggle()
            }
            .imagePicker(isPresented: $isPickerPresented, image: $selectedImage)
        }
        .padding()
    }
}

struct ImagePickerModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var image: UIImage?

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                ImagePicker(selectedImage: $image, isPickerPresented: $isPresented)
            }
    }
}

extension View {
    func imagePicker(isPresented: Binding<Bool>, image: Binding<UIImage?>) -> some View {
        self.modifier(ImagePickerModifier(isPresented: isPresented, image: image))
    }
}













