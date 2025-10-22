//
//  DetailMovieViewModel.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 21/10/25.
//

import Combine
import Foundation

final class DetailMovieViewModel: ObservableObject {
	private let repository: MovieRepository
	private let networkMonitor = NetworkMonitor.shared
	private var cancellables = Set<AnyCancellable>()
	
	@Published var scrollPosition: CGFloat = 0
	
	@Published var isLoading = false
	@Published var isError = false
	@Published var errrorMessage: String?
	
	@Published var detail: RemoteMovie.Response.Detail?
	@Published var localDetail: MovieDetail?
	
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
	func detail(from id: UInt) async {
		self.isLoading = true
		
		self.isError = false
		self.errrorMessage = nil
		
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
			self.errrorMessage = error.messsage
		} catch {
			self.isLoading = false
			
			self.isError = true
			self.errrorMessage = error.localizedDescription
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
}
