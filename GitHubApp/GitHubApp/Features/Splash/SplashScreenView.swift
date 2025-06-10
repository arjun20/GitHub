//
//  SplashScreenView.swift
//  GitHubApp
//
//  Created by Arjun Gautami on 24/05/25.
//
import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @StateObject private var router = AppRouter()

    var body: some View {
        if isActive {
            GitHubUserListView()
                .environmentObject(router)
        } else {
            VStack {
                Image("GitHub")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                Text("Welcome to GitHubApp")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(Theme.background).ignoresSafeArea())
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

