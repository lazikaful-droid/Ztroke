//
//  PracticeCount.swift
//  Ztroke
//
//  Created by Zulkifli on 22/04/26.
//

import SwiftUI

struct PracticeCount: View {
    var body: some View {
        HStack {
           
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 165, height: 140)
                    .foregroundStyle(Color(.navy))
                    .opacity(0.08)
                    .cornerRadius(20)
                
                VStack(alignment: .leading){
                    Text("Practice Count")
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .padding(.top, 15)
                        .padding(.bottom, 10)
                        .padding(.trailing, 35)
                        .ignoresSafeArea()
                    
                    Text("Total Swing")
                        .font(.system(size: 12, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .opacity(0.8)
                       
                    
                    Text("200x")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(.black)
                        .ignoresSafeArea()
                    
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.navy)
                            .opacity(0.8)
                  
                        Text("150x")
                            .font(.system(size: 12, weight: .semibold, design: .default))
                            .foregroundColor(.black)
                        
                        Image(systemName: "wrongwaysign.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.navy)
                            .padding(.leading, 20)
                  
                        Text("50x")
                            .font(.system(size: 12, weight: .semibold, design: .default))
                            .foregroundColor(.black)
                    }
                    .padding(.bottom, 10)
                    .ignoresSafeArea()
                }
            }
            
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 165, height: 140)
                    .foregroundStyle(Color(.navy))
                    .opacity(0.08)
                    .cornerRadius(20)
                
                VStack(alignment: .leading){
                    Text("Accuracy")
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .foregroundColor(.black)
                     //   .padding(.top, 15)
                        .padding(.bottom, 20)
                        .padding(.trailing, 35)
                        .ignoresSafeArea()
                    
                    HStack{
                        Image(systemName: "location.north.fill")
                            .resizable()
                            .frame(width: 35, height: 45)
                            .foregroundColor(.navy)
                            .opacity(0.4)
                        
                        VStack{
                            Text("Average Rate")
                                .font(.system(size: 12, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                                .opacity(0.8)
                            //    .padding(.bottom, 5)
                            
                            Text("75%")
                                .font(.system(size: 40, weight: .semibold, design: .default))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.bottom, 15)
                }
            }
            
        }
      
    }
}

#Preview {
    PracticeCount()
}
