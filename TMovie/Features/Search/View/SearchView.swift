//
//  ContentView.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 15/10/25.
//

import SwiftUI
import SwiftData

struct SearchView: View {
	@StateObject private var viewModel = SearchViewModel()
	@StateObject private var networkMonitor = NetworkMonitor.shared
	
	@Namespace var transition

    var body: some View {
		NavigationStack {
			GeometryReader { proxy in
				List {
					if viewModel.isLoading {
						loadingView()
						.listRowSeparator(.hidden)
						.listRowInsets(.init(top: proxy.size.height/3, leading: 16, bottom: 16, trailing: 16))
					} else if viewModel.movieItems.isEmpty {
						emptyMovieView(proxy: proxy)
						.listRowSeparator(.hidden)
						.listRowInsets(.init(top: proxy.size.height/3, leading: 16, bottom: 16, trailing: 16))
					} else {
						ForEach(viewModel.movieItems) { movie in
							NavigationLink {
								DetailMovieView()
									.navigationTransition(.zoom(sourceID: movie, in: transition))
							} label: {
								movieCard(with: movie, proxy: proxy)
									.matchedTransitionSource(id: movie, in: transition)
							}
							.listRowSeparator(.hidden)
							.onAppear {
								if viewModel.isAddPage(on: movie) {
									viewModel.search.page += 1
								}
							}
						}
						
						if viewModel.isPageLoading {
							HStack {
								Spacer()
								
								ProgressView()
									.progressViewStyle(.circular)
								
								Spacer()
							}
						}
					}
				}
				.listStyle(.plain)
				.searchable(text: $viewModel.query)
			}
			.onChange(of: viewModel.search.query) { _, _ in
				Task {
					if networkMonitor.isConnected {
						await viewModel.search(onRefresh: true)
					} else {
						await viewModel.getLocalData()
					}
				}
			}
			.onChange(of: viewModel.search.page) { _, _ in
				Task {
					if networkMonitor.isConnected {
						await viewModel.search(isPaging: true)
					}
				}
			}
			.navigationTitle(Text("Search Movie"))
			.task {
				guard !viewModel.isMoviesExisting() && networkMonitor.isConnected else {
					await viewModel.getLocalData()
					return
				}
				await viewModel.search()
			}
			.onChange(of: networkMonitor.isConnected, { _, newConnection in
				viewModel.lostConnection = !newConnection
			})
			.alert("Oops Something went wrong!", isPresented: $viewModel.isError) {
				VStack {
					Button("OK", role: .cancel, action: {})
				}
			} message: {
				VStack {
					Text(viewModel.errrorMessage.orEmpty())
				}
			}
			.alert("Internet Connection was Gone", isPresented: $viewModel.lostConnection) {
				VStack {
					Button("OK", role: .cancel, action: {})
				}
			} message: {
				VStack {
					Text("Don't worry your last search result will be saved and you can search again. You will be able to search other than last search once internet connection is back.")
				}
			}

        }
    }
}

extension SearchView {
	@ViewBuilder
	func loadingView() -> some View {
		HStack {
			Spacer()
			
			VStack(spacing: 10) {
				ProgressView()
					.progressViewStyle(.circular)
				
				Text("Loading...")
					.font(.system(size: 16, weight: .medium))
					.multilineTextAlignment(.center)
			}
			
			Spacer()
		}
	}
	
	@ViewBuilder
	func emptyMovieView(proxy: GeometryProxy) -> some View {
		let isLandscape = proxy.size.width > proxy.size.height
		let imageWidth = isLandscape ? proxy.size.width/8 : proxy.size.width/5
		
		HStack {
			Spacer()
			
			VStack(spacing: 10) {
				Image(systemName: "exclamationmark.circle")
					.resizable()
					.scaledToFit()
					.frame(width: imageWidth)
				
				Text("Your search seems empty or there is no movie found")
					.font(.system(size: 16, weight: .medium))
					.multilineTextAlignment(.center)
			}
			
			Spacer()
		}
	}
	
	@ViewBuilder
	func movieCard(
		with movie: RemoteMovie.Response.MovieListed,
		proxy: GeometryProxy
	) -> some View {
		let isLandscape = proxy.size.width > proxy.size.height
		let imageWidth = isLandscape ? proxy.size.width/8 : proxy.size.width/5
		let imageHeight = isLandscape ? proxy.size.height/2.5 : proxy.size.height/6
		
		HStack {
			ImageLoader(
				path: movie.posterPath.orEmpty(),
				width: imageWidth,
				height: imageHeight
			)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			
			VStack(alignment: .leading, spacing: 8) {
				Text(movie.title.orEmpty())
					.font(.system(size: 16, weight: .bold))
					.lineLimit(2)
				
				Text("Release on \((movie.releaseDate.orEmpty().toDate(with: .yyyyMMdd)).toString(with: .ddMMyyyy))")
					.font(.system(size: 12, weight: .medium))
					.foregroundStyle(.white)
					.padding(8)
					.background(
						Color.blue
					)
					.clipShape(RoundedRectangle(cornerRadius: 8))
			}
			.multilineTextAlignment(.leading)
			
			Spacer()
		}
	}
}

#Preview {
	SearchView()
}
