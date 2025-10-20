//
//  RemoteRecipe.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 13/08/25.
//

import Foundation

enum RemoteMovie {
	enum Response {}
	enum Request {}
}

extension RemoteMovie.Response {
	struct List: Codable {
		let page: UInt?
		let results: [MovieListed]
		let totalPages: UInt?
		let totalResults: UInt?
		
		enum CodingKeys: String, CodingKey {
			case page
			case results
			case totalPages = "total_pages"
			case totalResults = "total_results"
		}
	}
	
	struct MovieListed: Codable, Identifiable, Hashable {
		let adult: Bool?
		let posterPath: String?
		let id: UInt?
		let originalTitle: String?
		let releaseDate: String?
		let title: String?
		let voteAverage: Float?
		let voteCount: UInt?
		
		enum CodingKeys: String, CodingKey {
			case adult
			case posterPath = "poster_path"
			case id
			case originalTitle = "original_title"
			case releaseDate = "release_date"
			case title
			case voteAverage = "vote_average"
			case voteCount = "vote_count"
		}
	}
	
	struct Detail: Codable, Identifiable, Hashable {
		let id: UInt?
		let adult: Bool?
		let backdropPath: String?
		let budget: UInt?
		let genres: [Genre]
		let homepage: URL?
		let imdbId: String?
		let originalLanguage: String?
		let originalTitle: String?
		let overview: String?
		let popularity: Float?
		let posterPath: String?
		let productionCompanies: [ProductionCompany]
		let productionCountries: [ProductionCountry]
		let releaseDate: String?
		let revenue: UInt?
		let runtime: UInt?
		let spokenLanguages: [SpokenLanguage]
		let status: String?
		let tagline: String?
		let title: String?
		let video: Bool?
		let voteAverage: Float?
		let voteCount: UInt?
		
		enum CodingKeys: String, CodingKey {
			case id
			case adult
			case backdropPath = "backdrop_path"
			case budget
			case genres
			case homepage
			case imdbId
			case originalLanguage = "original_language"
			case originalTitle = "original_title"
			case overview
			case popularity
			case posterPath = "poster_path"
			case productionCompanies = "production_companies"
			case productionCountries = "production_countries"
			case releaseDate = "release_date"
			case revenue
			case runtime
			case spokenLanguages = "spoken_languages"
			case status
			case tagline
			case title
			case video
			case voteAverage = "vote_average"
			case voteCount = "vote_count"
		}
	}
	
	struct Genre: Codable, Identifiable, Hashable {
		let id: UInt?
		let name: String?
	}
	
	struct ProductionCompany: Codable, Identifiable, Hashable {
		let id: UInt?
		let logoPath: String?
		let name: String?
		let originCountry: String?
		
		enum CodingKeys: String, CodingKey {
			case id
			case logoPath = "logo_path"
			case name
			case originCountry = "origin_country"
		}
	}
	
	struct ProductionCountry: Codable, Hashable {
		let iso3166_1: String?
		let name: String?
		
		enum CodingKeys: String, CodingKey {
			case iso3166_1 = "iso_3166_1"
			case name
		}
	}
	
	struct SpokenLanguage: Codable, Hashable {
		let englishName: String?
		let iso639_1: String?
		let name: String?
		
		enum CodingKeys: String, CodingKey {
			case englishName = "english_name"
			case iso639_1 = "iso_639_1"
			case name
		}
	}
}

extension RemoteMovie.Request {
	struct Search: Codable, Equatable {
		var query: String
		var page: UInt
	}
	
	struct Detail: Codable, Equatable {
		var movieId: UInt
		
		enum CodingKeys: String, CodingKey {
			case movieId = "movie_id"
		}
	}
}
