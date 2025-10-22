//
//  KeychainManager.swift
//  RecipeBuddy
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation
import Security

final class KeychainManager {
	static let shared = KeychainManager()
	
	private init() {}
	
	func save(token: String, for key: String = KeychainKey.authToken.key) -> Bool {
		guard let data = token.data(using: .utf8) else { return false }
		
		delete(for: key)
		
		let query: [String: Any] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrAccount as String: key,
			kSecValueData as String: data,
			kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
		]
		
		return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
	}
	
	func getToken(for key: String = KeychainKey.authToken.key) -> String? {
		let query: [String: Any] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrAccount as String: key,
			kSecReturnData as String: true,
			kSecMatchLimit as String: kSecMatchLimitOne
		]
		
		var dataRef: AnyObject?
		let status = SecItemCopyMatching(query as CFDictionary, &dataRef)
		
		guard status == errSecSuccess, let data = dataRef as? Data,
			  let token = String(data: data, encoding: .utf8) else {
			return nil
		}
		
		return token
	}
	
	func delete(for key: String = KeychainKey.authToken.key) {
		let query: [String: Any] = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrAccount as String: key
		]
		SecItemDelete(query as CFDictionary)
	}
}
