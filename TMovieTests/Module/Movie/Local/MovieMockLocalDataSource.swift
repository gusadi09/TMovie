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
}
