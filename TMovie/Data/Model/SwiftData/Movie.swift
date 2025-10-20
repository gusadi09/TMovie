//
//  Item.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 12/08/25.
//

import Foundation
import SwiftData

@Model
final class Movie {
    var movieId: String
	
	init(movieId: String) {
		self.movieId = movieId
	}
}
