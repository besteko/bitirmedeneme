//
//  TabBarView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 23.11.2023.
//

import SwiftUI

// Ayrı bir TabBar view'i oluştur
struct TabBarView: View {
    @ObservedObject var bookViewModel: BookViewModel

    var body: some View {
        TabView {
            // ... Burada tab içeriğini tanımla, yukarıdaki örneği kullanabilirsin

            // Örnek bir tab
            Text("Tab 1")
                .tabItem {
                    Label("Ana Sayfa", systemImage: "house")
                }

            // Örnek bir tab
            Text("Tab 2")
                .tabItem {
                    Label("Kitap Ekle", systemImage: "book")
                }
        }
    }
}

// TabBar view'i için önizleme
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(bookViewModel: BookViewModel())
    }
}


