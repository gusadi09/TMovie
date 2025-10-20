//
//  Endpoint.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 13/08/25.
//

import Foundation

enum Task {
	case requestPlain
	case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

protocol ParameterEncoding {
	func encode(_ request: URLRequest, with parameters: [String: Any]) throws -> URLRequest
}

struct URLEncoding: ParameterEncoding {
	static let `default` = URLEncoding()
	public init() {}
	public func encode(_ request: URLRequest, with parameters: [String : Any]) throws -> URLRequest {
		guard var components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false) else {
			return request
		}
		components.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
		var req = request
		req.url = components.url
		return req
	}
}

struct JSONEncoding: ParameterEncoding {
	static let `default` = JSONEncoding()
	public init() {}
	public func encode(_ request: URLRequest, with parameters: [String : Any]) throws -> URLRequest {
		var req = request
		req.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
		req.addValue("application/json", forHTTPHeaderField: "Content-Type")
		return req
	}
}

enum AuthorizationType {
	case none
	case bearer
}

protocol Endpoint {
	var baseURL: URL { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var task: Task { get }
	var headers: [String: String]? { get }
	var authorizationType: AuthorizationType { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
