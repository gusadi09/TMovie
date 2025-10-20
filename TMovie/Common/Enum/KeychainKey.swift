//
//  KeychainKey.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation

enum KeychainKey {
	case authToken
}

extension KeychainKey {
	var key: String {
		switch self {
		case .authToken:
			return "tmovie.auth.token"
		}
	}
}
