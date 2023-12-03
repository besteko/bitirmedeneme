//
//  BookRowView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//


import SwiftUI

struct BookRowView: View {
    var book: Book
    var removeBookAction: () -> Void   // Yeni eklenen satır

    var body: some View {
        HStack {
            if let imageDataString = book.imageDataString,
               let imageData = Data(base64Encoded: imageDataString),
               let uiImage = UIImage(data: imageData) {

                // UIKit'ten SwiftUI'ye dönüşüm
                let swiftUIImage = Image(uiImage: uiImage)

                // Oluşturulan SwiftUI Image'i kullanın
                swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(5)
            } else {
                // Eğer imageDataString boş veya hatalı ise, varsayılan sistem kitap ikonunu kullanın
                Image("book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(5)
            }

            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.brown)
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.brown)
            }

            Spacer()

            Button(action: {
                removeBookAction()  // Yeni eklenen satır
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.orange)
            }
        }
        .padding(.vertical, 8)
    }
}




