//
//  EncodingMethod.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation

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
