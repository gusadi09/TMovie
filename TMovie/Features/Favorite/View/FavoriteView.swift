//
//  FavoriteView.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 22/10/25.
//

import SwiftUI

struct FavoriteView: View {
	@StateObject private var viewModel = FavoriteViewModel()
	
	@Namespace var transition
	
    var body: some View {
		GeometryReader { proxy in
			List {
				if viewModel.movieItems.isEmpty {
					emptyMovieView(proxy: proxy)
						.listRowSeparator(.hidden)
						.listRowInsets(.init(top: proxy.size.height/3, leading: 16, bottom: 16, trailing: 16))
				} else {
					ForEach(viewModel.movieItems) { movie in
						NavigationLink {
							DetailMovieView(with: movie.id.orZero())
								.navigationTransition(.zoom(sourceID: movie, in: transition))
						} label: {
							movieCard(with: movie, proxy: proxy)
								.matchedTransitionSource(id: movie, in: transition)
						}
						.listRowSeparator(.hidden)
					}
				}
			}
			.listStyle(.plain)
			.refreshable {
				await viewModel.getLocalData()
			}
		}
		.navigationTitle(Text("Favorite Movie"))
		.task {
			await viewModel.getLocalData()
		}
		.alert("Oops Something went wrong!", isPresented: $viewModel.isError) {
			VStack {
				Button("OK", role: .cancel, action: {})
			}
		} message: {
			VStack {
				Text(viewModel.errorMessage.orEmpty())
			}
		}
    }
}

extension FavoriteView {
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
				
				Text("You don't have any favorite movies yet.")
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
    FavoriteView()
}
