//
//  MovieDefaultRepository.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation

final class MovieDefaultRepository: MovieRepository {
	private let remote: MovieRemoteDataSource
	private let local: MovieLocalDataSource
	
	init(
		remote: MovieRemoteDataSource = MovieDefaultRemoteDataSource(),
		local: MovieLocalDataSource = MovieDefaultLocalDataSource()
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
	
	func movieDetail(from id: UInt) async throws -> RemoteMovie.Response.Detail {
		try await self.remote.movieDetail(from: id)
	}
	
	func getMovieDetails() async throws -> [MovieDetail] {
		try await self.local.getMovieDetails()
	}
	
	func saveMovieDetail(_ movie: RemoteMovie.Response.Detail) async throws {
		try await self.local.saveMovieDetail(movie)
	}
	
	func removeMovieDetail(id: UInt) async throws {
		try await self.local.removeMovieDetail(id: id)
	}
	
	func getFavoriteMovie() async throws -> [FavoriteMovie] {
		try await self.local.getFavoriteMovie()
	}
	
	func saveFavoriteMovie(_ movie: RemoteMovie.Response.MovieListed) async throws {
		try await self.local.saveFavoriteMovie(movie)
	}
	
	func removeFavoriteMovie(id: UInt) async throws {
		try await self.local.removeFavoriteMovie(id: id)
	}
}
