//
//  String+toDate.swift
//  TMovie
//
//  Created by Ewide Dev 5 on 20/10/25.
//

import Foundation

extension String {
	func toDate(with format: DateFormat) -> Date {
		let formatter = DateFormatter()
		formatter.dateFormat = format.rawValue
		formatter.locale = Locale(identifier: "en_US_POSIX")
		
		if let date = formatter.date(from: self) {
			return date
		} else {
			return Date()
		}
	}
}
