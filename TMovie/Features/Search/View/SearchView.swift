//
//  ContentView.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 15/10/25.
//

import SwiftUI
import SwiftData

struct SearchView: View {
	@Environment(\.horizontalSizeClass) var horizontalSizeClass
	@StateObject var viewModel = SearchViewModel()

    var body: some View {
		NavigationStack {
			GeometryReader { proxy in
				List {
					NavigationLink {
						EmptyView()
					} label: {
						movieCard(proxy: proxy)
					}
					.listRowSeparator(.hidden)
				}
				.listStyle(.plain)
				.searchable(text: $viewModel.query, suggestions: {
					Text("Suggestion")
						.onTapGesture {
							viewModel.query = "Suggestion"
						}
				})
			}
			.onChange(of: viewModel.debouncedQuery) { _, newValue in
				print(newValue)
			}
			.navigationTitle(Text("Search Movie"))
        }
    }
}

extension SearchView {
	@ViewBuilder
	func movieCard(proxy: GeometryProxy) -> some View {
		let isLandscape = proxy.size.width > proxy.size.height
		let imageWidth = isLandscape ? proxy.size.width/8 : proxy.size.width/5
		let imageHeight = isLandscape ? proxy.size.height/2.5 : proxy.size.height/6
		
		HStack {
			ImageLoader(
				path: "/rQfX2xx8TUoNvyk892yKWNikJaM.jpg",
				width: imageWidth,
				height: imageHeight
			)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			
			VStack(alignment: .leading, spacing: 8) {
				Text("The Conjuring")
					.font(.system(size: 16, weight: .bold))
				
				Text("Release on \(Date().toString(with: .ddMMyyyy))")
					.font(.system(size: 12, weight: .medium))
					.foregroundStyle(.white)
					.padding(8)
					.background(
						Color.blue
					)
					.clipShape(RoundedRectangle(cornerRadius: 8))
			}
			
			Spacer()
		}
	}
}

#Preview {
	SearchView()
}
