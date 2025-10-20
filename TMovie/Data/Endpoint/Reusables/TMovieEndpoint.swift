//
//  TMovieEndpoint.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation

protocol TMovieEndpoint: Endpoint {
	var parameters: [String: Any] {
		get
	}
}

extension TMovieEndpoint {
	public var baseURL: URL {
		return URL(string: "https://api.themoviedb.org/3") ?? (NSURL() as URL)
	}
	
	var parameterEncoding: ParameterEncoding {
		JSONEncoding.default
	}
	
	var task: NetworkTask {
		return .requestParameters(parameters: parameters, encoding: parameterEncoding)
	}
	
	public var headers: [String: String]? {
		return [:]
	}
	
	var authorizationType: AuthorizationType {
		.none
	}
}
