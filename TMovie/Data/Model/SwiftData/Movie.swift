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
	var id: UInt
	var adult: Bool
	var backdropPath: String
	var budget: UInt
	@Relationship(deleteRule: .cascade) var genres = [Genre]()
	var homepage: URL
	var imdbId: String
	var originalLanguage: String
	var originalTitle: String
	var overview: String
	var popularity: Float
	var posterPath: String
	@Relationship(deleteRule: .cascade) var productionCompanies = [ProductionCompany]()
	@Relationship(deleteRule: .cascade) var productionCountries = [ProductionCountry]()
	var releaseDate: Date
	var revenue: UInt
	var runtime: UInt
	@Relationship(deleteRule: .cascade) var spokenLanguages = [SpokenLanguage]()
	var status: String
	var tagline: String
	var title: String
	var video: Bool
	var voteAverage: Float
	var voteCount: UInt
	
	init(
		id: UInt,
		adult: Bool,
		backdropPath: String,
		budget: UInt,
		genres: [Genre],
		homepage: URL,
		imdbId: String,
		originalLanguage: String,
		originalTitle: String,
		overview: String,
		popularity: Float,
		posterPath: String,
		productionCompanies: [ProductionCompany],
		productionCountries: [ProductionCountry],
		releaseDate: Date,
		revenue: UInt,
		runtime: UInt,
		spokenLanguages: [SpokenLanguage],
		status: String,
		tagline: String,
		title: String,
		video: Bool,
		voteAverage: Float,
		voteCount: UInt
	) {
		self.id = id
		self.adult = adult
		self.backdropPath = backdropPath
		self.budget = budget
		self.genres = genres
		self.homepage = homepage
		self.imdbId = imdbId
		self.originalLanguage = originalLanguage
		self.originalTitle = originalTitle
		self.overview = overview
		self.popularity = popularity
		self.posterPath = posterPath
		self.productionCompanies = productionCompanies
		self.productionCountries = productionCountries
		self.releaseDate = releaseDate
		self.revenue = revenue
		self.runtime = runtime
		self.spokenLanguages = spokenLanguages
		self.status = status
		self.tagline = tagline
		self.title = title
		self.video = video
		self.voteAverage = voteAverage
		self.voteCount = voteCount
	}
}

@Model
final class Genre {
	var id: UInt
	var name: String
	
	init(id: UInt, name: String) {
		self.id = id
		self.name = name
	}
}

@Model
final class ProductionCompany {
	var id: UInt
	var logoPath: String
	var name: String
	var originCountry: String
	
	init(id: UInt, logoPath: String, name: String, originCountry: String) {
		self.id = id
		self.logoPath = logoPath
		self.name = name
		self.originCountry = originCountry
	}
}

@Model
final class ProductionCountry {
	var iso3166_1: String
	var name: String
	
	init(iso3166_1: String, name: String) {
		self.iso3166_1 = iso3166_1
		self.name = name
	}
}

@Model
final class SpokenLanguage {
	var englishName: String
	var iso639_1: String
	var name: String
	
	init(englishName: String, iso639_1: String, name: String) {
		self.englishName = englishName
		self.iso639_1 = iso639_1
		self.name = name
	}
}

@Model
final class SearchQuery {
	var query: String
	
	init(query: String) {
		self.query = query
	}
}
