//
//  BookData.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 22.11.2023.
//

import Foundation

struct BookData: Codable {
    var title: String
    var author: String
    var genre: String
    var isBorrowed: Bool
    var imageDataString: String?

    init(book: Book) {
        self.title = book.title
        self.author = book.author
        self.genre = book.genre
        self.isBorrowed = book.isBorrowed
        self.imageDataString = book.imageDataString
    }

    var dictionaryRepresentation: [String: Any] {
        return [
            "title": title,
            "author": author,
            "genre": genre,
            "isBorrowed": isBorrowed,
            "imageDataString": imageDataString ?? ""
        ]
    }
}

