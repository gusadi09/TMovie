//
//  MovieLocalDataSource.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 21/10/25.
//

import Foundation

protocol MovieLocalDataSource {
	func getRecentsSearchMovie() async throws -> [Movie]
	func saveRecentsSearchMovie(_ movie: RemoteMovie.Response.MovieListed) async throws
	func removeAllSearchMovie() async throws
	func getMovieDetails() async throws -> [MovieDetail]
	func saveMovieDetail(_ movie: RemoteMovie.Response.Detail) async throws
	func removeMovieDetail(id: UInt) async throws
}
