//
//  PostPracticeScreen.swift
//  Ztroke
//
//  Created by Zulkifli on 22/04/26.
//

import SwiftUI

struct PostPracticeScreen: View {
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color(.navy)
                    .opacity(0.08)
                    .ignoresSafeArea()
                VStack{
                    
                    Text("Great Job!!!")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .padding(.top, 50)
                        .padding(.trailing, 165)
                    
                    Text("You have been practice today.")
                        .font(.system(size: 21, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .padding(.trailing, 30)
                        .padding(.bottom, 20)
                    
                    
                    Text("Practice Summary")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .padding(.trailing, 90)
                    
                    VStack {
                        HStack{
                            Image(systemName: "gauge.with.needle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.navy)
                            
                            Text("Practice Duration:")
                                .font(.system(size: 20, weight: .regular, design: .default))
                                .foregroundColor(.black)
                            
                            Text("30 Minutes")
                                .font(.system(size: 20, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                            
                        }
                        
                        HStack{
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.navy)
                            
                            Text("Total swing:")
                                .font(.system(size: 20, weight: .regular, design: .default))
                                .foregroundColor(.black)
                            
                            Text("40 Times")
                                .font(.system(size: 20, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                            
                        }
                        .padding(.leading, -70)
                        
                        HStack{
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.navy)
                            
                            Text("Correct:")
                                .font(.system(size: 20, weight: .regular, design: .default))
                                .foregroundColor(.black)
                            
                            Text("30x")
                                .font(.system(size: 20, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                            
                        }
                        .padding(.leading, -152)
                        
                        HStack{
                            Image(systemName: "wrongwaysign.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.navy)
                            
                            Text("Incorrect:")
                                .font(.system(size: 20, weight: .regular, design: .default))
                                .foregroundColor(.black)
                            
                            Text("10x")
                                .font(.system(size: 20, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                            
                        }
                        .padding(.leading, -145)
                    }
                    Spacer()
                    
                    
                    //                Text("Done")
                    //                    .font(.system(size: 17, weight: .semibold))
                    //                    .foregroundColor(.white)
                    //                    .frame(width: 325, height: 55)
                    //                    .background(Color(red: 0.1, green: 0.16, blue: 0.3))
                    //                    .cornerRadius(28)
                    //                    .padding(.horizontal, 24)
                    
                    
                    NavigationLink {
                        MainScreen().navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Done")
                            .font(.system(size: 17, weight: .semibold))
                            .padding(.horizontal, 160)
                            .padding(.vertical, 15)
                            .background(Color.navy)
                            .foregroundColor(.white)
                            .cornerRadius(100)
                    }
                    
                    
                }
            }
        }
    }
}

#Preview {
    PostPracticeScreen()
}
