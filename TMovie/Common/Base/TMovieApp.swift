//
//  TMovieApp.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 15/10/25.
//

import SwiftUI
import SwiftData

@main
struct TMovieApp: App {
	
	init() {
		guard KeychainManager.shared.save(token: "[TMDB_ACCESS_TOKEN_AUTH]") else { return }
	}
	
    var body: some Scene {
        WindowGroup {
			TabContainerView()
        }
    }
}
