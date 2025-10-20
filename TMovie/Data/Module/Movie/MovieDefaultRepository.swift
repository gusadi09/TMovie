//
//  MovieDefaultRepository.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation

final class MovieDefaultRepository: MovieRepository {
	private let remote: MovieRemoteDataSource
	
	init(remote: MovieRemoteDataSource = MovieDefaultRemoteDataSource()) {
		self.remote = remote
	}
	
	func search(from query: RemoteMovie.Request.Search) async throws -> RemoteMovie.Response.List {
		try await self.remote.searchMovies(body: query)
	}
}
