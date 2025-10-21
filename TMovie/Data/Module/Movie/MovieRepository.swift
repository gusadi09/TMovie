//
//  MovieRepository.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation

protocol MovieRepository {
	func search(from query: RemoteMovie.Request.Search) async throws -> RemoteMovie.Response.List
	func getRecentsSearchMovie() async throws -> [Movie]
	func saveRecentsSearchMovie(_ movie: RemoteMovie.Response.MovieListed) async throws
	func removeAllSearchMovie() async throws
}
