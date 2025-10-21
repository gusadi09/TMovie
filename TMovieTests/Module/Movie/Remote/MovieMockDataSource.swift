//
//  MovieMockDataSource.swift
//  TMovieTests
//
//  Created by Ewide Dev 5 on 20/10/25.
//

@testable import TMovie

final class MovieMockRemoteDataSource: MovieRemoteDataSource {
	private let provider: NetworkProvider<MovieEndpoint>
	
	init(provider: NetworkProvider<MovieEndpoint> = NetworkProvider(stubBehavior: .delayed(5))) {
		self.provider = provider
	}
	
	func searchMovies(body: RemoteMovie.Request.Search) async throws -> RemoteMovie.Response.List {
		try await self.provider.request(.search(body), model: RemoteMovie.Response.List.self)
	}
}
