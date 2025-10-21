//
//  AppModelContainer.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 13/08/25.
//

import Foundation
import SwiftData

final class AppModelContainer {
    static let shared = AppModelContainer()
    
    var modelContainer: ModelContainer = {
        let schema = Schema([
			Movie.self,
			SearchQuery.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var mockModelContainer: ModelContainer = {
        let schema = Schema([
			Movie.self,
			SearchQuery.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
