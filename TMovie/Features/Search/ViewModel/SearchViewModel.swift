//
//  SearchViewModel.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 15/10/25.
//

import Combine
import Foundation

final class SearchViewModel: ObservableObject {
	private let repository: MovieRepository
	private var cancellables = Set<AnyCancellable>()
	
	@Published var search: RemoteMovie.Request.Search = .init(query: "", page: 1)
	@Published var isLoading = false
	@Published var isPageLoading = false
	@Published var isError = false
	@Published var errrorMessage: String?
	
	@Published var movies: RemoteMovie.Response.List?
	@Published var movieItems: [RemoteMovie.Response.MovieListed] = []
	
	@Published var query = ""
	
	init(repository: MovieRepository = MovieDefaultRepository()) {
		self.repository = repository
		
		$query
			.debounce(for: .milliseconds(600), scheduler: DispatchQueue.main)
			.assign(to: \.search.query, on: self)
			.store(in: &cancellables)
	}
	
	func isAddPage(on current: RemoteMovie.Response.MovieListed) -> Bool {
		current.id == movies?.results.last?.id && search.page < (movies?.totalPages).orZero()
	}
	
	func isMoviesExisting() -> Bool {
		!movieItems.isEmpty
	}
	
	@MainActor
	func search(onRefresh: Bool = false, isPaging: Bool = false) async {
		if onRefresh {
			self.movieItems = []
			self.search.page = 1
		}
		
		if !isPaging {
			self.isLoading = true
			self.movieItems = []
		} else {
			self.isPageLoading = true
		}
		
		self.isError = false
		self.errrorMessage = nil
		
		guard KeychainManager.shared.save(token: "[TMDB_ACCESS_TOKEN_AUTH]") else { return }
		
		do {
			let movies = try await repository.search(from: self.search)
			
			if !isPaging {
				self.isLoading = false
				self.movieItems = movies.results
			} else {
				self.isPageLoading = false
				self.movieItems += movies.results
			}
			
			self.movies = movies
		} catch let error as NetworkError {
			if !isPaging {
				self.isLoading = false
			} else {
				self.isPageLoading = false
			}
			
			self.isError = true
			print(error)
			self.errrorMessage = error.messsage
		} catch {
			if !isPaging {
				self.isLoading = false
			} else {
				self.isPageLoading = false
			}
			
			self.isError = true
			print(error)
			self.errrorMessage = error.localizedDescription
		}
	}
}
