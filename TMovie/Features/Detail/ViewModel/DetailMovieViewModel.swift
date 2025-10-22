//
//  DetailMovieViewModel.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 21/10/25.
//

import Foundation

final class DetailMovieViewModel: ObservableObject {
	private let repository: MovieRepository
	private let networkMonitor = NetworkMonitor.shared
	
	@Published var scrollPosition: CGFloat = 0
	
	@Published var isLoading = false
	@Published var isError = false
	@Published var errorMessage: String?
	
	@Published var detail: RemoteMovie.Response.Detail?
	@Published var localDetail: MovieDetail?
	@Published var favoriteMovies: [FavoriteMovie] = []
	
	init(repository: MovieRepository = MovieDefaultRepository()) {
		self.repository = repository
	}
	
	@MainActor
	func getLocalData(with id: UInt) async {
		do {
			let movies = try await repository.getMovieDetails()
			
			self.localDetail = movies.first(where: { detail in
				detail.movieId == id
			})
		} catch {
			print("Error: \(error)")
		}
	}
	
	@MainActor
	func getFavorites() async {
		do {
			let favMovies = try await repository.getFavoriteMovie()
			self.favoriteMovies = favMovies
		} catch {
			isError = true
			errorMessage = error.localizedDescription
		}
	}
	
	@MainActor
	func detail(from id: UInt) async {
		self.isLoading = true
		
		self.isError = false
		self.errorMessage = nil
		
		do {
			let movie = try await repository.movieDetail(from: id)
			
			let details = try await repository.getMovieDetails()
			
			if details.contains(where: { $0.movieId == id }) {
				try await repository.removeMovieDetail(id: id)
			}
			
			try await repository.saveMovieDetail(movie)
			
			self.isLoading = false
			self.detail = movie
		} catch let error as NetworkError {
			self.isLoading = false
			
			self.isError = true
			self.errorMessage = error.messsage
			print(error)
		} catch {
			self.isLoading = false
			
			self.isError = true
			self.errorMessage = error.localizedDescription
			print(error)
		}
	}
	
	func dataSwitcher() -> MovieDetail? {
		if networkMonitor.isConnected {
			guard let detail = detail else { return nil }
			return MovieDetail(detail)
		} else {
			return localDetail
		}
	}
	
	func voteAverage() -> String {
		let average = String(format: "%.1f", (dataSwitcher()?.voteAverage).orZero())
		let count = (dataSwitcher()?.voteCount).orZero().toCurrenyWithoutSymbol()
		return "\(average)/10 (\(count))"
	}
	
	func releaseTag() -> String {
		"Release on \(((dataSwitcher()?.releaseDate).orEmpty().toDate(with: .yyyyMMdd)).toString(with: .ddMMyyyy))"
	}
	
	func productionCompanies() -> [MovieProductionCompany] {
		dataSwitcher()?.productionCompanies ?? []
	}
	
	func isMovieFavorite(id: UInt) -> Bool {
		return favoriteMovies.contains(where: { $0.movieId == id })
	}
	
	func startIcon(id: UInt) -> String {
		isMovieFavorite(id: id) ? "star.fill" : "star"
	}
	
	@MainActor
	func removeFromFavorite(id: UInt) async {
		do {
			try await repository.removeFavoriteMovie(id: id)
			
			let favMovies = try await repository.getFavoriteMovie()
			self.favoriteMovies = favMovies
		} catch {
			isError = true
			errorMessage = error.localizedDescription
		}
	}
	
	func switchFavoriteButton(id: UInt) async {
		isMovieFavorite(id: id) ? await removeFromFavorite(id: id) : await addToFavorite()
	}
	
	@MainActor
	func addToFavorite() async {
		guard let detail = dataSwitcher() else { return }
		let movie = RemoteMovie.Response.MovieListed(
			adult: detail.adult,
			posterPath: detail.posterPath,
			id: detail.movieId,
			originalTitle: detail.originalTitle,
			releaseDate: detail.releaseDate,
			title: detail.title,
			voteAverage: detail.voteAverage,
			voteCount: detail.voteCount
		)
		
		do {
			try await repository.saveFavoriteMovie(movie)
			
			let favMovies = try await repository.getFavoriteMovie()
			self.favoriteMovies = favMovies
		} catch {
			isError = true
			errorMessage = error.localizedDescription
		}
	}
}
