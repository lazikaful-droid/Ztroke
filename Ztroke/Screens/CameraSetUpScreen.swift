//
//  CameraSetUpScreen.swift
//  Ztroke
//
//  Created by Zulkifli on 23/04/26.
//

import SwiftUI

struct CameraSetUpScreen: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.navy
                    .opacity(0.05)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Image(systemName: "camera.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.navy)
                    
                    Text("Camera Set Up")
                        .font(.system(size: 21, weight: .bold, design: .default))
                        .padding(.bottom, 30)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 370, height: 70)
                            .foregroundStyle(Color(.gray))
                            .opacity(0.3)
                        HStack{
                            
                            Image(systemName: "tennis.racket.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.navy)
                            
                            VStack{
                                Text("Encouragement")
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                    .padding(.trailing, 160)
                                    .padding(.bottom,3)
                                
                                Text("Utilise racket arc will improve for best experience\nand your training.")
                                    .font(.system(size: 12, weight: .regular, design: .default))
                                
                            }
                            
                        }
                        
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 370, height: 70)
                            .foregroundStyle(Color(.gray))
                            .opacity(0.3)
                        HStack{
                            
                            Image(systemName: "iphone.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.navy)
                            
                            VStack{
                                Text("Phone Position")
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                    .padding(.trailing, 170)
                                    .padding(.bottom,3)
                                
                                Text("Positioning your phone in an ideal height that fit\nwith your body.")
                                    .font(.system(size: 12, weight: .regular, design: .default))
                                    .padding(.leading,-10)
                                
                            }
                            
                        }
                        
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 370, height: 85)
                            .foregroundStyle(Color(.gray))
                            .opacity(0.3)
                        HStack{
                            
                            Image(systemName: "accessibility")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.navy)
                            
                            VStack{
                                Text("Body Distance")
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                    .padding(.trailing, 175)
                                    .padding(.bottom,3)
                                
                                Text("Positioning yourself in an ideal distance in front of\nyour phone with the full body and racket arc fit\nwithin the frame.")
                                    .font(.system(size: 12, weight: .regular, design: .default))
                                
                            }
                            
                        }
                        
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 370, height: 100)
                            .foregroundStyle(Color(.gray))
                            .opacity(0.3)
                        HStack{
                            
                            Image(systemName: "circle.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.navy)
                            
                            VStack{
                                Text("Start & End Session")
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                    .padding(.trailing, 135)
                                    .padding(.bottom,3)
                                
                                Text("Tap record to begin the practice. The App will auto-\ndetects your swing angle during practice. Tap again\nto finish session and will direct you to the recap of\nyour practice.")
                                    .font(.system(size: 12, weight: .regular, design: .default))
                                    .padding(.trailing, -8)
                                
                            }
                            
                        }
                        
                    }
                    Spacer()
                    
                    NavigationLink {
                        PracticeScreen().navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Start Session")
                            .font(.system(size: 17, weight: .semibold))
                            .padding(.horizontal, 122)
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
    CameraSetUpScreen()
}
