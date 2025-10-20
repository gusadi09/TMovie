//
//  MovieMockRepository.swift
//  TMovieTests
//
//  Created by Ewide Dev 5 on 20/10/25.
//

@testable import TMovie

final class MovieMockRepository: MovieRepository {
	private let remote: MovieRemoteDataSource
	
	init(remote: MovieRemoteDataSource = MovieMockRemoteDataSource()) {
		self.remote = remote
	}
	
	func search(from query: RemoteMovie.Request.Search) async throws -> RemoteMovie.Response.List {
		try await self.remote.searchMovies(body: query)
	}
}
