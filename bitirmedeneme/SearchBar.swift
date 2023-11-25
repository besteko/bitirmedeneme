//
//  SearchBar.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            TextField("Kitap Ara", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    // Klavye görünene kadar arama metnini temizle
                    searchText = ""
                }

            if !searchText.isEmpty {
                Button(action: {
                    // Temizleme butonuna tıklanınca arama metnini temizle
                    searchText = ""
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}




