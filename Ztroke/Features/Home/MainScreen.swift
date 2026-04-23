//
//  MainScreen.swift
//  Ztroke
//
//  Created by Zulkifli on 22/04/26.
//

import SwiftUI

//struct PracticeHistory {
//    var id: UUID = UUID()
//    var date: String
//    var duration: String
//    var swingCount: Int
//    var correct: Int
//    var incorrect: Int
//}

struct MainScreen: View {
    
    //    let practiceCommitted: Int = 8
    //    let practiceDuration: String = "9H 40M"
    //    let totalSwing: Int = 200
    //    let correctSwing: Int = 150
    //    let incorrectSwing: Int = 50
    //    let accuracyRate: Int = 75
    // //   let history = PracticeHistory(
    //    var date: ("Monday, 23 March 2026"),
    //        duration: "40 Minutes",
    //        swingCount: 50,
    //        correct: 30,
    //        incorrect: 20
    //    )
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.navy)
                    .opacity(0.08)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Summary")
                        .font(.system(size: 21, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .padding(.trailing, 245)
                        .padding(.top, 50)
                    
                    SummaryView()
                        .padding(.top, -60)
                    
                    
                    PracticeCount()
                        .padding(.top, -53)
                    
                    NavigationLink(destination: HistoryScreen()) {
                        History()
                            .padding(.top, 6)
                        // .padding(.bottom, 10)
                    }
                    Text("Training Mode")
                        .font(.system(size: 17, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .opacity(0.9)
                        .padding(.trailing, 220)
                        .padding(.top, 30)
                    
                    
                    
                    HStack {
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 165, height: 140)
                                .foregroundStyle(Color(.navy))
                                .cornerRadius(20)
                            NavigationLink(destination: CameraSetUpScreen()) {
                                
                                VStack {
                                    Image(systemName: "figure.badminton")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .foregroundColor(.gold)
                                        .padding(.bottom, 5)
                                    
                                    Text("Forehand")
                                        .font(.system(size: 12, weight: .semibold, design: .default))
                                        .foregroundColor(.gold)
                                }
                            }
                        }
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 165, height: 140)
                                .foregroundStyle(Color(.navy))
                                .cornerRadius(20)
                            
                            
                            NavigationLink(destination: CameraSetUpScreen()) {
                                VStack {
                                    Image(systemName: "figure.badminton")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .foregroundColor(.gold)
                                        .scaleEffect(x: -1, y: 1)
                                        .padding(.bottom, 5)
                                    
                                    Text("Backhand")
                                        .font(.system(size: 12, weight: .semibold, design: .default))
                                        .foregroundColor(.gold)
                                }
                            }
                        }
                    }
                    
                    Text("Chose the stroke above to practice.")
                        .font(.system(size: 14, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .opacity(0.8)
                    
                }
                
                
                
                
                
            }
            
            
        }
    }
}

#Preview {
    MainScreen()
}
