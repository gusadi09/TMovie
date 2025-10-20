//
//  NetworkError.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 13/08/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
	case invalidURL
	case requestFailed(underlying: Error)
	case invalidResponse
	case statusCode(Int, data: Data?)
	case decodingError(Error)
	case noData
	case unauthorized
	case custom(String)
	
	var errorDescription: String {
		switch self {
		case .invalidURL:
			return "Something went wrong with the URL, please try again later."
		case .requestFailed(let underlying):
			return "Request failed: \(underlying.localizedDescription)"
		case .invalidResponse:
			return "Invalid response from server"
		case .statusCode(let code, let data):
			if let data,
			   let message = String(data: data, encoding: .utf8) {
				return "HTTP \(code): \(message)"
			} else {
				return "HTTP \(code)"
			}
		case .decodingError(let underlying):
			return "Failed to decode response: \(underlying.localizedDescription)"
		case .noData:
			return "No data received"
		case .unauthorized:
			return "Unauthorized – invalid or expired token"
		case .custom(let message):
			return message
		}
	}
}
