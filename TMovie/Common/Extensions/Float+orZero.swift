//
//  Float+orZero.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 22/10/25.
//

import Foundation

extension Optional where Wrapped == Float {
	func orZero() -> Float {
		return self ?? 0.0
	}
}
