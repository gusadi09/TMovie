//
//  MovieRemoteDataSource.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation

protocol MovieRemoteDataSource {
	func searchMovies(body: RemoteMovie.Request.Search) async throws -> RemoteMovie.Response.List
}
