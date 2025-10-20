//
//  RecipeProvider.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 13/08/25.
//

import Foundation
import SwiftData

final class NetworkProvider<T: Endpoint> {
	func request(_ target: T) async throws -> Data {
		var request = URLRequest(url: target.baseURL.appendingPathComponent(target.path))
		request.httpMethod = target.method.rawValue
		target.headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
		
		if target.authorizationType == .bearer, let token = KeychainManager.shared.getToken() {
			request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		}
		
		switch target.task {
		case .requestPlain:
			break
		case .requestParameters(let parameters, let encoding):
			request = try encoding.encode(request, with: parameters)
		}
		
		let (data, response) = try await URLSession.shared.data(for: request)
		guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
			throw NetworkError.invalidResponse
		}
		
		return data
	}
}
