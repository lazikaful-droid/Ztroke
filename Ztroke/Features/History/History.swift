//
//  History.swift
//  Ztroke
//
//  Created by Zulkifli on 22/04/26.
//

import SwiftUI

struct History: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 340
                       , height: 140)
                .foregroundStyle(Color(.navy))
                .opacity(0.08)
                .cornerRadius(20)
            
            VStack (alignment:.leading) {
                HStack {
                    Text("History")
                        .font(.system(size: 10, weight: .semibold, design: .default))
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                        .padding(.trailing, 150)
                    
                    
                        Image(systemName: "chevron.right.circle")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.black)
                            .padding(.leading, 90)
                    
                }
                .padding(.bottom, 10)
                
                Text("Monday, 23 March 2026")
                    .font(.system(size: 10, weight: .regular, design: .default))
                    .opacity(0.8)
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                    .padding(.trailing, 150)
                
                Text("40 Minutes")
                    .font(.system(size: 30, weight: .semibold, design: .default))
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                    .padding(.trailing, 150)
                    .padding(.bottom, 5)
                
                Text("Swing: 50")
                    .font(.system(size: 12, weight: .semibold, design: .default))
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                    .padding(.trailing, 150)
                    .padding(.bottom, 5)
                
                HStack {
                    Text("Correct: 30")
                        .font(.system(size: 10, weight: .semibold, design: .default))
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                    
                    Text("Incorrect: 20")
                        .font(.system(size: 10, weight: .semibold, design: .default))
                        .foregroundColor(.black)
                        .padding(.leading, 150)
                    
                }
            }
        }
    }
}

#Preview {
    History()
}
