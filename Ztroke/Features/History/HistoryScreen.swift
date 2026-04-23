//
//  HistoryScreen.swift
//  Ztroke
//
//  Created by Zulkifli on 22/04/26.
//

import SwiftUI

struct HistoryScreen: View {
    var body: some View {
        
        ZStack {
            Color(.navy)
                .opacity(0.08)
                .ignoresSafeArea()
            VStack{
                
                Text("History")
                    .font(.system(size: 21, weight: .bold, design: .default))
                    .foregroundColor(.black)
                    .padding(.trailing, 250)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 340, height: 700)
                        .foregroundStyle(Color(.navy))
                        .opacity(0.08)
                        .cornerRadius(20)
                    
                    VStack{
                        
                        Text("Senin, 23 March 2026")
                            .font(.system(size: 12, weight: .light, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 180)
                        //                    .padding(.top, 15)
                        //                    .padding(.bottom, 10)
                        
                        
                        Text("40 Menit")
                            .font(.system(size: 12, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 250)
                            .padding(.bottom, 10)
                        //                    .padding(.top, 15)
                        //
                        
                        
                        HStack{
                            Text("Ayunan: 50")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 70)
                            
                            Text("Correct: 30")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 35)
                            
                            Text("Incorrect: 20")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                        }
                        
                        Divider()
                            .frame(height: 1)
                        
                        Text("Senin, 23 March 2026")
                            .font(.system(size: 12, weight: .light, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 180)
                        //                    .padding(.top, 15)
                        //                    .padding(.bottom, 10)
                        
                        
                        Text("40 Menit")
                            .font(.system(size: 12, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 250)
                            .padding(.bottom, 10)
                        //                    .padding(.top, 15)
                        //
                        
                        
                        HStack{
                            Text("Ayunan: 50")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 70)
                            
                            Text("Correct: 30")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 35)
                            
                            Text("Incorrect: 20")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                        }
                        
                        Divider()
                            .frame(height: 1)
                        
                        Text("Senin, 23 March 2026")
                            .font(.system(size: 12, weight: .light, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 180)
                        //                    .padding(.top, 15)
                        //                    .padding(.bottom, 10)
                        
                        
                        Text("40 Menit")
                            .font(.system(size: 12, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 250)
                            .padding(.bottom, 10)
                        //                    .padding(.top, 15)
                        //
                        
                        
                        HStack{
                            Text("Ayunan: 50")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 70)
                            
                            Text("Correct: 30")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 35)
                            
                            Text("Incorrect: 20")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                        }
                        
                        Divider()
                            .frame(height: 1)
                        
                        Text("Senin, 23 March 2026")
                            .font(.system(size: 12, weight: .light, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 180)
                        //                    .padding(.top, 15)
                        //                    .padding(.bottom, 10)
                        
                        
                        Text("40 Menit")
                            .font(.system(size: 12, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 250)
                            .padding(.bottom, 10)
                        //                    .padding(.top, 15)
                        //
                        
                        
                        HStack{
                            Text("Ayunan: 50")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 70)
                            
                            Text("Correct: 30")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 35)
                            
                            Text("Incorrect: 20")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                        }
                        
                        Divider()
                            .frame(height: 1)
                        
                        Text("Senin, 23 March 2026")
                            .font(.system(size: 12, weight: .light, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 180)
                        //                    .padding(.top, 15)
                        //                    .padding(.bottom, 10)
                        
                        
                        Text("40 Menit")
                            .font(.system(size: 12, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 250)
                            .padding(.bottom, 10)
                        //                    .padding(.top, 15)
                        //
                        
                        
                        HStack{
                            Text("Ayunan: 50")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 70)
                            
                            Text("Correct: 30")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 35)
                            
                            Text("Incorrect: 20")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                        }
                        
                        Divider()
                            .frame(height: 1)
                        
                        Text("Senin, 23 March 2026")
                            .font(.system(size: 12, weight: .light, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 180)
                        //                    .padding(.top, 15)
                        //                    .padding(.bottom, 10)
                        
                        
                        Text("40 Menit")
                            .font(.system(size: 12, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 250)
                            .padding(.bottom, 10)
                        //                    .padding(.top, 15)
                        //
                        
                        
                        HStack{
                            Text("Ayunan: 50")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 70)
                            
                            Text("Correct: 30")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 35)
                            
                            Text("Incorrect: 20")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                        }
                        
                        Divider()
                            .frame(height: 1)
                        
                        Text("Senin, 23 March 2026")
                            .font(.system(size: 12, weight: .light, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 180)
                        //                    .padding(.top, 15)
                        //                    .padding(.bottom, 10)
                        
                        
                        Text("40 Menit")
                            .font(.system(size: 12, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 250)
                            .padding(.bottom, 10)
                        //                    .padding(.top, 15)
                        //
                        
                        
                        HStack{
                            Text("Ayunan: 50")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 70)
                            
                            Text("Correct: 30")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 35)
                            
                            Text("Incorrect: 20")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                        }
                        
                        Divider()
                            .frame(height: 1)
                        
                        Text("Senin, 23 March 2026")
                            .font(.system(size: 12, weight: .light, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 180)
                        //                    .padding(.top, 15)
                        //                    .padding(.bottom, 10)
                        
                        
                        Text("40 Menit")
                            .font(.system(size: 12, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 250)
                            .padding(.bottom, 10)
                        //                    .padding(.top, 15)
                        //
                        
                        
                        HStack{
                            Text("Ayunan: 50")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 70)
                            
                            Text("Correct: 30")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 35)
                            
                            Text("Incorrect: 20")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                        }
                        
                        Divider()
                            .frame(height: 1)
                        
                        Text("Senin, 23 March 2026")
                            .font(.system(size: 12, weight: .light, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 180)
                        //                    .padding(.top, 15)
                        //                    .padding(.bottom, 10)
                        
                        
                        Text("40 Menit")
                            .font(.system(size: 12, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 250)
                            .padding(.bottom, 10)
                        //                    .padding(.top, 15)
                        //
                        
                        
                        HStack{
                            Text("Ayunan: 50")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 70)
                            
                            Text("Correct: 30")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 35)
                            
                            Text("Incorrect: 20")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                        }
                        
                        Divider()
                            .frame(height: 1)
                        
                        Text("Senin, 23 March 2026")
                            .font(.system(size: 12, weight: .light, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 180)
                        //                    .padding(.top, 15)
                        //                    .padding(.bottom, 10)
                        
                        
                        Text("40 Menit")
                            .font(.system(size: 12, weight: .bold, design: .default))
                            .foregroundColor(.black)
                            .padding(.trailing, 250)
                            .padding(.bottom, 10)
                        //                    .padding(.top, 15)
                        //
                        
                        
                        HStack{
                            Text("Ayunan: 50")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 70)
                            
                            Text("Correct: 30")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .padding(.trailing, 35)
                            
                            Text("Incorrect: 20")
                                .font(.system(size: 10, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                        }
                        
                        Divider()
                            .frame(height: 1)
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                }
                
            }
        }
    }
}

#Preview {
    HistoryScreen()
}
