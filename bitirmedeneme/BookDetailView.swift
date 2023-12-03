//
//  BookDetailView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth

struct BookDetailView: View {
    var book: Book
    @ObservedObject var bookViewModel: BookViewModel
    
    var body: some View {
        ZStack{
            Color(red: 1.2, green: 1.1, blue: 0.9)
                .edgesIgnoringSafeArea(.all)
            VStack {
                if let imageUrl = book.imageUrl, !imageUrl.isEmpty {
                    WebImage(url: URL(string: imageUrl))
                        .resizable()
                        .placeholder(Image("book"))
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFit()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.bottom, 20)
                } else {
                    Image(systemName: "book")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.bottom, 20)
                }
                
                Text(book.title)
                    .font(.title)
                    .bold()
                    .padding(.bottom, 5)
                    .foregroundColor(.brown)
                
                Text("Yazar: \(book.author)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 10)
                
                Text(book.isBorrowed ? "Ödünç Alındı" : "Müsait")
                    .foregroundColor(book.isBorrowed ? .red : .green)
                    .font(.headline)
                    .bold()
                    .padding()
                
                if let currentUser = Auth.auth().currentUser, book.userId != currentUser.uid {
                    Button(action: {
                        if book.isBorrowed {
                            bookViewModel.returnBook(book: book) { error in
                                if let error = error {
                                    print("Kitap iade edilemedi: \(error.localizedDescription)")
                                } else {
                                    print("Kitap başarıyla iade edildi")
                                }
                            }
                        } else {
                            // Ödünç alma işlemleri burada yapılabilir
                            
                        }
                    }) {
                        Text(book.isBorrowed ? "İade Et" : "Ödünç Al")
                            .padding()
                            .foregroundColor(.white)
                            .font(.headline)
                            .background(book.isBorrowed ? Color.red : Color.green)
                            .cornerRadius(15)
                    }
                    .padding(.bottom, 20)
                }
                
                Spacer()
            }
            .padding()
            //.navigationTitle(book.title)
        }
    }
    
}


