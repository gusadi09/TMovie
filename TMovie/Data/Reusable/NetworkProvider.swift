//
//  RecipeProvider.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 13/08/25.
//

import Foundation
import SwiftData

final class NetworkProvider<T: Endpoint> {
	private let stubBehavior: StubBehavior
	
	init(stubBehavior: StubBehavior = .never) {
		self.stubBehavior = stubBehavior
	}
	
	func request<Model: Codable>(_ target: T, model: Model.Type) async throws -> Model {
		let data: Data
		
		switch stubBehavior {
		case .never:
			data = try await performNetworkRequest(target)
		case .immediate:
			data = target.sampleData
		case .delayed(let seconds):
			try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
			data = target.sampleData
		}
		
		let jsonDecoder = JSONDecoder()
		let formatter = DateFormatter()
		formatter.dateFormat = "YYYY-MM-DD"
		jsonDecoder.dateDecodingStrategy = .formatted(formatter)
		
		do {
			return try jsonDecoder.decode(Model.self, from: data)
		} catch {
			throw NetworkError.decodingError(error)
		}
	}
	
	func requestRaw(_ target: T) async throws -> Data {
		switch stubBehavior {
		case .never:
			return try await performNetworkRequest(target)
		case .immediate:
			return target.sampleData
		case .delayed(let seconds):
			try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
			return target.sampleData
		}
	}
	
	func performNetworkRequest(_ target: T) async throws -> Data {
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
