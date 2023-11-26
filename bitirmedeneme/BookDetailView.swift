//
//  BookDetailView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookDetailView: View {
    var book: Book
    @ObservedObject var bookViewModel: BookViewModel

    var body: some View {
        VStack {
            if let imageUrl = book.imageUrl, imageUrl != "" {
                WebImage(url: URL(string: imageUrl) )
                    .resizable()
                    .placeholder(Image("book"))
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5)) // Fade Transition with duration
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

            Button(action: {
                // Kitabı ödünç al veya iade etme işlemleri burada gerçekleştirilebilir.
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
                    // Bu kısımda ödünç alma işlemleri yapılabilir
                }
            }) {
                Text(book.isBorrowed ? "İade Et" : "Ödünç Al")
                    .padding()
                    .background(book.isBorrowed ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(book.title)
    }
}



