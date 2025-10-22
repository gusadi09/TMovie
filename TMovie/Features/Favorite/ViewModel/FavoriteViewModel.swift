//
//  FavoriteViewModel.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 22/10/25.
//

import Foundation

final class FavoriteViewModel: ObservableObject {
	private let repository: MovieRepository
	@Published var movieItems: [RemoteMovie.Response.MovieListed] = []
	
	@Published var isLoading = false
	@Published var isError = false
	@Published var errorMessage: String?
	
	init(repository: MovieRepository = MovieDefaultRepository()) {
		self.repository = repository
	}
	
	@MainActor
	func getLocalData() async {
		isLoading = true
		isError = false
		errorMessage = nil
		
		do {
			let movies = try await repository.getRecentsSearchMovie()
			
			isLoading = false
			
			self.movieItems = movies.compactMap({ movie in
				RemoteMovie.Response.MovieListed(movie)
			})
		} catch {
			isLoading = false
			isError = true
			errorMessage = error.localizedDescription
		}
	}
}
