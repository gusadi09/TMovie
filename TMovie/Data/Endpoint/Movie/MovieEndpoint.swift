//
//  MovieEndpoint.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation

enum MovieEndpoint {
	case search(RemoteMovie.Request.Search)
	case detail(UInt)
}

extension MovieEndpoint: TMovieEndpoint {
	var authorizationType: AuthorizationType {
		switch self {
		case .search, .detail:
			return .bearer
		}
	}
	
	var parameterEncoding: ParameterEncoding {
		switch self {
		case .search, .detail:
			return URLEncoding.default
		}
	}
	
	var task: NetworkTask {
		switch self {
		case .search, .detail:
			return .requestParameters(parameters: parameters, encoding: parameterEncoding)
		}
	}
	
	var parameters: [String : Any] {
		switch self {
		case .search(let query):
			return query.toJSON()
		case .detail:
			return [:]
		}
	}
	
	var path: String {
		switch self {
		case .search:
			return "/search/movie"
		case .detail(let id):
			return "/movie/\(id)"
		}
	}
	
	var method: HTTPMethod {
		switch self {
		case .search, .detail:
			return .get
		}
	}
	
	var sampleData: Data {
		switch self {
		case .search:
			return RemoteMovie.Response.List(
				page: 1,
				results: [
					RemoteMovie.Response.MovieListed(
						adult: false,
						posterPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
						id: 550,
						originalTitle: "Fight Club",
						releaseDate: "2025-12-25",
						title: "Fight Club",
						voteAverage: 8.433,
						voteCount: 26280
					)
				],
				totalPages: 1,
				totalResults: 1
			).toJSONData()
		case .detail(let id):
			return RemoteMovie.Response.Detail(
				id: id,
				adult: false,
				backdropPath: "/hZkgoQYus5vegHoetLkCJzb17zJ.jpg",
				budget: 63000000,
				genres: [],
				homepage: nil,
				imdbId: "tt0137523",
				originalLanguage: "en",
				originalTitle: "Fight Club",
				overview: "Fight Club",
				popularity: 61.416,
				posterPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
				productionCompanies: [],
				productionCountries: [],
				releaseDate: "2025-10-21",
				revenue: 100853753,
				runtime: 139,
				spokenLanguages: [],
				status: "Released",
				tagline: "Fight",
				title: "Fight Club",
				video: false,
				voteAverage: 8.433,
				voteCount: 26280
			).toJSONData()
		}
	}
}
