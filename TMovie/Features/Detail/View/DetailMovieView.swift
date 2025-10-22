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
		ScrollView {
			LazyVStack(alignment: .leading, spacing: 0) {
				GeometryReader { geo in
					let offset = geo.frame(in: .global).minY
					
					ImageLoader(
						path: "/hZkgoQYus5vegHoetLkCJzb17zJ.jpg",
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
				.ignoresSafeArea(edges: [.horizontal, .top])
				
				HStack(alignment: .top, spacing: 15) {
					ImageLoader(
						path: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
						width: 120,
						height: 180
					)
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.shadow(color: .primary.opacity(0.3), radius: 8)
					.padding(.leading)
					.offset(y: -20)
					.frame(height: 140)
					
					VStack(alignment: .leading, spacing: 8) {
						Text("Fight Club: The Last Rites 2025")
							.font(.system(size: 22, weight: .semibold))
							.multilineTextAlignment(.leading)
							.lineLimit(2)
							.padding(.top)
						
						Text("Release on \(("2025-10-23".toDate(with: .yyyyMMdd)).toString(with: .ddMMyyyy))")
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
							
							Text("8.6/10 (\(2000))")
								.font(.system(size: 12, weight: .medium))
						}
					}
					.padding(.trailing)
				}
				
				VStack(alignment: .leading, spacing: 8) {
					Text("Overview")
						.font(.system(size: 14, weight: .bold))
					
					Text("A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.")
						.font(.system(size: 12))
				}
				.padding()
				
				VStack(alignment: .leading, spacing: 8) {
					Text("Production Companies")
						.font(.system(size: 14, weight: .bold))
						.padding(.horizontal)
					
					ScrollView(.horizontal, showsIndicators: false) {
						HStack(spacing: 10) {
							ForEach(0...5, id: \.self) { idx in
								VStack(spacing: 8) {
									ImageLoader(
										path: "/tEiIH5QesdheJmDAqQwvtN60727.png",
										width: 120,
										height: 120
									)
									.clipShape(RoundedRectangle(cornerRadius: 10))
									
									Text("Fox 2000 Pictures")
										.font(.system(size: 12))
										.lineLimit(2)
										.multilineTextAlignment(.center)
								}
							}
						}
						.padding(.horizontal)
					}
				}
				.padding(.bottom)
			}
		}
	}
}

#Preview {
	DetailMovieView(with: 1038392)
}
