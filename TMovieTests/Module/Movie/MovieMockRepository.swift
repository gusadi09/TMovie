//
//  MovieMockRepository.swift
//  TMovieTests
//
//  Created by Ewide Dev 5 on 20/10/25.
//

@testable import TMovie

final class MovieMockRepository: MovieRepository {
	private let local: MovieLocalDataSource
	private let remote: MovieRemoteDataSource
	
	init(
		remote: MovieRemoteDataSource = MovieMockRemoteDataSource(),
		local: MovieLocalDataSource = MovieMockLocalDataSource()
	) {
		self.remote = remote
		self.local = local
	}
	
	func search(from query: RemoteMovie.Request.Search) async throws -> RemoteMovie.Response.List {
		try await self.remote.searchMovies(body: query)
	}
	
	func removeAllSearchMovie() async throws {
		try await self.local.removeAllSearchMovie()
	}
	
	func getRecentsSearchMovie() async throws -> [Movie] {
		try await self.local.getRecentsSearchMovie()
	}
	
	func saveRecentsSearchMovie(_ movie: RemoteMovie.Response.MovieListed) async throws {
		try await self.local.saveRecentsSearchMovie(movie)
	}
}
