//
//  Item.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 12/08/25.
//

import Foundation
import SwiftData

@Model
final class Movie {
	var adult: Bool?
	var posterPath: String?
	var id: UInt?
	var originalTitle: String?
	var releaseDate: String?
	var title: String?
	var voteAverage: Float?
	var voteCount: UInt?
	
	init(_ movie: RemoteMovie.Response.MovieListed) {
		self.adult = movie.adult
		self.posterPath = movie.posterPath
		self.id = movie.id
		self.originalTitle = movie.originalTitle
		self.releaseDate = movie.releaseDate
		self.title = movie.title
		self.voteAverage = movie.voteAverage
		self.voteCount = movie.voteCount
	}
	
	init(
		adult: Bool?,
		posterPath: String?,
		id: UInt?,
		originalTitle: String?,
		releaseDate: String?,
		title: String?,
		voteAverage: Float?,
		voteCount: UInt?
	) {
		self.adult = adult
		self.posterPath = posterPath
		self.id = id
		self.originalTitle = originalTitle
		self.releaseDate = releaseDate
		self.title = title
		self.voteAverage = voteAverage
		self.voteCount = voteCount
	}
}

@Model
final class SearchQuery {
	var query: String
	
	init(query: String) {
		self.query = query
	}
}
