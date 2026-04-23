//
//  PracticeScreen.swift
//  Ztroke
//
//  Created by Zulkifli on 23/04/26.
//

import SwiftUI

struct PracticeScreen: View {
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                
                
                NavigationLink {
                    PostPracticeScreen().navigationBarBackButtonHidden(true)
                } label: {
                    Text("Finish Practice")
                        .font(.system(size: 17, weight: .semibold))
                        .padding(.horizontal, 120)
                        .padding(.vertical, 15)
                        .background(Color.navy)
                        .foregroundColor(.white)
                        .cornerRadius(100)
                }
                
                
                
            }
            
        }
    }
}

#Preview {
    PracticeScreen()
}
