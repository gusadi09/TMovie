//
//  TabContainerView.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 22/10/25.
//

import SwiftUI

struct TabContainerView: View {
	@StateObject private var viewModel = TabContainerViewModel()
	
    var body: some View {
		TabView(selection: $viewModel.selectedTab) {
			Tab(value: .search) {
				SearchView()
			} label: {
				Image(systemName: "magnifyingglass")
				Text("Search")
			}
			
			Tab(value: .favorite) {
				FavoriteView()
			} label: {
				Image(systemName: "star.fill")
				Text("Favorite")
			}
		}
    }
}

#Preview {
    TabContainerView()
}
