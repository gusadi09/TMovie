//
//  TMovieExtensionTests.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Testing
@testable import TMovie

struct TMovieExtensionTests {
	@Test func optionalString_onEmpty() async throws {
		let optionalString: String? = nil
		
		#expect(optionalString.orEmpty().isEmpty)
	}
	
	@Test func optionalBool_onEmpty() async throws {
		let optionalBool: Bool? = nil
		
		#expect(!(optionalBool.orFalse()))
	}
	
	@Test func optionalUInt_onEmpty() async throws {
		let optionalUInt: UInt? = nil
		
		#expect(optionalUInt.orZero() == 0)
	}
}
