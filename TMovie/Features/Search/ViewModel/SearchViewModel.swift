//
//  SearchViewModel.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 15/10/25.
//

import Combine
import Foundation

final class SearchViewModel: ObservableObject {
	@Published var query = ""
	@Published var debouncedQuery = ""
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		$query
			.debounce(for: .milliseconds(600), scheduler: DispatchQueue.main)
			.assign(to: \.debouncedQuery, on: self)
			.store(in: &cancellables)
	}
}
