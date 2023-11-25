//
//  BookDetailView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct BookDetailView: View {
    var book: Book
    @ObservedObject var bookViewModel: BookViewModel

    var body: some View {
        VStack {
            if let imageDataString = book.imageDataString,
               let imageData = Data(base64Encoded: imageDataString),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom, 10)
            } else {
                Image(systemName: "book")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom, 10)
            }

            Text(book.title)
                .font(.title)
                .padding(.bottom, 5)

            Text("Yazar: \(book.author)")
                .padding(.bottom, 10)

            Text(book.isBorrowed ? "Ödünç Alındı" : "Müsait")
                .foregroundColor(book.isBorrowed ? .red : .green)
                .bold()
                .padding()

            borrowButton()
                .padding()

            Spacer()
        }
        .padding()
        .navigationTitle(book.title)
    }

    @ViewBuilder
    private func borrowButton() -> some View {
        if book.userId != Auth.auth().currentUser?.uid {
            Button(action: {
                // Kitapı ödünç al veya iade etme işlemleri burada gerçekleştirilebilir.
                if book.isBorrowed {
                    // Kitap ödünç alındıysa iade et
                    bookViewModel.returnBook(book: book) { error in
                        if let error = error {
                            // İade işleminde hata olursa burada işlemler yapılabilir
                            print("Kitap iade edilemedi: \(error.localizedDescription)")
                        } else {
                            // İade başarılı, belki başka bir şey yapabilirsiniz
                            print("Kitap başarıyla iade edildi")
                        }
                    }
                } else {
                    // Kitap müsaitse ödünç al
                    bookViewModel.borrowBook(book: book) { error in
                        if let error = error {
                            // Ödünç alma işleminde hata olursa burada işlemler yapılabilir
                            print("Kitap ödünç alınamadı: \(error.localizedDescription)")
                            showAlert(message: "Kitap ödünç alınamadı. \(error.localizedDescription)")
                        } else {
                            // Ödünç alma başarılı, belki başka bir şey yapabilirsiniz
                            print("Kitap başarıyla ödünç alındı")
                            showAlert(message: "Kitap başarıyla ödünç alındı.")
                        }
                    }
                }
            }) {
                Text(book.isBorrowed ? "İade Et" : "Ödünç Al")
                    .padding()
                    .background(book.isBorrowed ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        } else {
            // Kitap sahibi kullanıcıysa boş bir View döndür
            EmptyView()
        }
    }

    private func showAlert(message: String) {
        // Uyarı göstermek için kullanılacak fonksiyon
        // İsterseniz daha gelişmiş bir uyarı kullanabilirsiniz
        print("Uyarı: \(message)")
    }
}



