//
//  NetworkError.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 13/08/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Something went wrong with the URL, please try again later."
        case .invalidResponse:
            return "Something went wrong with the response, please try again later."
        case .decodingError(let error):
            return "Decoding Error: \(error.localizedDescription)"
        }
    }
}
