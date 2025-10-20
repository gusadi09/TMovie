//
//  ImageLoader.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import SwiftUI

struct ImageLoader: View {
	let path: String
	let width: CGFloat
	let height: CGFloat
	
	init(path: String, width: CGFloat = .infinity, height: CGFloat = .infinity) {
		self.path = path
		self.width = width
		self.height = height
	}
	
    var body: some View {
		AsyncImage(
			url: URL(string: "https://image.tmdb.org/t/p/original\(path)")
		) { phase in
			switch phase {
			case .empty:
				Color.gray
					.overlay(content: {
						ProgressView()
							.progressViewStyle(.circular)
							.tint(.white)
					})
					.frame(width: width, height: height)
			case .success(let image):
				image
					.resizable()
					.scaledToFill()
					.frame(width: width, height: height)
			case .failure:
				Color.gray
					.overlay(content: {
						Image(systemName: "exclamationmark.circle")
							.resizable()
							.scaledToFit()
							.frame(width: width/3)
							.foregroundStyle(.white)
					})
					.frame(width: width, height: height)
			default:
				Color.gray
					.overlay(content: {
						Image(systemName: "exclamationmark.circle")
							.resizable()
							.scaledToFit()
							.frame(width: width/3)
							.foregroundStyle(.white)
					})
					.frame(width: width, height: height)
			}
		}
		.scaledToFill()
		.frame(width: width, height: height)
    }
}

#Preview {
	ImageLoader(path: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg", width: 150, height: 120)
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.clipped()
}
