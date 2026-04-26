//
//  CameraSetUp.swift
//  Ztroke
//
//  Created by Zulkifli on 23/04/26.
//

import SwiftUI

struct CameraSetUp: View {
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
                        .font(.ztrokeTitle)
                        .padding(.bottom, 30)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: Radius.sm)
                            .frame(width: 370, height: 75)
                            .foregroundStyle(Color.gray)
                            .opacity(0.3)
                        
                        HStack {
                            Image(systemName:"tennis.racket.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.navy)
                            
                            VStack {
                                Text("Encouragement")
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                    .padding(.trailing, 160)
                                    .padding(.bottom, 3)
                                
                                Text("Utilise racket arc will improve for best experience\nand your training.")
                                    .font(.system(size: 12, weight: .regular, design: .default))
                                
                            }
                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: Radius.sm)
                            .frame(width: 370, height: 75)
                            .foregroundStyle(Color.gray)
                            .opacity(0.3)
                        
                        HStack {
                            Image(systemName:"phone.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.navy)
                            
                            
                            VStack {
                                Text("Phone Position")
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                    .padding(.trailing, 160)
                                    .padding(.bottom, 3)
                                
                                Text("Positioning your phone in an ideal height that fit\nwith your body.")
                                    .font(.system(size: 12, weight: .regular, design: .default))
                                
                            }
                        }
                        .padding(.leading,-5)
                    }
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: Radius.sm)
                            .frame(width: 370, height: 90)
                            .foregroundStyle(Color.gray)
                            .opacity(0.3)
                        
                        HStack {
                            Image(systemName:"accessibility")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.navy)
                            
                            VStack {
                                Text("Body Distance")
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                    .padding(.trailing, 160)
                                    .padding(.bottom, 3)
                                
                                Text("Positioning yourself in an ideal distance in front of\nyour phone with the full body and racket arc fit\nwithin the frame.")
                                    .font(.system(size: 12, weight: .regular, design: .default))
                                    .padding(.leading, 10)
                                
                            }
                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: Radius.sm)
                            .frame(width: 370, height: 100)
                            .foregroundStyle(Color.gray)
                            .opacity(0.3)
                        
                        HStack {
                            Image(systemName:"circle.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.navy)
                            //   .padding(.leading, 15)
                            
                            VStack {
                                Text("Start & End Session")
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                    .padding(.leading, -115)
                                    .padding(.bottom, 3)
                                
                                Text("Tap record to begin the practice. The App will\nauto-detects your swing angle during practice.\nTap again to finish session and will direct you to\nthe recap of your practice.")
                                    .font(.system(size: 12, weight: .regular, design: .default))
                                    .padding(.leading, 5)
                            }
                        }
                        .padding(.leading,-10)
                    }
                    Spacer()
                    
                    NavigationLink {
                        ForehandView().navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Start Session")
                            .font(.ztrokeCTALabel)
                            .padding(.horizontal, 122)
                            .padding(.vertical, 15)
                            .background(Color.navy)
                            .foregroundColor(.white)
                            .cornerRadius(Radius.full)
                    }
                    
                    
                }
            }
            
            
            
            Spacer()
            
            
            
        }
    }
}

#Preview {
    CameraSetUp()
}
