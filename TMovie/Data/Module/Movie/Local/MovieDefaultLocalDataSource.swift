//
//  MovieDefaultLocalDataSource.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 21/10/25.
//

import Foundation
import SwiftData

final class MovieDefaultLocalDataSource: MovieLocalDataSource {
	private let context: AppModelContainer
	
	init(context: AppModelContainer = AppModelContainer.shared) {
		self.context = context
	}
	
	@MainActor
	func getRecentsSearchMovie() async throws -> [Movie] {
		let data = try context.modelContainer.mainContext.fetch(FetchDescriptor<Movie>())
		
		return data
	}
	
	@MainActor
	func saveRecentsSearchMovie(_ movie: RemoteMovie.Response.MovieListed) async throws {
		let movieItem = Movie(movie)
		context.modelContainer.mainContext.insert(movieItem)
		
		try context.modelContainer.mainContext.save()
	}
	
	@MainActor
	func removeAllSearchMovie() async throws {
		let fetchDescriptor = FetchDescriptor<Movie>()
		let users = try context.modelContainer.mainContext.fetch(fetchDescriptor)
		
		for user in users {
			context.modelContainer.mainContext.delete(user)
		}
		
		try context.modelContainer.mainContext.save()
	}
	
	@MainActor
	func getMovieDetails() async throws -> [MovieDetail] {
		let data = try context.modelContainer.mainContext.fetch(FetchDescriptor<MovieDetail>())
		
		return data
	}
	
	@MainActor
	func saveMovieDetail(_ movie: RemoteMovie.Response.Detail) async throws {
		let movieItem = MovieDetail(movie)
		context.modelContainer.mainContext.insert(movieItem)
		
		try context.modelContainer.mainContext.save()
	}
	
	@MainActor
	func removeMovieDetail(id: UInt) async throws {
		let fetchDescriptor = FetchDescriptor<MovieDetail>()
		let users = try context.modelContainer.mainContext.fetch(fetchDescriptor)
		
		for user in users where user.movieId == id {
			context.modelContainer.mainContext.delete(user)
		}
		
		try context.modelContainer.mainContext.save()
	}
	
	@MainActor
	func getFavoriteMovie() async throws -> [FavoriteMovie] {
		let data = try context.modelContainer.mainContext.fetch(FetchDescriptor<FavoriteMovie>())
		
		return data
	}
	
	@MainActor
	func saveFavoriteMovie(_ movie: RemoteMovie.Response.MovieListed) async throws {
		let movieItem = FavoriteMovie(movie: Movie(movie))
		context.modelContainer.mainContext.insert(movieItem)
		
		try context.modelContainer.mainContext.save()
	}
	
	@MainActor
	func removeFavoriteMovie(id: UInt) async throws {
		let fetchDescriptor = FetchDescriptor<FavoriteMovie>()
		let users = try context.modelContainer.mainContext.fetch(fetchDescriptor)
		
		for user in users where user.movie.movieId == id {
			context.modelContainer.mainContext.delete(user)
		}
		
		try context.modelContainer.mainContext.save()
	}
}
