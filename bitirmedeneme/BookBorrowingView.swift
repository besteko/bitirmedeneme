//
//  BookBorrowingView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 23.12.2023.
//

import SwiftUI

struct BookBorrowingView: View {
    @Binding var isPresented: Bool
    @ObservedObject var bookViewModel: BookViewModel
    @State private var selectedDurationIndex = 0
    @State private var address = ""
    @State private var isBorrowingConfirmed = false

    // Ödünç alınan kitapları göstermek için BorrowedBooksView'i kullanma
    @State private var showBorrowedBooksView = false

    var body: some View {
        VStack {
            if let selectedBook = bookViewModel.selectedBook {
                // Seçilen kitabın adını göster
                Text("Seçilen Kitap: \(selectedBook.title)")
                    .font(.headline)
                    .padding()
            }

            Picker("Ödünç Süresi", selection: $selectedDurationIndex) {
                Text("1 Hafta").tag(0)
                Text("2 Hafta").tag(1)
                Text("3 Hafta").tag(2)
                Text("1 Ay").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            TextField("Adresinizi Girin", text: $address)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                // Ödünç alma onayı burada yapılacak
                isBorrowingConfirmed.toggle()

                // Ödünç alım onaylandığında BorrowedBooksView'i göster
                if isBorrowingConfirmed {
                    showBorrowedBooksView.toggle()
                }
            }) {
                Text("Ödünç Almayı Onayla")
                    .padding()
                    .foregroundColor(.white)
                    .font(.headline)
                    .background(Color.green)
                    .cornerRadius(15)
            }
            .padding()

            // Ödünç alım onayı yapıldığında BorrowedBooksView'i göster
            if isBorrowingConfirmed {
                Text("Kitap ödünç alındı!").foregroundColor(.green).bold()
            }

            // BorrowedBooksView'i gösterme
            NavigationLink(
                destination: BorrowedBooksView(bookViewModel: bookViewModel),
                isActive: $showBorrowedBooksView
            ) {
                EmptyView()
            }
        }
        .padding()
    }
}

struct BookBorrowingView_Previews: PreviewProvider {
    static var previews: some View {
        BookBorrowingView(isPresented: .constant(true), bookViewModel: BookViewModel())
    }
}


