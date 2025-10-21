//
//  DetailMovieViewModel.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 21/10/25.
//

import Foundation

final class DetailMovieViewModel: ObservableObject {
	@Published var isLoading = false
	@Published var isError = false
	@Published var errrorMessage: String?
}
