//
//  SummaryView.swift
//  Ztroke
//
//  Created by Zulkifli on 22/04/26.
//

import SwiftUI

struct SummaryView: View {
    //  let committed: Int
    //   let duration: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 340, height: 160)
                .foregroundStyle(Color(.navy))
                .opacity(0.08)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Practice")
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .ignoresSafeArea()
                    .padding(.leading,20)
                    .padding(.top, 75)
               //     .padding(.leading,-45)
                
                HStack {
                    Image(systemName: "baseball.diamond.bases")
                        .resizable()
                        .frame(width: 140, height: 100)
                        .foregroundStyle(.navy)
                        .opacity(0.4)
                        .ignoresSafeArea()
                        .padding(.leading,40)
                        .padding(.bottom, 70)
                       .padding(.trailing,20)
                   
                     //  .padding(.leading,-30)
                    
                    VStack {
                        Text("8x")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .monospaced()
                            .padding(.trailing,90)
                          //  .padding(.leading,48)
                            .foregroundStyle(.black)
                        
                        Text("Practice Committted")
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                            .padding(.trailing,30)
                         //   .padding(.bottom, 1)
                        
                        Text("9H 40M")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .monospaced()
                            .padding(.top, 1)
                            .padding(.trailing,15)
                            .padding(.leading,-5)
                            .foregroundStyle(.black)
                        
                        Text("Practice Duration")
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                            .padding(.trailing,48)
                          //  .padding(.leading,32)
                            
                    }
                    .padding(.leading, -15)
                    .padding(.bottom, 75)
                    
                }
                
            }
            
        }
    }
}
#Preview {
    SummaryView()
}
