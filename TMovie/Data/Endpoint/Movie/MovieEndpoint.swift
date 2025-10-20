//
//  MovieEndpoint.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation

enum MovieEndpoint {
	case search
}

extension MovieEndpoint: TMovieEndpoint {
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
		case .search:
			return [:]
		}
	}
	
	var path: String {
		switch self {
		case .search:
			return ""
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
			return Data()
		}
	}
}
