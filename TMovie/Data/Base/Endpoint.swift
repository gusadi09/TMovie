//
//  Endpoint.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 13/08/25.
//

import Foundation

protocol Endpoint {
	var baseURL: URL { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var task: NetworkTask { get }
	var headers: [String: String]? { get }
	var authorizationType: AuthorizationType { get }
	var sampleData: Data { get }
}
