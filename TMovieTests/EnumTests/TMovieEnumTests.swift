//
//  TMovieEnumTests.swift
//  TMovieTests
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Testing
@testable import TMovie

struct TMovieEnumTests {
	@Test func networkError_messageNotEmpty() async throws {
		let error: [NetworkError] = [
			.invalidURL,
			.decodingError(DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Test"))),
			.invalidResponse
		]
		
		for e in error {
			#expect(!(e.message.isEmpty))
		}
	}
	
	@Test func keychainKey_keyNotEmpty() async throws {
		let key: [KeychainKey] = [.authToken]
		
		for k in key {
			#expect(!(k.key.isEmpty))
		}
	}
}
