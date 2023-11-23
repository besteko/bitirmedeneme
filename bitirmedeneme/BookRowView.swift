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
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(5)
            } else {
                Image(systemName: "book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(5)
            }

            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.author)
                    .font(.subheadline)
            }

            Spacer()

            Button(action: {
                removeBookAction()  // Yeni eklenen satır
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 8)
    }
}




