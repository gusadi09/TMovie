//
//  TMovieExtensionTests.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation
import Testing
@testable import TMovie

struct TMovieExtensionTests {
	struct SimpleData: Codable {
		let key: String
	}
	
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
	
	@Test func encodeModelToData() async throws {
		let model = SimpleData(key: "value")
		
		let data = model.toJSONData()
		
		do {
			let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
			
			#expect(dict?["key"] as? String == "value")
		} catch {
			print("❌ JSON parse error:", error)
		}
	}
	
	@Test func encodeModelToDictionary() async throws {
		let model = SimpleData(key: "value")
		
		let data = model.toJSON()
		
		#expect(data["key"] as? String == "value")
	}
}
