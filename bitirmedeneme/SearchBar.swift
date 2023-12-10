//
//  SearchBar.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var placeholder: String
    var onCommit: () -> Void 

    var body: some View {
        HStack {
            TextField(placeholder, text: $searchText, onCommit: onCommit)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.white))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 11)

                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing,13)
                            }
                        }
                    }
                )
        }
    }
}




