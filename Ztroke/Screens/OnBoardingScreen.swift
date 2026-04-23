//
//  OnBoardingScreen.swift
//  Ztroke
//
//  Created by Zulkifli on 21/04/26.
//

import SwiftUI

// Mark: Data Model
struct OnBoardingPage: Identifiable {
    let id = UUID()
    let imageName: String
}

// On Boarding Screen
struct OnBoardingScreen: View {
    @State private var path = [String]()
    @State private var currentIndex: Int = 0
    
    let pages: [OnBoardingPage] = [
        OnBoardingPage(imageName: "Carousel1"),
        OnBoardingPage(imageName: "Carousel2"),
        OnBoardingPage(imageName: "Carousel3"),
        OnBoardingPage(imageName: "Carousel4"),
        OnBoardingPage(imageName: "Carousel5")
        
    ]
    
    var body: some View {
        NavigationStack {
            
            
            ZStack {
                Color.navy
                    .opacity(0.05)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    // Carousel 1
                    SwiftUI.TabView(selection: $currentIndex) {
                        ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                            CarouselCard(imageName: page.imageName)
                                .tag(index)
                                .padding(.horizontal, 16)
                            
                        }
                    }
                    
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 320)
                    .padding(.top, 32)
                    
                    // Dot Indicator
                    HStack(spacing: 8) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Circle()
                                .fill(index == currentIndex
                                      ? Color(.navy)
                                      : Color .gray.opacity(0.4))
                                .frame(width: index == currentIndex ? 10 : 8,
                                       height: index == currentIndex ? 10 : 8
                                )
                        }
                    }
                    
                    // Text View
                    VStack(spacing: 12) {
                        Text("Practice makes it perfect")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.navy)
                            .multilineTextAlignment(.center)
                        
                        Text("Practice with Zwing to improve\nyour stroke technique\nfor better badminton play.")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.navy)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                    }
                    .padding(.top, 32)
                    .padding(.horizontal, 32)
                    
                    Spacer()
                    
                    // Button to Main Screen
//                    NavigationLink(
//                        destination: MainScreen().navigationBarBackButtonHidden(true)
//                    )  {
//                        Text("Get Started")
//                            .font(.system(size: 17, weight: .semibold))
//                            .foregroundColor(.white)
//                            .frame(width: 325, height: 55)
//                            .background(Color(red: 0.1, green: 0.16, blue: 0.3))
//                            .cornerRadius(28)
//                            .padding(.horizontal, 24)
                      
                    NavigationLink {
                        MainScreen().navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Get Started")
                            .font(.system(size: 17, weight: .semibold))
                            .padding(.horizontal, 120)
                            .padding(.vertical, 15)
                            .background(Color.navy)
                            .foregroundColor(.white)
                            .cornerRadius(80)
                    }
                    
                    
                    
                }
                .padding(.bottom,-20)
            }
        }
        
    }
}

private struct CarouselCard: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 300, height: 250)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}


#Preview {
    OnBoardingScreen()
}
