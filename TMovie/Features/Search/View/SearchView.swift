//
//  ContentView.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 15/10/25.
//

import SwiftUI
import SwiftData

struct SearchView: View {
	@StateObject var viewModel = SearchViewModel()

    var body: some View {
		NavigationStack {
            List {
                
            }
			.searchable(text: $viewModel.query, suggestions: {
				Text("Suggestion")
					.onTapGesture {
						viewModel.query = "Suggestion"
					}
			})
			.onChange(of: viewModel.debouncedQuery) { _, newValue in
				print(newValue)
			}
			.navigationTitle(Text("Search Movie"))
        }
    }
}

#Preview {
	SearchView()
}
