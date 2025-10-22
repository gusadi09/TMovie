//
//  Movie.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation
import Testing
@testable import TMovie

@Suite(.serialized)
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
		guard KeychainManager.shared.save(token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYjQxMzdiMjFlY2E2MThhNzFiMTg3NDFhZGEwMDQyMSIsIm5iZiI6MTc2MDUyNjU4OS41NzksInN1YiI6IjY4ZWY4MGZkMzk1ZjQ3NjRiODJiZTk5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1GWjIdQQRsI1M72W17IdGSmPwYoBXVmbpTLi9J4h9bc") else { return }
		
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
	
	@Test func deleteLastSearchMovie_toLocal() async throws {
		do {
			let data = try await sutMock.search(from: RemoteMovie.Request.Search(query: "Fight", page: 1))
			
			for item in data.results {
				try await self.sutMock.saveRecentsSearchMovie(item)
			}
			
			try await self.sutMock.removeAllSearchMovie()
			
			let localData = try await self.sutMock.getRecentsSearchMovie()
			
			#expect(localData.isEmpty)
		} catch {
			Issue.record(error, "Unexpected result")
		}
	}
	
	@Test func movieDetail_mockSuccess() async throws {
		do {
			let data = try await sutMock.movieDetail(from: 550)
			
			#expect(data.id != nil)
		} catch {
			Issue.record(error, "Unexpected result")
		}
	}
	
	@Test func movieDetail_integrationTest() async throws {
		guard KeychainManager.shared.save(token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYjQxMzdiMjFlY2E2MThhNzFiMTg3NDFhZGEwMDQyMSIsIm5iZiI6MTc2MDUyNjU4OS41NzksInN1YiI6IjY4ZWY4MGZkMzk1ZjQ3NjRiODJiZTk5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1GWjIdQQRsI1M72W17IdGSmPwYoBXVmbpTLi9J4h9bc") else { return }
		
		do {
			let data = try await sut.movieDetail(from: 550)
			#expect(data.id != nil)
		} catch let error as NetworkError {
			Issue.record(error, "❌ Unknown error: \(error.localizedDescription)")
		} catch {
			Issue.record(error, "❌ Unknown error: \(error.localizedDescription)")
		}
	}
	
	@Test func saveMovieDetail_toLocal() async throws {
		do {
			let data = try await sutMock.movieDetail(from: 550)
			
			try await self.sutMock.saveMovieDetail(data)
			
			let localData = try await self.sutMock.getMovieDetails()
			
			#expect(!localData.isEmpty)
		} catch {
			Issue.record(error, "Unexpected result")
		}
	}
	
	@Test func deleteMovieDetail_toLocal() async throws {
		do {
			try await self.sutMock.removeMovieDetail(id: 550)
			
			let localData = try await self.sutMock.getMovieDetails()
			
			#expect(localData.isEmpty)
		} catch {
			Issue.record(error, "Unexpected result")
		}
	}
}
