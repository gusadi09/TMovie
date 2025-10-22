//
//  MovieMockLocalDataSource.swift
//  TMovieTests
//
//  Created by Ewide Dev 5 on 21/10/25.
//

@testable import TMovie
import Foundation
import SwiftData

final class MovieMockLocalDataSource: MovieLocalDataSource {
	private let context: AppModelContainer
	
	init(context: AppModelContainer = AppModelContainer.shared) {
		self.context = context
	}
	
	@MainActor
	func getRecentsSearchMovie() async throws -> [Movie] {
		let data = try context.mockModelContainer.mainContext.fetch(FetchDescriptor<Movie>())
		
		return data
	}
	
	@MainActor
	func saveRecentsSearchMovie(_ movie: RemoteMovie.Response.MovieListed) async throws {
		let movieItem = Movie(movie)
		context.mockModelContainer.mainContext.insert(movieItem)
		
		try context.mockModelContainer.mainContext.save()
	}
	
	@MainActor
	func removeAllSearchMovie() async throws {
		let fetchDescriptor = FetchDescriptor<Movie>()
		let users = try context.mockModelContainer.mainContext.fetch(fetchDescriptor)
		
		for user in users {
			context.mockModelContainer.mainContext.delete(user)
		}
		
		try context.mockModelContainer.mainContext.save()
	}
	
	
	@MainActor
	func getMovieDetails() async throws -> [MovieDetail] {
		let data = try context.mockModelContainer.mainContext.fetch(FetchDescriptor<MovieDetail>())
		
		return data
	}
	
	@MainActor
	func saveMovieDetail(_ movie: RemoteMovie.Response.Detail) async throws {
		let movieItem = MovieDetail(movie)
		context.mockModelContainer.mainContext.insert(movieItem)
		
		try context.mockModelContainer.mainContext.save()
	}
	
	@MainActor
	func removeMovieDetail(id: UInt) async throws {
		let fetchDescriptor = FetchDescriptor<MovieDetail>()
		let users = try context.mockModelContainer.mainContext.fetch(fetchDescriptor)
		
		for user in users where user.movieId == id {
			context.mockModelContainer.mainContext.delete(user)
		}
		
		try context.mockModelContainer.mainContext.save()
	}
}
