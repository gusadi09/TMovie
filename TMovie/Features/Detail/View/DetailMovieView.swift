//
//  DetailMovieView.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 21/10/25.
//

import SwiftUI

struct DetailMovieView: View {
	private let id: UInt
	let headerHeight: CGFloat = 280
	
	@StateObject private var viewModel = DetailMovieViewModel()
	
	init(with id: UInt) {
		self.id = id
	}
	
	var body: some View {
		GeometryReader { proxy in
			ScrollView {
				if viewModel.dataSwitcher() == nil && !viewModel.isLoading {
					emptyMovieView(proxy: proxy)
						.listRowSeparator(.hidden)
						.frame(height: proxy.size.height/2)
						.listRowInsets(.init(top: proxy.size.height/3, leading: 16, bottom: 16, trailing: 16))
				} else if viewModel.isLoading {
					loadingView()
						.listRowSeparator(.hidden)
						.frame(height: proxy.size.height/2)
						.listRowInsets(.init(top: proxy.size.height/3, leading: 16, bottom: 16, trailing: 16))
				} else {
					LazyVStack(alignment: .leading, spacing: 0) {
						GeometryReader { geo in
							let offset = geo.frame(in: .global).minY
							
							ImageLoader(
								path: (viewModel.dataSwitcher()?.backdropPath).orEmpty(),
								width: UIScreen.main.bounds.width,
								height: headerHeight + (offset > 0 ? offset : 0)
							)
							.frame(
								width: UIScreen.main.bounds.width,
								height: headerHeight + (offset > 0 ? offset : 0)
							)
							.clipped()
							.offset(y: (offset > 0 ? -offset : 0))
						}
						.frame(height: headerHeight)
						.ignoresSafeArea(edges: [.horizontal])
						
						HStack(alignment: .top, spacing: 15) {
							ImageLoader(
								path: (viewModel.dataSwitcher()?.posterPath).orEmpty(),
								width: 120,
								height: 180
							)
							.clipShape(RoundedRectangle(cornerRadius: 10))
							.shadow(color: .primary.opacity(0.3), radius: 8)
							.padding(.leading)
							.offset(y: -20)
							.frame(height: 140)
							
							VStack(alignment: .leading, spacing: 8) {
								Text((viewModel.dataSwitcher()?.title).orEmpty())
									.font(.system(size: 22, weight: .semibold))
									.multilineTextAlignment(.leading)
									.lineLimit(2)
									.padding(.top)
								
								Text(viewModel.releaseTag())
									.font(.system(size: 12, weight: .medium))
									.foregroundStyle(.white)
									.padding(8)
									.background(
										Color.blue
									)
									.clipShape(RoundedRectangle(cornerRadius: 8))
								
								HStack(spacing: 5) {
									Image(systemName: "star.fill")
										.font(.system(size: 16, weight: .bold, design: .rounded))
										.foregroundStyle(.yellow)
									
									Text(viewModel.voteAverage())
										.font(.system(size: 12, weight: .medium))
								}
							}
							.padding(.trailing)
						}
						
						VStack(alignment: .leading, spacing: 8) {
							Text("Overview")
								.font(.system(size: 14, weight: .bold))
							
							Text((viewModel.dataSwitcher()?.overview).orEmpty())
								.font(.system(size: 12))
						}
						.padding()
						
						VStack(alignment: .leading, spacing: 0) {
							Text("Production Companies")
								.font(.system(size: 14, weight: .bold))
								.padding(.horizontal)
							
							ScrollView(.horizontal, showsIndicators: false) {
								HStack(spacing: 10) {
									ForEach(viewModel.productionCompanies(), id: \.companyId) { company in
										VStack(spacing: 8) {
											ImageLoader(
												path: company.logoPath.orEmpty(),
												width: 120,
												height: 120
											)
											.clipShape(RoundedRectangle(cornerRadius: 10))
											.background(
												RoundedRectangle(cornerRadius: 10)
													.foregroundStyle(.background)
													.shadow(color: .primary.opacity(0.2), radius: 5)
											)
											
											Text(company.name.orEmpty())
												.font(.system(size: 12))
												.lineLimit(2)
												.multilineTextAlignment(.center)
										}
										.frame(width: 120)
									}
								}
								.padding(.horizontal)
								.padding(.vertical, 8)
							}
						}
						.padding(.bottom)
					}
				}
			}
			.refreshable(action: {
				await viewModel.detail(from: id)
				await viewModel.getLocalData(with: id)
				await viewModel.getFavorites()
			})
			.task {
				await viewModel.detail(from: id)
				await viewModel.getLocalData(with: id)
				await viewModel.getFavorites()
			}
		}
		.toolbarBackgroundVisibility(.visible, for: .navigationBar)
		.toolbar {
			ToolbarItem(placement: .topBarTrailing) {
				Button {
					Task {
						await viewModel.switchFavoriteButton(id: id)
					}
				} label: {
					Image(systemName: viewModel.startIcon(id: id))
						.font(.system(size: 16, weight: .regular, design: .rounded))
						.foregroundStyle(.yellow)
				}
			}
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

extension DetailMovieView {
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
				
				Text("Currently, there is no movie detail with this ID either in offline or online mode")
					.font(.system(size: 16, weight: .medium))
					.multilineTextAlignment(.center)
			}
			
			Spacer()
		}
	}
}

#Preview {
	DetailMovieView(with: 550)
}
