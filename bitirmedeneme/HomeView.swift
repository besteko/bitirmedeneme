import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @StateObject var bookViewModel = BookViewModel()
    @State private var filteredBooks: [Book] = [] // Burada filteredBooks'u state olarak ekledik

    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    if isHomeView {
                        HStack {
                            Image("bookstack")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 50)
                                .padding()
                            SearchBar(searchText: $searchText, placeholder: "", onCommit: filterBooks)
                                .padding(.bottom, 10)
                        }
                    }
                    BookCardGridView(bookViewModel: bookViewModel, searchText: $searchText)
                }
                .background(Color(red: 1.2, green: 1.1, blue: 0.9))
            }
            .tabItem {
                Label("Ana Sayfa", systemImage: "house")
            }

            NavigationView {
                AddBookView(bookViewModel: bookViewModel)
            }
            .tabItem {
                Label("Kitap Ekle", systemImage: "book")
            }

            NavigationView {
                ProfileView(bookViewModel: bookViewModel)
            }
            .tabItem {
                Label("Profil", systemImage: "person")
            }

            NavigationView {
                BorrowedBooksView(bookViewModel: bookViewModel)
                    .navigationBarTitle("Ödünç Al/Kirala")
            }
            .tabItem {
                Label("Ödünç Al", systemImage: "person.2.square.stack")
            }
        }
        .background(Color.white)
        .accentColor(.orange)
        .environmentObject(bookViewModel)
    }

    private func filterBooks() {
        filteredBooks = bookViewModel.filterBooks(with: searchText)
    }


    private var isHomeView: Bool {
        return true
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
/*
struct BookCardGridView: View {
    @ObservedObject var bookViewModel: BookViewModel
    @Binding var searchText: String
    @Binding var filteredBooks: [Book] // filteredBooks'u binding olarak ekledik

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(filteredBooks) { book in // filteredBooks'u burada kullanıyoruz
                    NavigationLink(destination: BookDetailView(book: book, bookViewModel: bookViewModel)) {
                        Card(book: book)
                            
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .padding(.horizontal)
        .onAppear {
            // Ekran görüntüsü belirdiğinde, filteredBooks'u güncelle
            filteredBooks = bookViewModel.filterBooks(with: searchText)
        }
    }
}
*/
