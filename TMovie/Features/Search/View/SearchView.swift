//
//  ContentView.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 15/10/25.
//

import SwiftUI
import SwiftData

struct SearchView: View {

    var body: some View {
        NavigationSplitView {
            List {
                
            }
        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
	SearchView()
}
