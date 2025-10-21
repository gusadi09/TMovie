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
		}
	}
}
