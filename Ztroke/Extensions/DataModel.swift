//
//  DataModel.swift
//  Ztroke
//
//  Created by Zulkifli on 22/04/26.
//

import SwiftUI

struct HomeCard  {
    
    let id: UUID = UUID()
    let date: String
    let duration: String
    let swingCount: Int
    let correct: Int
    let incorrect: Int
}

struct DataModel: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DataModel()
}
