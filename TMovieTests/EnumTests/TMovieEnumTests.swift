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
			.unauthorized,
			.noData,
			.invalidURL,
			.invalidResponse,
			.custom("TEST ERROR"),
			.decodingError(DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "TEST"))),
			.requestFailed,
			.statusCode(404, data: nil)
		]
		
		for e in error {
			#expect(!(e.messsage.isEmpty))
		}
	}
	
	@Test func keychainKey_keyNotEmpty() async throws {
		let key: [KeychainKey] = [.authToken]
		
		for k in key {
			#expect(!(k.key.isEmpty))
		}
	}
}
