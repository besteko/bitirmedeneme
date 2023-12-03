//
//  SplashScreen.swift
//  bitirmedeneme
//
//  Created by Beste Kocaoglu on 21.11.2023.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 1.2, green: 1.1, blue: 0.9)
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    Text("WELCOME TO")
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 0.5, green: 0.4, blue: 0.1))
                        .multilineTextAlignment(.center)
                        .bold()
                        .padding(40)
                        .shadow(color: .orange, radius: 20)

                    Image("bookstack")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .shadow(color: .orange, radius: 20)

                    Text("BOOK BRIDGE")
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 0.5, green: 0.4, blue: 0.1))
                        .multilineTextAlignment(.center)
                        .bold()
                        .padding(40)
                        .shadow(color: .orange, radius: 30)

                    NavigationLink(destination: LoginView()) {
                        Text("Giriş yap")
                            .frame(width: 130, height: 60)
                            .background(Color(red: 0.5, green: 0.4, blue: 0.1))
                            .foregroundColor(Color.yellow)
                            .cornerRadius(30)
                            .padding(.vertical, 50)
                            .shadow(color: .orange, radius: 5)
                    }
                    .navigationBarHidden(true)

                    NavigationLink(destination: RegisterView()) {
                        Text("Hesabınız yok mu? Kaydol")
                            .padding(.vertical, 20) // Daha düzenli bir görünüm için boyutu azalttım
                            .foregroundColor(.brown)
                            .underline()
                    }
                    .navigationBarHidden(true)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

