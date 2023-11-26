//
//  HomeView.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 18.11.2023.
//


import SwiftUI

struct HomeView: View {
    @StateObject var bookViewModel = BookViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {

                TabBarView(bookViewModel: bookViewModel, searchText: $searchText)
                    //.navigationBarTitle("Ana Sayfa")
            }
        }
        .environmentObject(bookViewModel)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}






