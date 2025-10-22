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
	var movieId: UInt?
	var originalTitle: String?
	var releaseDate: String?
	var title: String?
	var voteAverage: Float?
	var voteCount: UInt?
	
	init(_ movie: RemoteMovie.Response.MovieListed) {
		self.adult = movie.adult
		self.posterPath = movie.posterPath
		self.movieId = movie.id
		self.originalTitle = movie.originalTitle
		self.releaseDate = movie.releaseDate
		self.title = movie.title
		self.voteAverage = movie.voteAverage
		self.voteCount = movie.voteCount
	}
	
	init(
		adult: Bool?,
		posterPath: String?,
		movieId: UInt?,
		originalTitle: String?,
		releaseDate: String?,
		title: String?,
		voteAverage: Float?,
		voteCount: UInt?
	) {
		self.adult = adult
		self.posterPath = posterPath
		self.movieId = movieId
		self.originalTitle = originalTitle
		self.releaseDate = releaseDate
		self.title = title
		self.voteAverage = voteAverage
		self.voteCount = voteCount
	}
}

@Model
final class MovieDetail {
	var movieId: UInt?
	var adult: Bool?
	var backdropPath: String?
	var budget: UInt?
	@Relationship(deleteRule: .cascade) var genres: [MovieGenre]
	var homepage: String?
	var imdbId: String?
	var originalLanguage: String?
	var originalTitle: String?
	var overview: String?
	var popularity: Float?
	var posterPath: String?
	@Relationship(deleteRule: .cascade) var productionCompanies: [MovieProductionCompany]
	@Relationship(deleteRule: .cascade) var productionCountries: [MovieProductionCountry]
	var releaseDate: String?
	var revenue: UInt?
	var runtime: UInt?
	@Relationship(deleteRule: .cascade) var spokenLanguages: [MovieSpokenLanguage]
	var status: String?
	var tagline: String?
	var title: String?
	var video: Bool?
	var voteAverage: Float?
	var voteCount: UInt?
	
	init(_ detail: RemoteMovie.Response.Detail) {
		self.movieId = detail.id
		self.adult = detail.adult
		self.backdropPath = detail.backdropPath
		self.budget = detail.budget
		self.genres = detail.genres.compactMap({ genre in
			MovieGenre(genreId: genre.id, name: genre.name)
		})
		self.homepage = detail.homepage
		self.imdbId = detail.imdbId
		self.originalLanguage = detail.originalLanguage
		self.originalTitle = detail.originalTitle
		self.overview = detail.overview
		self.popularity = detail.popularity
		self.posterPath = detail.posterPath
		self.productionCompanies = detail.productionCompanies.compactMap({ company in
			MovieProductionCompany(companyId: company.id, logoPath: company.logoPath, name: company.name, originCountry: company.originCountry)
		})
		self.productionCountries = detail.productionCountries.compactMap({ country in
			MovieProductionCountry(iso3166_1: country.iso3166_1, name: country.name)
		})
		self.releaseDate = detail.releaseDate
		self.revenue = detail.revenue
		self.runtime = detail.runtime
		self.spokenLanguages = detail.spokenLanguages.compactMap({ lang in
			MovieSpokenLanguage(englishName: lang.englishName, iso639_1: lang.iso639_1, name: lang.name)
		})
		self.status = detail.status
		self.tagline = detail.tagline
		self.title = detail.title
		self.video = detail.video
		self.voteAverage = detail.voteAverage
		self.voteCount = detail.voteCount
	}
	
	init(
		movieId: UInt?,
		adult: Bool?,
		backdropPath: String?,
		budget: UInt?,
		genres: [MovieGenre],
		homepage: String?,
		imdbId: String?,
		originalLanguage: String?,
		originalTitle: String?,
		overview: String?,
		popularity: Float?,
		posterPath: String?,
		productionCompanies: [MovieProductionCompany],
		productionCountries: [MovieProductionCountry],
		releaseDate: String?,
		revenue: UInt?,
		runtime: UInt?,
		spokenLanguages: [MovieSpokenLanguage],
		status: String?,
		tagline: String?,
		title: String?,
		video: Bool?,
		voteAverage: Float?,
		voteCount: UInt?
	) {
		self.movieId = movieId
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
final class MovieGenre {
	var genreId: UInt?
	var name: String?
	
	init(genreId: UInt? = nil, name: String? = nil) {
		self.genreId = genreId
		self.name = name
	}
}

@Model
final class MovieProductionCompany {
	var companyId: UInt?
	var logoPath: String?
	var name: String?
	var originCountry: String?
	
	init(companyId: UInt? = nil, logoPath: String? = nil, name: String? = nil, originCountry: String? = nil) {
		self.companyId = companyId
		self.logoPath = logoPath
		self.name = name
		self.originCountry = originCountry
	}
}

@Model
final class MovieProductionCountry {
	var iso3166_1: String?
	var name: String?
	
	init(iso3166_1: String? = nil, name: String? = nil) {
		self.iso3166_1 = iso3166_1
		self.name = name
	}
}

@Model
final class MovieSpokenLanguage {
	var englishName: String?
	var iso639_1: String?
	var name: String?
	
	init(englishName: String? = nil, iso639_1: String? = nil, name: String? = nil) {
		self.englishName = englishName
		self.iso639_1 = iso639_1
		self.name = name
	}
}

@Model
final class FavoriteMovie {
	var favoriteId: UUID
	@Relationship(deleteRule: .cascade) var movie: Movie
	
	init(favoriteId: UUID = UUID(), movie: Movie) {
		self.favoriteId = favoriteId
		self.movie = movie
	}
}
