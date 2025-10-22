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
	@Published var errorMessage: String?
	@Published var lostConnection: Bool = false
	
	@Published var movies: RemoteMovie.Response.List?
	@Published var movieItems: [RemoteMovie.Response.MovieListed] = []
	
	@Published var query = ""
	
	init(repository: MovieRepository = MovieDefaultRepository()) {
		self.repository = repository
		
		$query
			.debounce(for: .milliseconds(720), scheduler: DispatchQueue.main)
			.assign(to: \.search.query, on: self)
			.store(in: &cancellables)
	}
	
	func onFirstLoad(on networkMonitor: Bool) async {
		if !networkMonitor {
			await getLocalData()
		}
		
		guard !isMoviesExisting() else {
			return
		}
		await search()
	}
	
	func isAddPage(on current: RemoteMovie.Response.MovieListed) -> Bool {
		current.id == movies?.results.last?.id && search.page < (movies?.totalPages).orZero()
	}
	
	func isMoviesExisting() -> Bool {
		!movieItems.isEmpty
	}
	
	@MainActor
	func getLocalData() async {
		isError = false
		errorMessage = nil
		
		do {
			let movies = try await repository.getRecentsSearchMovie()
			
			self.movieItems = movies.compactMap({ movie in
				RemoteMovie.Response.MovieListed(movie)
			}).filter({ movie in
				movie.title?.lowercased().contains(search.query.lowercased()) ?? false
			})
		} catch {
			isError = true
			errorMessage = error.localizedDescription
		}
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
		self.errorMessage = nil
		
		guard KeychainManager.shared.save(token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYjQxMzdiMjFlY2E2MThhNzFiMTg3NDFhZGEwMDQyMSIsIm5iZiI6MTc2MDUyNjU4OS41NzksInN1YiI6IjY4ZWY4MGZkMzk1ZjQ3NjRiODJiZTk5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1GWjIdQQRsI1M72W17IdGSmPwYoBXVmbpTLi9J4h9bc") else { return }
		
		do {
			let movies = try await repository.search(from: self.search)
			
			if !search.query.isEmpty {
				try await repository.removeAllSearchMovie()
			}
			
			if !isPaging {
				self.isLoading = false
				self.movieItems = movies.results
			} else {
				self.isPageLoading = false
				self.movieItems += movies.results
			}
			
			for item in movieItems where !search.query.isEmpty {
				try await repository.saveRecentsSearchMovie(item)
			}
			
			self.movies = movies
		} catch let error as NetworkError {
			if !isPaging {
				self.isLoading = false
			} else {
				self.isPageLoading = false
			}
			
			self.isError = true
			self.errorMessage = error.messsage
		} catch {
			if !isPaging {
				self.isLoading = false
			} else {
				self.isPageLoading = false
			}
			
			self.isError = true
			self.errorMessage = error.localizedDescription
		}
	}
}
