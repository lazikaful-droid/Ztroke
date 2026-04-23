//
//  TabView.swift
//  Ztroke
//
//  Created by Zulkifli on 22/04/26.
//

import SwiftUI

struct TabView: View {
    var body: some View {
        
        
        SwiftUI.TabView {
    //        MainScreen()
            
            HistoryScreen()
        }
    }
    
}

#Preview {
    TabView()
}
