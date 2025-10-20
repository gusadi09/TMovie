//
//  MovieEndpoint.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation

enum MovieEndpoint {
	case search(RemoteMovie.Request.Search)
}

extension MovieEndpoint: TMovieEndpoint {
	var authorizationType: AuthorizationType {
		switch self {
		case .search:
			return .bearer
		}
	}
	
	var parameterEncoding: ParameterEncoding {
		switch self {
		case .search:
			return URLEncoding.default
		}
	}
	
	var task: NetworkTask {
		switch self {
		case .search:
			return .requestParameters(parameters: parameters, encoding: parameterEncoding)
		}
	}
	
	var parameters: [String : Any] {
		switch self {
		case .search(let query):
			return query.toJSON()
		}
	}
	
	var path: String {
		switch self {
		case .search:
			return "/search/movie"
		}
	}
	
	var method: HTTPMethod {
		switch self {
		case .search:
			return .get
		}
	}
	
	var sampleData: Data {
		switch self {
		case .search:
			return RemoteMovie.Response.List(
				page: 1,
				results: [
					RemoteMovie.Response.Detail(
						id: 550,
						adult: false,
						backdropPath: "/hZkgoQYus5vegHoetLkCJzb17zJ.jpg",
						budget: 63000000,
						genres: [
							RemoteMovie.Response.Genre(id: 18, name: "Drama")
						],
						homepage: URL(string: "http://www.foxmovies.com/movies/fight-club"),
						imdbId: "tt0137523",
						originalLanguage: "en",
						originalTitle: "Fight Club",
						overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy.",
						popularity: 61.416,
						posterPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
						productionCompanies: [
							RemoteMovie.Response.ProductionCompany(
								id: 508,
								logoPath: "/7cxRWzi4LsVm4Utfpr1hfARNurT.png",
								name: "Regency Enterprises",
								originCountry: "US"
							)
						],
						productionCountries: [
							RemoteMovie.Response.ProductionCountry(iso3166_1: "US", name: "United States of America")
						],
						releaseDate: Date(),
						revenue: 100853753,
						runtime: 139,
						spokenLanguages: [
							RemoteMovie.Response.SpokenLanguage(englishName: "English", iso639_1: "en", name: "English")
						],
						status: "Released",
						tagline: "Mischief. Mayhem. Soap.",
						title: "Fight Club",
						video: false,
						voteAverage: 8.433,
						voteCount: 26280
					)
				],
				totalPages: 1,
				totalResults: 1
			).toJSONData()
		}
	}
}
