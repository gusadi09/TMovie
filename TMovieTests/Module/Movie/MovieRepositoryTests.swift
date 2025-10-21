//
//  Movie.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation
import Testing
@testable import TMovie

struct MovieRepositoryTests {
	private let sutMock: MovieRepository = MovieMockRepository()
	private let sut: MovieRepository = MovieDefaultRepository()
	
	@Test func requestSearch_mockSuccess() async throws {
		do {
			let data = try await sutMock.search(from: RemoteMovie.Request.Search(query: "Fight", page: 1))
			
			#expect(data.results.count > 0)
		} catch {
			Issue.record(error, "Unexpected result")
		}
	}
	
	@Test func requestSearch_integrationTest() async throws {
		guard KeychainManager.shared.save(token: "[TMDB_ACCESS_TOKEN_AUTH]") else { return }
		
		do {
			let data = try await sut.search(from: RemoteMovie.Request.Search(query: "Conjuring", page: 1))
			#expect(data.results.count > 0)
		} catch let error as NetworkError {
			Issue.record(error, "❌ Unknown error: \(error.localizedDescription)")
		} catch {
			Issue.record(error, "❌ Unknown error: \(error.localizedDescription)")
		}
	}
	
	@Test func saveLastSearchMovie_toLocal() async throws {
		do {
			let data = try await sutMock.search(from: RemoteMovie.Request.Search(query: "Fight", page: 1))
			
			for item in data.results {
				try await self.sutMock.saveRecentsSearchMovie(item)
			}
			
			let localData = try await self.sutMock.getRecentsSearchMovie()
			
			#expect(!localData.isEmpty)
		} catch {
			Issue.record(error, "Unexpected result")
		}
	}
}
